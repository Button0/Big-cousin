//
//  PublicCollectionViewController.m
//  
//
//  Created by Mushroom on 16/7/15.
//
//

#import "PublicCollectionViewController.h"
#import "ExpressionLibraryViewController.h"
#import "DrawingHottesCollectionViewCell.h"
#import "SingleExpressionViewController.h"
#import "NavigationMenuView.h"
#import "ExpressionLibraryModel.h"
#import "LibraryRequest.h"

#define KHeightCollection 135

@interface PublicCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NavigationMenuDelegate>

/** 公用 */
@property (nonatomic, strong) UICollectionView *pulicCollectionView;
@property (nonatomic, strong) NSMutableArray *expressions;

@end

@implementation PublicCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UI
    [self layoutSetting];
    [self.pulicCollectionView registerNib:[UINib nibWithNibName:@"DrawingHottesCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:DrawingHottesCollectionViewCell_Identify];
    //Data
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
    flowLayout.itemSize = CGSizeMake(WindowWidth / 3.5, KHeightCollection);
    
    self.pulicCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight -130) collectionViewLayout:flowLayout];
    [self.view addSubview:_pulicCollectionView];
    //代理
    self.pulicCollectionView.dataSource = self;
    self.pulicCollectionView.delegate = self;
    self.pulicCollectionView.backgroundColor = [UIColor whiteColor];
}

//title引导栏
- (void)titles
{
    if (self.navigationItem)
    {
        CGRect frame = CGRectMake(0.0, 0.0, 100.0, self.navigationController.navigationBar.bounds.size.height);
        NavigationMenuView *menu = [[NavigationMenuView alloc] initWithFrame:frame title:@"Menu"];
        [menu displayMenuInView:self.navigationController.view];
        //        menu.items = @[@"原创表情",@"聊天场景",@"萌娃",@"金馆长系列",@"明星大咖",@"实力派网红",@"综艺影视",@"可爱形象",@"真人GIF"];
        menu.delegate = self;
        self.navigationItem.titleView = menu;
    }
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
    __weak typeof(self)weakSelf = self;
    [[LibraryRequest shareLibraryRequest] requestPulicExpressionsWithUrl:_url success:^(NSArray *arr) {
//        [self setupProgressHud];
        weakSelf.expressions = [ExpressionLibraryModel presentPublicWithArray:arr];
//        [GiFHUD dismiss];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.pulicCollectionView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"error === %@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
