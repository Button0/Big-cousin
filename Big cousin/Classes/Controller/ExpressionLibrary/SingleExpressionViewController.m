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
#import "LGRefreshView.h"
#import "DataBaseManager.h"
#import "SVProgressHUD.h"


#define KHeightCollection 90

@interface SingleExpressionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UMSocialUIDelegate, shareDelegate>

@property (nonatomic, strong) UICollectionView *singleCollectionView;
@property (nonatomic, strong) SingleExpressionHeaderView *singleHeader;
@property (nonatomic, strong) SingleFooterCollectionReusableView *singleFooter;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray <ExpressionLibraryModel *>*singleExpressions;
@property (strong, nonatomic) LGRefreshView *refreshView;

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
    [self setBarButton];
    [self layoutSetting];
    [self addSingleHeaderView];
    [self.singleCollectionView registerNib:[UINib nibWithNibName:@"DrawingNewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:DrawingNewCollectionViewCell_Identify];
    [self.singleCollectionView registerClass:[SingleFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SingleFooter"];
    
    //Data
    self.singleExpressions = [NSMutableArray array];
    [self updateDataOfPulldown];
}


#pragma mark - UI
- (void)setBarButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"🏃🏻" style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBarButtonItemClick)];
    
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:testView];
    
    UIButton *collectionBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    collectionBtn.frame = CGRectMake(0, 0, 25, 25);
    [testView addSubview:collectionBtn];
    BOOL isFavorite = [[DataBaseManager shareInstance] isFavoriteExpressionPackWithID:[NSString stringWithFormat:@"%@",_expressionModel.eId]];
    NSString *favorImage = isFavorite ? @"btn_shoucang_1" : @"btn_shoucang_0";
    [collectionBtn setImage:[UIImage imageNamed:favorImage] forState:(UIControlStateNormal)];
    [collectionBtn addTarget:self action:@selector(collectionBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)addSingleHeaderView
{
    _singleHeader = [[SingleExpressionHeaderView alloc] init];
    [self.view addSubview:_singleHeader];
    _singleHeader.sharedelegate = self;
    
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
    collectionView.alwaysBounceVertical = YES;
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

- (void)head:(UIButton *)sender
{
//    [self share:UMShareToDouban];
    NSLog(@"---");
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

#pragma mark - 左右 BarButtonItem Method
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)collectionBtnClicked:(UIButton *)sender
{
    NSLog(@"sendNotification btn clicked");
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTheTable" object:nil];

    BOOL isFavorite = [[DataBaseManager shareInstance] isFavoriteExpressionPackWithID:[NSString stringWithFormat:@"%@",_expressionModel.eId]];
    if (isFavorite == NO)
    {
        [[DataBaseManager shareInstance] insertNewExpressionPack:_expressionModel];
        
        // 收藏成功
        [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
        [sender setImage:[UIImage imageNamed:@"btn_shoucang_1"] forState:(UIControlStateNormal)];
    }
    else
    {
        // 删
        [[DataBaseManager shareInstance] deleteExpressionPack:_expressionModel.eId];
        [SVProgressHUD showSuccessWithStatus:@"已取消收藏"];
        [sender setImage:[UIImage imageNamed:@"btn_shoucang_0"] forState:(UIControlStateNormal)];
    }
}


#pragma mark - 数据
//下拉刷新
- (void)updateDataOfPulldown
{
    __weak typeof(self) wself = self;
    if ([[[NSString stringWithFormat:@"%@",_expressionModel.eId] substringToIndex:2] isEqual: @"46"])
    {
        [self requestCycleScrollImages];
    }
    else
    {
        [self requestSingleExpressions];
    }
    
    _refreshView = [LGRefreshView refreshViewWithScrollView:_singleCollectionView refreshHandler:^(LGRefreshView *refreshView)
    {
        if (wself)
        {
            __strong typeof(wself) self = wself;
            [_singleCollectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void)
                           {
                               [self.refreshView endRefreshing];
                           });
        }
    }];
    _refreshView.tintColor = KColorGlyodin;
    _refreshView.backgroundColor = KColorLightBlue;
}

- (BOOL)shouldAutorotate
{
    return !_refreshView.isRefreshing;
}

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
