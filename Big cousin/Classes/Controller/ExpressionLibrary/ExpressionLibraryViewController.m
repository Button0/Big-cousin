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
#import "LGRefreshView.h"

#import "LYB_ChouTiViewController.h"
#import "smileViewController.h"
#import "smileBagViewController.h"
#import "goodsViewController.h"
#import "setViewController.h"
#import "CollectionPackViewController.h"
#import "ChatViewController.h"
#import "WeiboViewController.h"

#define KHeightCollection 120
#define KHeightCycleScrollView self.view.bounds.size.height*0.3f

@interface ExpressionLibraryViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ClickBtnDelegate, ClickImageDelegate, MenuClickDelegate>

/** 分页视图 */
@property (nonatomic, strong) SegmentView *segmentView;
/** libraryCollectionView 表情库展示容器 */
@property (nonatomic, strong) UICollectionView *libraryCollectionView;
/** 首页标题 */
@property (nonatomic, strong) NSMutableArray *homeTitles;
/** 标题里的ID */
@property (nonatomic, strong) NSMutableArray<NSString *> *eIdHomes;

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
    
    self.title = @"表情库";
    
    // UI
    [self lifeMenu];
    [self addSegmentView];
    [self layoutSetting];
    [self.libraryCollectionView registerNib:[UINib nibWithNibName:@"LibraryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:LibraryCollectionViewCell_Identity];
    [self.libraryCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    //Data
    [self requestHomeTitles];
}


#pragma mark - UI
- (void)lifeMenu
{
    //抽屉相关
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:testView];
    
    UIButton *collectionBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    collectionBtn.frame = CGRectMake(0, 0, 22, 22);
    [testView addSubview:collectionBtn];
    [collectionBtn setImage:[UIImage imageNamed:@"meun"] forState:(UIControlStateNormal)];
    [collectionBtn addTarget:self action:@selector(ClickShowMenu:) forControlEvents:(UIControlEventTouchUpInside)];

    [LYB_ChouTiViewController getMenuViewController].menuClickDelegate = self;
}

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
    _libraryCollectionView.delegate = self;
    _libraryCollectionView.dataSource = self;
    _libraryCollectionView.backgroundColor = [UIColor whiteColor];
    _libraryCollectionView.alwaysBounceVertical = YES;
    _libraryCollectionView.allowsSelection = NO;
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


#pragma mark - 抽屉相关
//菜单按钮点击方法
- (void)ClickShowMenu:(UIBarButtonItem *)sender
{
    if ([LYB_ChouTiViewController getMenuViewController].isShowing) {
        [[LYB_ChouTiViewController getMenuViewController] hideLeftViewController];
    }else
    {
        [[LYB_ChouTiViewController getMenuViewController] showLeftViewController];
    }
}

//menuclick代理
- (void)ClickMenuIndex:(NSInteger)Index Title:(NSString *)title
{
    switch (Index) {
        case 0:
        {
            UIStoryboard *SB=[UIStoryboard storyboardWithName:@"Friends" bundle:[NSBundle mainBundle]];
            ChatViewController *chatVC=[SB instantiateViewControllerWithIdentifier:@"ChatViewController"];
            chatVC.title = title;
            [self.navigationController pushViewController:chatVC animated:YES];
        }
            break;
            
        case 1:
        {
            WeiboViewController *weiboVC = [[WeiboViewController alloc]init];
            weiboVC.title = title;

            [self.navigationController pushViewController:weiboVC animated:YES];
            
            
        }
            break;
            
        case 2:
        {
            goodsViewController *goodsVC = [[goodsViewController alloc]init];
            goodsVC.title = title;
            [self.navigationController pushViewController:goodsVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)ClickBut:(UIButton *)button
{
    switch (button.tag) {
        case 1000:
        {
            setViewController *setVC = [[setViewController alloc]init];
            [self.navigationController pushViewController:setVC animated:YES];
        }
            break;
        case 1001:
        {
            CollectionPackViewController *shoucangVC = [[CollectionPackViewController alloc]init];
            [self.navigationController pushViewController:shoucangVC animated:YES];
        }
            break;
        default:
            break;
    }
}


#pragma mark - 数据
//轮播图手势代理
- (void)cycleImagePush:(UITapGestureRecognizer *)sender
{
    UIView *targetView = sender.view;
    if (targetView
        && [targetView isKindOfClass:[UIImageView class]]
        && targetView.tag > 0)
    {
        SingleExpressionViewController *singleVC = [[SingleExpressionViewController alloc]init];
        ExpressionLibraryModel *model = [[ExpressionLibraryModel alloc] init];
        model.eId = [NSString stringWithFormat:@"%@",@(targetView.tag)];
        singleVC.expressionModel = model;

        [self.navigationController pushViewController:singleVC animated:YES];
    }
}

//LibraryCollectionViewCell 手势代理
- (void)ClickBtn:(UIButton *)button
{
    PublicCollectionViewController *moreVC = [[PublicCollectionViewController alloc]init];
    moreVC.url = ExpressionLibrary_Url(@(button.tag));
    [self.navigationController pushViewController:moreVC animated:YES];
}

//点击单个图片 跳转 且传入 被点击图片的ID 
- (void)cellPush:(UITapGestureRecognizer *)sender
{
    UIView *targetView = sender.view;
    if (targetView
        && [targetView isKindOfClass:[UIImageView class]]
        && targetView.tag > 0)
    {
        NSInteger singleId = targetView.tag;
        SingleExpressionViewController *singleVC = [[SingleExpressionViewController alloc]init];
        ExpressionLibraryModel *model = [[ExpressionLibraryModel alloc] init];
        model.eId = [NSString stringWithFormat:@"%@",@(singleId)];
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
