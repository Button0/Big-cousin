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
#import "DrawingRequest.h"
@interface DrawingDetailViewController ()
<
    UIScrollViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate
>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UISegmentedControl *segment;

@property (strong, nonatomic) UICollectionView *newestCollectionView;

@property (strong, nonatomic) UICollectionView *hottestCollectionView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NSMutableArray *hottesArray;

@property (strong, nonatomic) UIImagePickerController *imagePC;

@property (strong, nonatomic) UIButton *button;

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
    flowLayout.itemSize = CGSizeMake(100, 120);
    
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
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,WindowWidth, WindowHeight)];
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
    //相机相册
    [self getPhotoPicther];
}

#pragma mark --------------- 调用相册和相机 ------------
//相机相册
- (void)getPhotoPicther
{
    //添加相机和相册功能
    _button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _button.frame = CGRectMake(0, 0, 40,30);
    [_button setImage:[UIImage imageNamed:@"camera-256"] forState:(UIControlStateNormal)];
    [_button addTarget:self action:@selector(photoClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    //    photoButton.backgroundColor = [UIColor redColor];
    UIBarButtonItem *phototItem = [[UIBarButtonItem alloc]initWithCustomView:_button];
    self.navigationItem.rightBarButtonItems = @[phototItem];

}
//调用相册和相机
- (void)photoClicked:(UIButton *)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"Choose Your Picture:" preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"相机" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self pictureFromeCpmmera];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self pickerImageFromeLibrary];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

/** 进入照相机 **/
- (void)pictureFromeCpmmera
{
    
    BOOL _isAvailable = [UIImagePickerController isCameraDeviceAvailable:(UIImagePickerControllerCameraDeviceRear)];
    
    if(!_isAvailable){
        
        [self alertActionWithTitle:@"相机好像坏啦" action:nil];
        
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    picker.allowsEditing = YES;
    
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

// 从相册中选择图片
- (void)pickerImageFromeLibrary
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.allowsEditing = YES;
    
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}

// 提示框
- (void)alertActionWithTitle:(NSString *)title action:(void(^)())action
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    
    /**
     * 弹出提示框并保存图片
     */
    [self presentViewController:alertC animated:YES completion:^{
        
        if (action) {
            action();
        }
        
    }];
    
    /**
     * 添加延迟线程让视图消失
     */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [alertC dismissViewControllerAnimated:YES completion:nil];
        
    });
}

#pragma mark ---------------- 获取的数据

- (void)getNewData
{

    __weak typeof(self)weakSelf = self;
    [[DrawingRequest sharaDrawingRequest]requestNewDrawingSuccess:^(NSArray *arr) {
        weakSelf.dataArray = [DrawingModel parseDrawingWihArray:arr];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.newestCollectionView reloadData];
        });
        
    } failurl:^(NSError *error) {
        NSLog(@"error ====== %@",error);
    }];
    
    
    
}

- (void)getHottesData
{
    __weak typeof(self)weakSelf = self;
    [[DrawingRequest sharaDrawingRequest]requestHottesDrawingSuccess:^(NSArray *arr) {
        weakSelf.hottesArray = [DrawingHottesModel presentDrawingHottesWithArray:arr];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.hottestCollectionView reloadData];
        });
        
    } failurl:^(NSError *error) {
        NSLog(@"error ====== %@",error);
    }];
    

}
#pragma mark ------------- 添加导航栏左部item
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
        cell.model = model;
        return cell;
    }else if (collectionView == self.hottestCollectionView)
    {
        DrawingHottesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DrawingHottesCollectionViewCell_Identify forIndexPath:indexPath];
        DrawingHottesModel *model = self.hottesArray[indexPath.row];
    
        cell.hottesModel = model;
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
