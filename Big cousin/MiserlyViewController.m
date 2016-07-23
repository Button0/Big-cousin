//
//  MiserlyViewController.m
//  Big cousin
//
//  Created by HMS,CK,SS,LYB3g on 16/7/21.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "MiserlyViewController.h"
#import "MiserlyCollectionViewCell.h"
#import "DrawingRequest.h"
#import "MiserlyModel.h"
@interface MiserlyViewController ()
<
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
>

@property (nonatomic, strong) UICollectionView *miserlyCollection;

@property (strong, nonatomic) NSMutableArray *miserlyArray;

@end

@implementation MiserlyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _miserlyArray = [NSMutableArray array];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //行距
    flowLayout.minimumLineSpacing = 20;
    //每个分区边缘的距离
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //每行显示个数
    flowLayout.itemSize = CGSizeMake(100, 100);
    //初始化
    _miserlyCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight) collectionViewLayout:flowLayout];
    _miserlyCollection.backgroundColor = [UIColor whiteColor];
    //代理
    _miserlyCollection.delegate = self;
    _miserlyCollection.dataSource = self;

    //注册cell
    [_miserlyCollection registerNib:[UINib nibWithNibName:@"MiserlyCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:MiserlyCollectionViewCell_Identify];
    [self.view addSubview:_miserlyCollection];
    //获得数据
    [self getMiserlyData];
}

#pragma mark -------------- 获取数据
- (void)getMiserlyData
{
    __weak typeof(self)weakSelf = self;
    [[DrawingRequest sharaDrawingRequest]requestMiserlySuccess:^(NSArray *arr) {
        weakSelf.miserlyArray = [MiserlyModel presentMiserlyWithArray:arr];

        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.miserlyCollection reloadData];
        });
        
    } failure:^(NSError *error) {
        NSLog(@"error ====== %@",error);
    }];
}


#pragma mark ========= 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.miserlyArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MiserlyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MiserlyCollectionViewCell_Identify forIndexPath:indexPath];
    MiserlyModel *model = self.miserlyArray[indexPath.row];
    cell.model = model;
    return cell;
}

//cell点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CompileViewController *compileVC = [[CompileViewController alloc]init];
    [self.navigationController pushViewController:compileVC animated:YES];
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
