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

@interface CollectionPackViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray * expressionsPack;

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
    _singleCollectionView.backgroundColor = [UIColor redColor];
    _wholeCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(WindowWidth, 0, WindowWidth, WindowHeight) collectionViewLayout:flowLayout];
    _wholeCollectionView.backgroundColor = [UIColor orangeColor];
    //segment
    _segment = [[UISegmentedControl alloc]initWithItems:@[@"最新",@"分类"]];
    
    _segment.frame = CGRectMake(0, 0, WindowWidth, 30);
    
    
    [_segment addTarget:self action:@selector(segmentControClicked:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:_segment];
    _segment.selectedSegmentIndex = 0;//默认选中的索引为0
    
    /** 创建scrollView */
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,30,WindowWidth, WindowHeight)];
    _scrollView.backgroundColor = [UIColor magentaColor];
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


}

//获取当前用户收藏过的活动
- (void)getAllActivities
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.singleCollectionView) {
        SingleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SingleCollectionViewCell_Identify forIndexPath:indexPath];
        return cell;
    }else if (collectionView == self.wholeCollectionView)
    {
        WholeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WholeCollectionViewCell_Identify forIndexPath:indexPath];
        return cell;
    }
    return nil;
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
