//
//  DrawingDetailViewController.m
//  Big cousin
//
//  Created by HMS,CK,LYB,SS on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DrawingDetailViewController.h"
#import "DrawingHottesCollectionViewCell.h"
#import "DrawingNewCollectionViewCell.h"
#import "DrawingModel.h"
#import "DrawingHottesModel.h"
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

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NSMutableArray *hottesArray;

@end

@implementation DrawingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [NSMutableArray array];
    _hottesArray = [NSMutableArray array];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //间距
    //    flowLayout.minimumInteritemSpacing = 1;
    //行距
    flowLayout.minimumLineSpacing = 20;
    //每个分区边缘的距离
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //每行显示个数
    flowLayout.itemSize = CGSizeMake(100, 135);
    
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
    [self getNewData];
    [self getHottesData];
    
}

- (void)getNewData
{
    NSURL *url = [NSURL URLWithString:@"http://cdn.ibiaoqing.com/ibiaoqing/admin/pic/getNew.do"];
    
    //    创建session 对象
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        
        NSArray *array = [arr lastObject];
        for (NSDictionary *dict in array) {
            DrawingModel *model = [DrawingModel new];
            [model setValuesForKeysWithDictionary:dict];
//            NSLog(@"=======%@",model);
            [self.dataArray addObject:model];
//            NSLog(@"%@",self.dataArray);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.newestCollectionView reloadData];
        });
    }];
    [task resume];

}

- (void)getHottesData
{
    NSURL *url = [NSURL URLWithString:@"http://123.57.155.230/ibiaoqing/admin/expre/listBy.do?pageNumber=1&status=Y&status1=S&token=yes"];
    
    //    创建session 对象
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        
        NSArray *array = [arr lastObject];
        for (NSDictionary *dict in array) {
            DrawingHottesModel *model = [DrawingHottesModel new];
            [model setValuesForKeysWithDictionary:dict];
//                        NSLog(@"=======%@",model);
            [_hottesArray addObject:model];
                        NSLog(@"%@",self.hottesArray);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.hottestCollectionView reloadData];
        });
    }];
    [task resume];

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
    if (collectionView == self.newestCollectionView) {
        return self.dataArray.count;
    }else
    {
        return self.hottesArray.count;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.newestCollectionView) {
        DrawingNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DrawingNewCollectionViewCell_Identify forIndexPath:indexPath];
        DrawingModel *model = self.dataArray[indexPath.row];
        [cell.drawingNewImageV setImageWithURL:[NSURL URLWithString:model.url]];
        return cell;
    }else if (collectionView == self.hottestCollectionView)
    {
        DrawingHottesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DrawingHottesCollectionViewCell_Identify forIndexPath:indexPath];
        DrawingHottesModel *model = self.hottesArray[indexPath.row];
        [cell.hottesImageV setImageWithURL:[NSURL URLWithString:model.url]];
        cell.hottesLabel.text = model.eName;
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
