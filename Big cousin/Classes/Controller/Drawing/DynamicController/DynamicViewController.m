//
//  DynamicViewController.m
//  Big cousin
//
//  Created by HMS,CK,SS,LYB on 16/7/20.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DynamicViewController.h"
#import "DrawingNewCollectionViewCell.h"
#import "DrawingHottestCollectionViewCell.h"
#import "DrawingRequest.h"
#import "DynamicHottestModel.h"
#import "DynamicModel.h"
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

@property (strong, nonatomic) NSMutableArray *dynsmicArray;
@property (strong, nonatomic) NSMutableArray *hottestArray;

@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dynsmicArray = [NSMutableArray array];
    
    _hottestArray = [NSMutableArray array];
    
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
    _newsCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight-100) collectionViewLayout:flowLayout];
    _newsCollection.backgroundColor = [UIColor whiteColor];
    
    _hottestCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(WindowWidth, 0, WindowWidth, WindowHeight-100) collectionViewLayout:flowLayout];
    _hottestCollection.backgroundColor = [UIColor whiteColor];
    //分页
    _segment = [[UISegmentedControl alloc]initWithItems:@[@"最新",@"最热"]];
    
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
    //获得数据
    //最新
    [self getDynsmicNewsData];
    //最热
    [self getDynsmicHottestData];

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

#pragma mark --------------------- 获取数据
- (void)getDynsmicNewsData
{
    __weak typeof(self)weakSelf = self;
    [[DrawingRequest sharaDrawingRequest]requestDynameicNewWithSuccess:^(NSArray *arr) {
        weakSelf.dynsmicArray = [DynamicModel presentDynamicWithArray:arr];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.newsCollection reloadData];
        });
//        NSLog(@"===============%@",weakSelf.dynsmicArray);

    } failure:^(NSError *error) {
        NSLog(@"error ===== %@",error);
    }];
}

- (void)getDynsmicHottestData
{
    __weak typeof(self)weakSelf = self;
    [[DrawingRequest sharaDrawingRequest] requestDynameicHottestWithSuccess:^(NSArray *arr) {
        weakSelf.hottestArray = [DynamicHottestModel presentDynamicHottestWithArray:arr];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.hottestCollection reloadData];
        });

    } failure:^(NSError *error) {
        NSLog(@"error ====== %@",error);
    }];
}

#pragma mark ---------- collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.newsCollection) {
        return self.dynsmicArray.count;
    }else if(collectionView == self.hottestCollection)
    {
        return self.hottestArray.count;
    }
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.newsCollection) {
        DrawingNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DrawingNewCollectionViewCell_Identify forIndexPath:indexPath];
        DynamicModel *model = self.dynsmicArray[indexPath.row];
        cell.dynamicModel = model;
        return cell;
    }else if (collectionView == self.hottestCollection)
    {
        DrawingHottestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DrawingHottestCollectionViewCell_Identify forIndexPath:indexPath];
        DynamicHottestModel *model = self.hottestArray[indexPath.row];
        cell.model = model;
        return cell;
        
    }
    return nil;
}

//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.hidesBottomBarWhenPushed = YES;
    CompileViewController *compileVC = [[CompileViewController alloc]init];
    [self.navigationController pushViewController:compileVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    if (collectionView ==  _newsCollection) {
        DynamicModel *model = self.dynsmicArray[indexPath.row];
        compileVC.imageString = [model.URL replacingStringToURL];
    }else if (collectionView == _hottestCollection)
    {
        DynamicHottestModel *model = self.hottestArray[indexPath.row];
        compileVC.imageString = [model.URL replacingStringToURL];
    }
    
    
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
