//
//  DrawingDetailViewController.m
//  Big cousin
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DrawingDetailViewController.h"
//#import "DrawingNewViewController.h"
//#import "DrawingHottestViewController.h"
#import "DrawingHottesCollectionViewCell.h"
#import "DrawingNewCollectionViewCell.h"
@interface DrawingDetailViewController ()
<
    UIScrollViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout

>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UISegmentedControl *segment;

@property (strong, nonatomic) UICollectionView *newestCollectionView;

@property (strong, nonatomic) UICollectionView *hottestCollectionView;

@end

@implementation DrawingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //间距
    //    flowLayout.minimumInteritemSpacing = 1;
    //行距
    flowLayout.minimumLineSpacing = 50;
    //每个分区边缘的ulinix
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //每行显示个数
    flowLayout.itemSize = CGSizeMake(100, 100);
    
    /** 初始化控制器 */
    self.newestCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight) collectionViewLayout:flowLayout];
    self.newestCollectionView.backgroundColor = [UIColor redColor];
    
    self.hottestCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(WindowWidth, 0, WindowWidth, WindowHeight) collectionViewLayout:flowLayout];
    self.hottestCollectionView.backgroundColor = [UIColor orangeColor];
//    self.hottestCollectionView.edgesForExtendedLayout = UIRectEdgeNone
    
    self.segment = [[UISegmentedControl alloc]initWithItems:@[@"最新",@"分类"]];
    
    self.navigationItem.titleView = self.segment;
    
    [self.segment addTarget:self action:@selector(segmentControClicked:) forControlEvents:(UIControlEventValueChanged)];
    
     self.segment.selectedSegmentIndex = 0;//默认选中的索引为0
    
     /** 创建scrollView */
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,69,WindowWidth, WindowHeight)];
    self.scrollView.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:self.scrollView];
    /** 设置scrollView的内容 */
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    
    /** 设置scrollView的代理 */
    self.scrollView.delegate = self;
    self.newestCollectionView.dataSource = self;
    self.newestCollectionView.delegate = self;
    self.hottestCollectionView.dataSource = self;
    self.hottestCollectionView.delegate = self;
    
    
    [self.scrollView addSubview:self.newestCollectionView];
    [self.scrollView addSubview:self.hottestCollectionView];
    
    
    //注册两个cell
    [self.newestCollectionView registerNib:[UINib nibWithNibName:@"DrawingNewCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:DrawingNewCollectionViewCell_Identify];
    [self.hottestCollectionView registerNib:[UINib nibWithNibName:@"DrawingHottesCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:DrawingHottesCollectionViewCell_Identify];

    [self addViews];
    
}

- (void)addViews
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"🐈" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftBarButtonItemClick)];
    
}

- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
/** segment的实现方法 */
- (void)segmentControClicked:(UISegmentedControl *)segment
{
    [self.scrollView setContentOffset:CGPointMake(segment.selectedSegmentIndex * self.scrollView.frame.size.width, 0)];
}


#pragma mark ========== scrollView的代理方法 ==========
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.segment.selectedSegmentIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
}

#pragma mark ----------UICollectionViewDataSource,UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.newestCollectionView) {
        DrawingNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DrawingNewCollectionViewCell_Identify forIndexPath:indexPath];
        return cell;
    }else if (collectionView == self.hottestCollectionView)
    {
        DrawingHottesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DrawingHottesCollectionViewCell_Identify forIndexPath:indexPath];
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
