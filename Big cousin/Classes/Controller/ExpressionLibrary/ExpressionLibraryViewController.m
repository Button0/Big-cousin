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
#import "MJRefresh.h"
#import "LGRefreshView.h"

#import "LYB_ChouTiViewController.h"
#import "smileViewController.h"
#import "smileBagViewController.h"
#import "goodsViewController.h"
#import "setViewController.h"
#import "CollectionPackViewController.h"

#define KHeightCollection 120
#define KHeightCycleScrollView self.view.bounds.size.height*0.35f

static const CGFloat MJDuration = 2.0;

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
    // 集成刷新控件
//    [self setupRefresh];
    [self update];
    
    // UI
    [self lifeMenu];
    [self addSegmentView];
    [self layoutSetting];
    [self.libraryCollectionView registerNib:[UINib nibWithNibName:@"LibraryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:LibraryCollectionViewCell_Identity];
    [self.libraryCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    //Data
//    [self requestHomeTitles];
}

-(void)setupRefresh
{
    //1.添加刷新控件
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    control.tintColor = [UIColor grayColor];
    control.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull down to reload!"];
    [control addTarget:self action:@selector(requestHomeTitles) forControlEvents:UIControlEventValueChanged];
    [_libraryCollectionView addSubview:control];
    
    //2.马上进入刷新状态，并不会触发UIControlEventValueChanged事件
    [control beginRefreshing];
    
    //3.加载数据
    [self requestHomeTitles:control];
//    [self requestHomeTitles];
    
    //抽屉相关
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"菜单.png"] style:UIBarButtonItemStylePlain target:self action:@selector(ClickShowMenu:)];
    [LYB_ChouTiViewController getMenuViewController].menuClickDelegate = self;
    
    
//    [self requestHomeTitles:control];
//    [self requestHomeTitles];
ExpressionLibrary/ExpressionLibraryViewController.m
}

- (void)update
{
    __weak __typeof(self) weakSelf = self;
    [self requestHomeTitles];
    
    // 下拉刷新
    _libraryCollectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestHomeTitles];
        
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.libraryCollectionView reloadData];
            
            // 结束刷新
            [weakSelf.libraryCollectionView.mj_header endRefreshing];
        });
    }];
    [self.libraryCollectionView.mj_header beginRefreshing];
}

#pragma mark - UI
- (void)lifeMenu
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
            shoucangViewController *shoucangVC = [[shoucangViewController alloc]init];
            [self.navigationController pushViewController:shoucangVC animated:YES];
        }
            break;
            
            
        default:
            break;
    }
    
    //抽屉相关
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"菜单.png"] style:UIBarButtonItemStylePlain target:self action:@selector(ClickShowMenu:)];
    [LYB_ChouTiViewController getMenuViewController].menuClickDelegate = self;
ExpressionLibrary/ExpressionLibraryViewController.m
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
-(void)ClickShowMenu:(UIBarButtonItem *)sender
{
    if ([LYB_ChouTiViewController getMenuViewController].isShowing) {
        [[LYB_ChouTiViewController getMenuViewController] hideLeftViewController];
    }else
    {
        [[LYB_ChouTiViewController getMenuViewController] showLeftViewController];
    }
}

//menuclick代理
-(void)ClickMenuIndex:(NSInteger)Index Title:(NSString *)title
{
    switch (Index) {
        case 0:
        {
            smileViewController *smileVC = [[smileViewController alloc]init];
            smileVC.title = title;
            [self.navigationController pushViewController:smileVC animated:YES];
        }
            break;
            
        case 1:
        {
            smileBagViewController *smileBagVC = [[smileBagViewController alloc]init];
            smileBagVC.title = title;
            [self.navigationController pushViewController:smileBagVC animated:YES];
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

-(void)ClickBut:(UIButton *)button
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
-(void)cycleImagePush:(UITapGestureRecognizer *)sender
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
        model.eId = [NSString stringWithFormat:@"%@",@(singleId)];
        singleVC.expressionModel = model;
        [self.navigationController pushViewController:singleVC animated:YES];
    }
}

- (void)requestHomeTitles//:(UIRefreshControl *)control
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
//            [control endRefreshing];
        });
        
    } failure:^(NSError *error) {
        NSLog(@"===%@",error);
//        [control endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
