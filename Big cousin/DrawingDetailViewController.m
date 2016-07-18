//
//  DrawingDetailViewController.m
//  Big cousin
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DrawingDetailViewController.h"
#import "DrawingNewViewController.h"
#import "DrawingHottestViewController.h"
@interface DrawingDetailViewController ()
<
    UIScrollViewDelegate
>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UISegmentedControl *segment;

@property (strong, nonatomic) DrawingNewViewController *newestCollectionView;

@property (strong, nonatomic) DrawingHottestViewController *hottestCollectionView;

@end

@implementation DrawingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.segment = [[UISegmentedControl alloc]initWithItems:@[@"最新",@"分类"]];
    
    self.navigationItem.titleView = self.segment;
    
    [self.segment addTarget:self action:@selector(segmentControClicked:) forControlEvents:(UIControlEventValueChanged)];
    
     self.segment.selectedSegmentIndex = 0;
    
     /** 创建scrollView */
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64,self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:self.scrollView];
    /** 设置scrollView的内容 */
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    /** 初始化控制器 */
    self.newestCollectionView = [[DrawingNewViewController alloc]init];
    self.hottestCollectionView = [[DrawingHottestViewController alloc]init];
    /** 添加为self的自控制器 */
    [self addChildViewController:self.newestCollectionView];
    [self addChildViewController:self.hottestCollectionView];
    
    self.newestCollectionView.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    
    self.hottestCollectionView.view.frame = CGRectMake(self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    /** 将视图添加到scrollView上 */
    [self.scrollView addSubview:self.newestCollectionView.view];
    [self.scrollView addSubview:self.hottestCollectionView.view];
    
    
    /** 设置scrollView的代理 */
    self.scrollView.delegate = self;
    
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
