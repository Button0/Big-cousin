//
//  ExpressionPackageViewController.m
//  Big cousin
//
//  Created by HMS on 16/7/13.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "ExpressionLibraryViewController.h"
#import "SearchView.h"
#import "SegmentView.h"
#import "VTCycleScrollView.h"
#import "LibraryCollectionViewCell.h"
#import "CollectionViewController.h"

#define KHeightCollection 120
#define KHeightCycleScrollView 180
@interface ExpressionLibraryViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/** 分页视图 */
@property (nonatomic, strong) SegmentView *segmentView;
/** libraryCollectionView 表情库的底视图 */
@property (nonatomic, strong) UICollectionView *libraryCollectionView;
/** 布局类型 */
@property (nonatomic, assign) NSInteger layoutType;

@end

@implementation ExpressionLibraryViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;    
    //导航栏图片
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 18)];
    image.image = [UIImage imageNamed:@"表情库"];
    self.navigationItem.titleView = image;

    [self addSegmentView];
    [self layoutSetting];
    
    [self.libraryCollectionView registerNib:[UINib nibWithNibName:@"LibraryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:LibraryCollectionViewCell_Identity];
    [self.libraryCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    CollectionViewController *collectionView = [[CollectionViewController alloc] init];
    [self addChildViewController:collectionView];
    CollectionViewController *cv = [CollectionViewController new];
    [self addChildViewController:cv];
    
    collectionView.view.frame = CGRectMake(0, 0, WindowWidth, WindowHeight);
    [self.segmentView.newestView addSubview:collectionView.view];
    cv.view.frame = CGRectMake(0, 0, WindowWidth, WindowHeight);
    [self.segmentView.hottestView addSubview:cv.view];
}

#pragma mark - UI
//分页
- (void)addSegmentView
{
    SegmentView *segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight-49)];
    [self.view addSubview:segmentView];
    
    self.segmentView = segmentView;
    
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

#pragma mark - libraryCollectionView init and Delegate
- (void)layoutSetting
{
    //0 是一行显示2
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
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LibraryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LibraryCollectionViewCell_Identity forIndexPath:indexPath];
    

    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
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

#pragma mark - 最新视图


//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
//{
//    
//}

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
