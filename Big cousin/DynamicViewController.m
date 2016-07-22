//
//  DynamicViewController.m
//  Big cousin
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DynamicViewController.h"
#import "DrawingNewCollectionViewCell.h"
#import "DrawingHottestCollectionViewCell.h"
@interface DynamicViewController ()
<
    UIScrollViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout

>
/** 分页 */
@property (strong, nonatomic) UISegmentedControl *segment;
/** 滑动 */
@property (strong, nonatomic) UIScrollView *scrollView;
/** 最新 */
@property (strong, nonatomic) UICollectionView *newsCollection;
/** 最热 */
@property (strong, nonatomic) UICollectionView *hottestCollection;



@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //间距
    //    flowLayout.minimumInteritemSpacing = 1;
    //行距
    flowLayout.minimumLineSpacing = 20;
    //每个分区边缘的距离
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //每行显示个数
    flowLayout.itemSize = CGSizeMake(100, 120);

    /** 初始化控制器 */
    _newsCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight) collectionViewLayout:flowLayout];
    _newsCollection.backgroundColor = [UIColor redColor];
    
    _hottestCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(WindowWidth, 0, WindowWidth, WindowHeight) collectionViewLayout:flowLayout];
    _hottestCollection.backgroundColor = [UIColor orangeColor];
    //分页
    _segment = [[UISegmentedControl alloc]initWithItems:@[@"最新",@"分类"]];
    
    self.navigationItem.titleView = self.segment;
    
    [_segment addTarget:self action:@selector(segmentControClicked:) forControlEvents:(UIControlEventValueChanged)];
    
    _segment.selectedSegmentIndex = 0;//默认选中的索引为0
    
    /** 创建scrollView */
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,WindowWidth, WindowHeight)];
    _scrollView.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:_scrollView];
    /** 设置scrollView的内容 */
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    
    [_scrollView addSubview:_newsCollection];
    [_scrollView addSubview:_hottestCollection];
    
    //设置代理
    _scrollView.delegate = self;
    _newsCollection.delegate = self;
    _newsCollection.dataSource = self;
    _hottestCollection.delegate = self;
    _hottestCollection.dataSource = self;
    //注册两个cell
    
    [_newsCollection registerNib:[UINib nibWithNibName:@"DrawingNewCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:DrawingNewCollectionViewCell_Identify];
    [_hottestCollection registerNib:[UINib nibWithNibName:@"DrawingHottestCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:DrawingHottestCollectionViewCell_Identify];

}
#pragma mark ========== scrollView的代理方法 ==========
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.segment.selectedSegmentIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
}


- (void)segmentControClicked:(UISegmentedControl *)sender
{
    [self.scrollView setContentOffset:CGPointMake(sender.selectedSegmentIndex * self.scrollView.frame.size.width, 0)];

}

#pragma mark ---------- collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.newsCollection) {
        DrawingNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DrawingNewCollectionViewCell_Identify forIndexPath:indexPath];
        return cell;
    }else if (collectionView == self.hottestCollection)
    {
        DrawingHottestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DrawingHottestCollectionViewCell_Identify forIndexPath:indexPath];
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
