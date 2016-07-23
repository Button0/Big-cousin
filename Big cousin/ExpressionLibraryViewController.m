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
#import "SingleExpressionViewController.h"
#import "HomeTitleModel.h"

#define KHeightCollection 120
#define KHeightCycleScrollView 180

@interface ExpressionLibraryViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ClickBtnDelegate, ClickImageDelegate>

/** 分页视图 */
@property (nonatomic, strong) SegmentView *segmentView;
/** libraryCollectionView 表情库的底视图 */
@property (nonatomic, strong) UICollectionView *libraryCollectionView;
/** 首页标题 */
@property (nonatomic, strong) NSMutableArray *homeTitles;
@property (nonatomic, strong) NSMutableArray *expressions;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *eIdHome;
@property (nonatomic, strong) NSNumber *single_eId;

@property (nonatomic, strong) NSString *coverUrl;
@property (nonatomic, strong) NSString *eName;
@property (nonatomic, strong) NSMutableArray<NSArray *> *libraries;
//@property (nonatomic, strong) NSMutableArray *homeTitle;

@end

@implementation ExpressionLibraryViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _homeTitles = [NSMutableArray array];
        _libraries = [[NSMutableArray alloc] init];
        _eIdHome = [NSMutableArray array];
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
    
    [self addSegmentView];
    [self layoutSetting];
    [self.libraryCollectionView registerNib:[UINib nibWithNibName:@"LibraryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:LibraryCollectionViewCell_Identity];
    [self.libraryCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [self requestHomeTitles];
}

//- (void)viewWillLayoutSubviews
//{
//    [super viewWillLayoutSubviews];
//}

#pragma mark - UI
//分页
- (void)addSegmentView
{
    _segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight-49)];
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
    cycleScrollView.imageDelegate = self;
    
    return cycleScrollView;
}

-(void)cycleImagePush:(UITapGestureRecognizer *)sender
{
    SingleExpressionViewController *singleVC = [[SingleExpressionViewController alloc]init];
    [self.navigationController pushViewController:singleVC animated:YES];
}

- (void)layoutSetting
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    layout.itemSize = CGSizeMake(WindowWidth-10, KHeightCollection);
    layout.sectionInset = UIEdgeInsetsMake(12, 5, 5, 5);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, KHeightCycleScrollView);
    
    _libraryCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight-130) collectionViewLayout:layout];
//    _libraryCollectionView.contentInset 
    _libraryCollectionView.delegate = self;
    _libraryCollectionView.dataSource = self;
    _libraryCollectionView.backgroundColor = [UIColor whiteColor];
    [_segmentView.homeView addSubview:_libraryCollectionView];
}


#pragma mark - libraryCollectionView DataSource and Delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LibraryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LibraryCollectionViewCell_Identity forIndexPath:indexPath];
    
    cell.clickbtnDelegate = self;
    
    HomeTitleModel *homeModel = self.homeTitles[indexPath.row];
    [cell setTitleModel:homeModel];
    cell.categoryId = [_eIdHome objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //分类数
    return self.homeTitles.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    [headerView addSubview:[self addCycleScrollView]];
    return headerView;
}

//LibraryCollectionViewCell 手势代理
-(void)ClickBtn:(UIButton *)button
{
    PublicCollectionViewController *moreVC = [[PublicCollectionViewController alloc]init];
    moreVC.url = ExpressionLibrary_Url(@(button.tag));
    [self.navigationController pushViewController:moreVC animated:YES];
}

- (void)passValue:(NSNumber *)aId
{
    self.single_eId = aId;
}

-(void)cellPush:(UITapGestureRecognizer *)sender
{
    SingleExpressionViewController *singleVC = [[SingleExpressionViewController alloc]init];
//    singleVC.expressionModel.eId = _single_eId;
    singleVC.single_Id = _single_eId;
//    NSLog(@"%@",SingleExpression_Url(_single_eId));
    [self.navigationController pushViewController:singleVC animated:YES];
}

#pragma mark - 数据
- (void)requestHomeTitles
{
    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    
    [manager GET:HomeTitle_Url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray*  _Nullable responseObject) {
        
        [self setupProgressHud];
        //        NSLog(@"----%@",responseObject);
        if (responseObject.count >= 3
            && [[responseObject objectAtIndex:2] isKindOfClass:[NSArray class]])
        {
            NSArray *categoryArray = [responseObject objectAtIndex:2];
            for (NSMutableDictionary *category in categoryArray)
            {
                HomeTitleModel *model = [[HomeTitleModel alloc] init];
                [model setValuesForKeysWithDictionary:category];
                [weakSelf.homeTitles addObject:model];
                [weakSelf.eIdHome addObject:model.eId];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.libraryCollectionView  reloadData];
            });
            [GiFHUD dismiss];
        }
        else
        {
            NSLog(@"Error: data error %@", responseObject);
        }
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
