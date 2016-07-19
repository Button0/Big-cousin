//
//  ExpressionPackageViewController.m
//  Big cousin
//
//  Created by HMS on 16/7/13.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "ExpressionLibraryViewController.h"
#import "SegmentView.h"
#import "VTCycleScrollView.h"
#import "LibraryCollectionViewCell.h"
#import "PublicCollectionViewController.h"
#import "HomeTitleModel.h"
#import "LibraryRequest.h"
#import "MoreExpressionViewController.h"
#import "SingleExpressionViewController.h"

#define KHeightCollection 120
#define KHeightCycleScrollView 180
@interface ExpressionLibraryViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ClickBtnDelegate>

/** 分页视图 */
@property (nonatomic, strong) SegmentView *segmentView;
/** libraryCollectionView 表情库的底视图 */
@property (nonatomic, strong) UICollectionView *libraryCollectionView;
/** 布局类型 */
@property (nonatomic, assign) NSInteger layoutType;
/** 首页标题 */
@property (nonatomic, strong) NSMutableArray *homeTitles;
@property (nonatomic, strong) NSMutableArray *expressions;
@property (nonatomic, strong) NSString *eId;

@end

@implementation ExpressionLibraryViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //导航栏图片
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 18)];
    image.image = [UIImage imageNamed:@"表情库"];
    self.navigationItem.titleView = image;

    [self addSegmentView];
    [self layoutSetting];
    
    [self requestHomeTitles];
    self.homeTitles = [NSMutableArray array];
    
    [self.libraryCollectionView registerNib:[UINib nibWithNibName:@"LibraryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:LibraryCollectionViewCell_Identity];
    [self.libraryCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
}


#pragma mark - UI
//分页
- (void)addSegmentView
{
    SegmentView *segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight-49)];
    [self.view addSubview:segmentView];
    self.segmentView = segmentView;
    
    PublicCollectionViewController *cv1 = [[PublicCollectionViewController alloc] init];
    cv1.url = NewestExpression_Url;
    [self addChildViewController:cv1];
    cv1.view.frame = CGRectMake(0, 0, WindowWidth, WindowHeight);
    
    PublicCollectionViewController *cv2 = [PublicCollectionViewController new];
    cv2.url = HottestExpression_Url;
    [self addChildViewController:cv2];
    cv2.view.frame = CGRectMake(0, 0, WindowWidth, WindowHeight);
    
    [self.segmentView.newestView addSubview:cv1.view];
    [self.segmentView.hottestView addSubview:cv2.view];
    
//    [_segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view.mas_top);
//        make.bottom.mas_equalTo(self.view.mas_bottom);
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.width.mas_equalTo(self.view.mas_width);
//    }];
}

//轮播图
- (UIView *)addCycleScrollView
{
    VTCycleScrollView *cycleScrollView = [[VTCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, WindowWidth, KHeightCycleScrollView)];
    return cycleScrollView;
}

- (void)layoutSetting
{
    self.layoutType = 0;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(WindowWidth-10, KHeightCollection);
    layout.sectionInset = UIEdgeInsetsMake(12, 5, 5, 5);
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, KHeightCycleScrollView);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    self.libraryCollectionView = collectionView;
    [self.segmentView.homeView addSubview:_libraryCollectionView];
    self.libraryCollectionView.backgroundColor = [UIColor whiteColor];
}


#pragma mark - libraryCollectionView init and Delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LibraryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LibraryCollectionViewCell_Identity forIndexPath:indexPath];
    
//    [cell addTapGestureRecognizerWithImage];
    cell.clickbtnDelegate = self;
    
    HomeTitleModel *homeModel = self.homeTitles[indexPath.row];
    [cell setTitleModel:homeModel];
    self.eId = homeModel.eId;
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.homeTitles.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    [headerView addSubview:[self addCycleScrollView]];
    return headerView;
}

//LibraryCollectionViewCell 手势代理
-(void)ClickBtn:(UIButton *)btn
{
    MoreExpressionViewController *moreVC = [[MoreExpressionViewController alloc]init];
    moreVC.url_ID = ExpressionLibrary_Url(_eId);
    [self.navigationController pushViewController:moreVC animated:YES];
}

-(void)cellPush:(UITapGestureRecognizer *)sender
{
    SingleExpressionViewController *singleVC = [[SingleExpressionViewController alloc]init];
    [self.navigationController pushViewController:singleVC animated:YES];
}

//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    SingleExpressionViewController *singleVC = [[SingleExpressionViewController alloc]init];
////    ExpressionLibraryModel *model = self.homeTitles[indexPath.row];
////    singleVC.expressionModel = model;
//    
//    [self.navigationController pushViewController:singleVC animated:YES];
//    
//}

#pragma mark - 数据
- (void)requestHomeTitles
{
    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    
    [manager GET:HomeTitle_Url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray*  _Nullable responseObject) {

        [self setupProgressHud];
//        NSLog(@"----%@",responseObject);
        NSMutableArray*array=responseObject.lastObject;
        for (NSMutableDictionary*dict in array)
        {
            HomeTitleModel*model=[HomeTitleModel new];
            [model setValuesForKeysWithDictionary:dict];
            [weakSelf.homeTitles addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.libraryCollectionView  reloadData];
        });
        [GiFHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"===%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
