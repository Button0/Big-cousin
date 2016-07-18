//
//  DrawingNewViewController.m
//  Big cousin
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DrawingNewViewController.h"
#import "DrawingNewCollectionViewCell.h"
#import "DrawingModel.h"

@interface DrawingNewViewController ()
<
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
>

@property (strong, nonatomic)UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *drawArray;

@end

@implementation DrawingNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.drawArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //间距
    flowLayout.minimumInteritemSpacing = 1;
    //行距
    flowLayout.minimumLineSpacing = 50;
    //每个分区边缘的ulinix
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //每行显示个数
    flowLayout.itemSize = CGSizeMake(100, 100);
    
    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    //代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DrawingNewCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:DrawingNewCollectionViewCell_Identify];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];

    [self requestDrawingData];
    
}

- (void)requestDrawingData
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
            [self.drawArray addObject:model];
//            NSLog(@"%@",self.drawArray);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    [task resume];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.drawArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DrawingNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DrawingNewCollectionViewCell_Identify forIndexPath:indexPath];
    DrawingModel *model = self.drawArray[indexPath.row];
    [cell.drawingNewImageV setImageWithURL:[NSURL URLWithString:model.url]];
    return cell;
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
