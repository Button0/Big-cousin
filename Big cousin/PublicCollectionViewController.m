//
//  PublicCollectionViewController.m
//  
//
//  Created by Mushroom on 16/7/15.
//
//

#import "PublicCollectionViewController.h"
#import "DrawingHottesCollectionViewCell.h"
#import "ExpressionLibraryModel.h"
#import "SingleExpressionViewController.h"

@interface PublicCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray *expressions;
@end

@implementation PublicCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutSetting];
    [self.pulicCollectionView registerNib:[UINib nibWithNibName:@"DrawingHottesCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:DrawingHottesCollectionViewCell_Identify];
    
    self.expressions = [NSMutableArray array];
    [self requestAllExpressions];
}

#pragma mark - UI
- (void)layoutSetting
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.minimumLineSpacing = 20;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.itemSize = CGSizeMake(WindowWidth / 3.5, 135);
    
    self.pulicCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [self.view addSubview:_pulicCollectionView];
    //代理
    self.pulicCollectionView.dataSource = self;
    self.pulicCollectionView.delegate = self;
    self.pulicCollectionView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - collection delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.expressions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DrawingHottesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DrawingHottesCollectionViewCell_Identify forIndexPath:indexPath];

    ExpressionLibraryModel *model = self.expressions[indexPath.row];
    [cell setLibraryModel:model];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SingleExpressionViewController *singleVC = [[SingleExpressionViewController alloc]init];
    ExpressionLibraryModel *model = self.expressions[indexPath.row];
    singleVC.expressionModel = model;
    
    [self.navigationController pushViewController:singleVC animated:YES];
}

#pragma mark - 数据
- (void)requestAllExpressions
{
    
    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    
    [manager GET:_url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray*  _Nullable responseObject) {
        
//        [self setupProgressHud];
//        NSLog(@"----%@",responseObject);
        NSMutableArray*array=responseObject.lastObject;
        for (NSMutableDictionary*dict in array)
        {
            ExpressionLibraryModel *model = [ExpressionLibraryModel new];
            [model setValuesForKeysWithDictionary:dict];
            [weakSelf.expressions addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.pulicCollectionView  reloadData];
        });
//        [GiFHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"===%@",error);
    }];
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
