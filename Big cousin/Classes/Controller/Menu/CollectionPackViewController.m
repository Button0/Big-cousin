//
//  shoucangViewController.m
//  Big cousin
//
//  Created by wuhan107 on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "CollectionPackViewController.h"
#import "DataBaseManager.h"
#import "SingleCollectionViewCell.h"
#import "WholeCollectionViewCell.h"
#import "SingleExpressionViewController.h"

@interface CollectionPackViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray * expressionsPack;
@property (nonatomic, strong) NSString *eId;


@property (strong, nonatomic) UICollectionView *singleCollectionView;

@property (strong, nonatomic) UICollectionView *wholeCollectionView;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UISegmentedControl *segment;

@end

@implementation CollectionPackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.title = @"收藏";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBarController.tabBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    //每个分区边缘的距离
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //每行显示个数
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width/3.5, 100);
    
    _singleCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight) collectionViewLayout:flowLayout];
    _singleCollectionView.backgroundColor = [UIColor whiteColor];
    _wholeCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(WindowWidth, 0, WindowWidth, WindowHeight) collectionViewLayout:flowLayout];
    _wholeCollectionView.backgroundColor = [UIColor whiteColor];
    
    _segment = [[UISegmentedControl alloc]initWithItems:@[@"pack",@"single"]];
    _segment.frame = CGRectMake(0, 0, WindowWidth, 30);
    _segment.tintColor = KColorGlyodin;
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14], NSForegroundColorAttributeName: [UIColor whiteColor]};
    [_segment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14], NSForegroundColorAttributeName: KColorDrakStoneBlue};
    [_segment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    [_segment addTarget:self action:@selector(segmentControClicked:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:_segment];
    _segment.selectedSegmentIndex = 0;//默认选中的索引为0
    
    /** 创建scrollView */
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,30,WindowWidth, WindowHeight)];
    [self.view addSubview:_scrollView];
    /** 设置scrollView的内容 */
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    /** 设置scrollView的代理 */
    _scrollView.delegate = self;
    _singleCollectionView.dataSource = self;
    _singleCollectionView.delegate = self;
    _wholeCollectionView.dataSource = self;
    _wholeCollectionView.delegate = self;
    
    [_scrollView addSubview:_singleCollectionView];
    [_scrollView addSubview:_wholeCollectionView];
    //注册cell
    [_singleCollectionView registerNib:[UINib nibWithNibName:@"SingleCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:SingleCollectionViewCell_Identify];
    [_wholeCollectionView registerNib:[UINib nibWithNibName:@"WholeCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:WholeCollectionViewCell_Identify];
    
    [self getAllExpressions];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable:) name:@"reloadTheTable" object:nil];

}

- (void)reloadTable:(NSNotification *)notification
{
    [_singleCollectionView reloadData];
    [_wholeCollectionView reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//获取当前用户收藏过的活动
- (void)getAllExpressions
{
    // 从数据库中读取活动对象数据
    self.expressionsPack = [[DataBaseManager shareInstance] selectAllExpressionPack];
    if (_expressionsPack.count == 0)
    {
        NSLog(@"暂无收藏！");
    }
}

- (void)segmentControClicked:(UISegmentedControl *)sender
{
    [self.scrollView setContentOffset:CGPointMake(sender.selectedSegmentIndex * WindowWidth, 0)];
}

#pragma mark ----------- scroller 的代理方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.segment.selectedSegmentIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
}

#pragma mark -----------collectionView 的代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _expressionsPack.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView == self.singleCollectionView) {
        SingleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SingleCollectionViewCell_Identify forIndexPath:indexPath];

        ExpressionLibraryModel *model  = [_expressionsPack objectAtIndex:indexPath.row];
        cell.eId = model.eId;
        return cell;
    }else if (collectionView == self.wholeCollectionView)
    {
        WholeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WholeCollectionViewCell_Identify forIndexPath:indexPath];
        return cell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SingleExpressionViewController *singleVC = [[SingleExpressionViewController alloc] init];
    ExpressionLibraryModel *model = self.expressionsPack[indexPath.row];
    singleVC.expressionModel = model;

    
    [self.navigationController pushViewController:singleVC animated:YES];

}


#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
