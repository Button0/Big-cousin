//
//  ExpressionPackageViewController.m
//  Big cousin
//
//  Created by Mushroom on 16/7/13.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "ExpressionLibraryViewController.h"
#import "SegmentView.h"
#import "VTCycleScrollView.h"
#import "LibraryCollectionViewCell.h"
#import "PublicCollectionViewController.h"
#import "SingleExpressionViewController.h"

#import "HomeTitleModel.h"
#import "LibraryRequest.h"

#define KHeightCollection 120
#define KHeightCycleScrollView self.view.bounds.size.height*0.4f

@interface ExpressionLibraryViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ClickBtnDelegate, ClickImageDelegate>

/** 分页视图 */
@property (nonatomic, strong) SegmentView *segmentView;
/** libraryCollectionView 表情库展示容器 */
@property (nonatomic, strong) UICollectionView *libraryCollectionView;
/** 首页标题 */
@property (nonatomic, strong) NSMutableArray *homeTitles;
/** 标题里的ID */
@property (nonatomic, strong) NSMutableArray<NSNumber *> *eIdHomes;

@end

@implementation ExpressionLibraryViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _homeTitles = [NSMutableArray array];
        _eIdHomes = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏图片
//    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 18)];
//    image.image = [UIImage imageNamed:@"表情库"];
//    self.navigationItem.titleView = image;
    self.title = @"表情库";
    //UI    
    [self addSegmentView];
    [self layoutSetting];
    [self.libraryCollectionView registerNib:[UINib nibWithNibName:@"LibraryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:LibraryCollectionViewCell_Identity];
    [self.libraryCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    //Data
    [self requestHomeTitles];
}


#pragma mark - UI
//分页容器
- (void)addSegmentView
{
    _segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight)];
    [self.view addSubview:_segmentView];
    
    PublicCollectionViewController *cv1 = [[PublicCollectionViewController alloc] init];
    cv1.url = NewestExpression_Url;
    cv1.view.frame = CGRectMake(0, 0, WindowWidth, WindowHeight);
    [self addChildViewController:cv1];
    
    PublicCollectionViewController *cv2 = [[PublicCollectionViewController alloc] init];
    cv2.url = HottestExpression_Url;
    cv2.view.frame = CGRectMake(0, 0, WindowWidth, WindowHeight);
    [self addChildViewController:cv2];
    
    [_segmentView.newestView addSubview:cv1.view];
    [_segmentView.hottestView addSubview:cv2.view];
}

//轮播图
- (UIView *)addCycleScrollView
{
    VTCycleScrollView *cycleScrollView = [[VTCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, WindowWidth, KHeightCycleScrollView)];
    NSLog(@"%@",NSStringFromCGRect(cycleScrollView.frame));
    cycleScrollView.imageDelegate = self;
    
    return cycleScrollView;
}

- (void)layoutSetting
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 15;
    layout.itemSize = CGSizeMake(WindowWidth-10, KHeightCollection);
    layout.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, KHeightCycleScrollView-20);

    _libraryCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight-130) collectionViewLayout:layout];
//    _libraryCollectionView.contentInset 
    _libraryCollectionView.delegate = self;
    _libraryCollectionView.dataSource = self;
    _libraryCollectionView.backgroundColor = [UIColor whiteColor];
    [_segmentView.homeView addSubview:_libraryCollectionView];
}


#pragma mark - libraryCollectionView DataSource and Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //分类数
    return self.homeTitles.count-1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LibraryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LibraryCollectionViewCell_Identity forIndexPath:indexPath];
    
    cell.clickbtnDelegate = self;
    
    HomeTitleModel *homeModel = self.homeTitles[indexPath.row];
    [cell setTitleModel:homeModel];
    cell.categoryId = [_eIdHomes objectAtIndex:indexPath.row]; //传入下一个点击ID
    
    return cell;
}

//头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    [headerView addSubview:[self addCycleScrollView]];
    return headerView;
}


#pragma mark - 数据
//轮播图手势代理
-(void)cycleImagePush:(UITapGestureRecognizer *)sender
{
    UIView *targetView = sender.view;
    if (targetView
        && [targetView isKindOfClass:[UIImageView class]]
        && targetView.tag > 0)
    {
        SingleExpressionViewController *singleVC = [[SingleExpressionViewController alloc]init];
        ExpressionLibraryModel *model = [[ExpressionLibraryModel alloc] init];
        model.eId = @(targetView.tag);
        singleVC.expressionModel = model;

        [self.navigationController pushViewController:singleVC animated:YES];
    }
}

//LibraryCollectionViewCell 手势代理
-(void)ClickBtn:(UIButton *)button
{
    PublicCollectionViewController *moreVC = [[PublicCollectionViewController alloc]init];
    moreVC.url = ExpressionLibrary_Url(@(button.tag));
    [self.navigationController pushViewController:moreVC animated:YES];
}

//点击单个图片 跳转 且传入 被点击图片的ID 
-(void)cellPush:(UITapGestureRecognizer *)sender
{
    UIView *targetView = sender.view;
    if (targetView
        && [targetView isKindOfClass:[UIImageView class]]
        && targetView.tag > 0)
    {
        NSInteger singleId = targetView.tag;
        SingleExpressionViewController *singleVC = [[SingleExpressionViewController alloc]init];
        ExpressionLibraryModel *model = [[ExpressionLibraryModel alloc] init];
        model.eId = @(singleId);
        singleVC.expressionModel = model;
        [self.navigationController pushViewController:singleVC animated:YES];
    }
}

- (void)requestHomeTitles
{
    __weak typeof(self) weakSelf = self;
    [[LibraryRequest shareLibraryRequest] requestHomeTitleSuccess:^(NSArray *arr) {
        [self setupProgressHud];
        NSMutableArray *tempArray = [HomeTitleModel parseTitlesWithArray:arr];
        weakSelf.homeTitles = tempArray[0];
        weakSelf.eIdHomes = tempArray[1];
        [GiFHUD dismiss];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.libraryCollectionView reloadData];
        });
        
    } failure:^(NSError *error) {
        NSLog(@"===%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
