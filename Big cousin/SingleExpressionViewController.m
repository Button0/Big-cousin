//
//  SingleExpressionViewController.m
//  Big cousin
//
//  Created by Mushroom on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "SingleExpressionViewController.h"
#import "DrawingNewCollectionViewCell.h"
#import "SingleExpressionHeaderView.h"
#import "SingleFooterCollectionReusableView.h"
#import "ExpressionLibraryModel.h"

#define KHeightCollection 90
#define KHeightSingleHeaderView 180

@interface SingleExpressionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *singleCollectionView;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *singleExpressions;
@property (nonatomic, strong) SingleExpressionHeaderView *singleHeader;
@property (nonatomic, strong) SingleFooterCollectionReusableView *singleFooter;

@end

@implementation SingleExpressionViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = self.expressionModel.eName;
//    [_singleHeader.singleImageView setImageWithURL:[NSURL URLWithString:_expressionModel.coverUrl]];
//    _singleFooter.memo1Label.text = _expressionModel.memo1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutSetting];
    [self.singleCollectionView registerNib:[UINib nibWithNibName:@"DrawingNewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:DrawingNewCollectionViewCell_Identify];
    [self.singleCollectionView registerClass:[SingleFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SingleFooter"];
    
    self.singleExpressions = [NSMutableArray array];
    [self requestSingleExpressions];
    [self addSingleHeaderView];
}


#pragma mark - UI
- (void)addSingleHeaderView
{
    _singleHeader = [[SingleExpressionHeaderView alloc] init];
//    _singleHeader.frame = CGRectMake(0, 0, WindowWidth, KHeightSingleHeaderView);
    
    [_singleHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.view addSubview:_singleHeader];
        make.size.mas_equalTo(CGSizeMake(WindowWidth, WindowHeight/4.0f));
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
    }];
}

- (void)layoutSetting
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 30;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.itemSize = CGSizeMake(WindowWidth / 5, KHeightCollection);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.footerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);

    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, WindowHeight/4.0f, WindowWidth, WindowHeight-200) collectionViewLayout:flowLayout];
    //代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    self.singleCollectionView = collectionView;
    [self.view addSubview:_singleCollectionView];
}


#pragma mark - libraryCollectionView init and Delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DrawingNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DrawingNewCollectionViewCell_Identify forIndexPath:indexPath];

    ExpressionLibraryModel *model = self.singleExpressions[indexPath.row];
    [cell setLibraryModel:model];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.singleExpressions.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ExpressionLibraryModel *model = self.singleExpressions[indexPath.row];
    [_singleHeader.singleImageView setImageWithURL:[NSURL URLWithString:[model.Url replacingStringToURL]]];
    _singleFooter.memo1 = _expressionModel.memo1;
 }

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionFooter)
    {
        _singleFooter = (SingleFooterCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SingleFooter" forIndexPath:indexPath];
        _singleFooter.backgroundColor = KColorLightBlue;
    }
    return _singleFooter;
}


#pragma mark - 数据
- (void)requestSingleExpressions
{
    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    
//    [manager GET:SingleExpression_Url(_single_Id) parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray*  _Nullable responseObject) {

    [manager GET:SingleExpression_Url(_expressionModel.eId) parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray*  _Nullable responseObject) {
    
       
        if (responseObject.count >= 3
            && [[responseObject objectAtIndex:2] isKindOfClass:[NSArray class]])
        {
//        NSLog(@"----%@",responseObject);
        NSArray *categoryArray = [responseObject objectAtIndex:2];
        for (NSMutableDictionary *dict in categoryArray)
        {
            ExpressionLibraryModel *model = [[ExpressionLibraryModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [weakSelf.singleExpressions addObject:model];
        }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.singleCollectionView reloadData];
            });
        }
        else
        {
            NSLog(@"Error: data error %@", responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"single failure %@",error);
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
