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
#import "LibraryRequest.h"

#define KHeightCollection 90

@interface SingleExpressionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UMSocialUIDelegate, shareDelegate>

@property (nonatomic, strong) UICollectionView *singleCollectionView;
@property (nonatomic, strong) SingleExpressionHeaderView *singleHeader;
@property (nonatomic, strong) SingleFooterCollectionReusableView *singleFooter;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray <ExpressionLibraryModel *>*singleExpressions;

@end

@implementation SingleExpressionViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = self.expressionModel.eName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UI
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"🏃🏻" style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBarButtonItemClick)];
    [self addSingleHeaderView];
    [self layoutSetting];
    [self.singleCollectionView registerNib:[UINib nibWithNibName:@"DrawingNewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:DrawingNewCollectionViewCell_Identify];
    [self.singleCollectionView registerClass:[SingleFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SingleFooter"];
    
    //Data
    self.singleExpressions = [NSMutableArray array];
    //if ([NSString stringWithFormat:@"%@",_expressionModel.eId].length >3)
    //if ([[NSString stringWithFormat:@"%@",_expressionModel.eId] rangeOfString:@"46"].location == 0)
    if ([[[NSString stringWithFormat:@"%@",_expressionModel.eId] substringToIndex:2] isEqual: @"46"])
    {
        [self requestCycleScrollImages];
    }
    else 
    {
        [self requestSingleExpressions];
    }
}


#pragma mark - UI
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addSingleHeaderView
{
    _singleHeader = [[SingleExpressionHeaderView alloc] init];
    [self.view addSubview:_singleHeader];
    _singleHeader.sharedelegate = self;
//    [_singleHeader.QQBtn addTarget:self action:@selector(QQshare:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [_singleHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self.view);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(.3f);
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
    flowLayout.footerReferenceSize = CGSizeMake(self.view.frame.size.width, 120);

    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, WindowHeight/4.0f, WindowWidth, WindowHeight-250) collectionViewLayout:flowLayout];
    //代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    self.singleCollectionView = collectionView;
    [self.view addSubview:_singleCollectionView];
}


#pragma mark - libraryCollectionView init and Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.singleExpressions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DrawingNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DrawingNewCollectionViewCell_Identify forIndexPath:indexPath];

    ExpressionLibraryModel *model = self.singleExpressions[indexPath.row];
    [cell setLibraryModel:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ExpressionLibraryModel *model = self.singleExpressions[indexPath.row];
    if ([[[NSString stringWithFormat:@"%@",_expressionModel.eId] substringToIndex:2] isEqual: @"46"])
    {
        [_singleHeader.singleImageView setImageWithURL:[NSURL URLWithString:model.gifPath]];
    }
    else
    {
        [_singleHeader.singleImageView setImageWithURL:[NSURL URLWithString:[model.Url replacingStringToURL]]];
    }
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


#pragma mark - share
- (void)QQshare:(UIButton *)sender
{
    [self share:UMShareToQQ];
}

- (void)weiboShare:(UIButton *)sender
{
    [self share:UMShareToSina];
}

- (void)wechatShare:(UIButton *)sender
{
    [self share:UMShareToWechatSession];
}

- (void)circleShare:(UIButton *)sender
{
    [self share:UMShareToWechatTimeline];
}

- (void)share:(NSString *)platformTypes
{
    [UMSocialData defaultData].extConfig.title = @"分享的title";
    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:nil];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[platformTypes] content:@"say something..." image:_singleHeader.singleImageView.image location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}

#pragma mark - 数据
- (void)requestSingleExpressions
{
    __weak typeof(self) weakSelf = self;
    [[LibraryRequest shareLibraryRequest] requestSingleExpressionWithID:_expressionModel.eId Success:^(NSArray *arr) {
        [self setupProgressHud];
        NSMutableArray *tempArray = [ExpressionLibraryModel presentSingleWithArray:arr];
        weakSelf.singleExpressions = tempArray[0];
        [weakSelf.singleHeader.singleImageView setImageWithURL:[NSURL URLWithString:tempArray[1]]];
        [GiFHUD dismiss];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.singleCollectionView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"single error %@",error);
    }];
}

- (void)requestCycleScrollImages
{
    __weak typeof(self) weakSelf = self;
    [[LibraryRequest shareLibraryRequest] requestCycleScrollExpressionWithID:_expressionModel.eId success:^(NSDictionary *dic) {
        NSMutableArray *tempArray = [ExpressionLibraryModel presentCycleWithDictionary:dic];
        weakSelf.singleExpressions = tempArray[0];
        [weakSelf.singleHeader.singleImageView setImageWithURL:[NSURL URLWithString:tempArray[1]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.singleCollectionView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"cycle error %@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
