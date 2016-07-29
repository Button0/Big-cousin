//
//  DrawingViewController.m
//  Big cousin
//
//  Created by HMS on 16/7/13.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DrawingViewController.h"
#import "DrawingCollectionViewCell.h"
#import "DrawingDetailViewController.h"
#import "DynamicViewController.h"
#import "MiserlyViewController.h"
@interface DrawingViewController ()
<
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
>
//定义collectionView属性
@property (strong, nonatomic)UICollectionView *collectionView;
@end

@implementation DrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"快速制作";
    self.view.backgroundColor = KColorFeiGray;
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //间距
//    flowLayout.minimumInteritemSpacing = 1;
    //行距
    flowLayout.minimumLineSpacing = 50;
    //每个分区边缘的ulinix
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //每行显示个数
    flowLayout.itemSize = CGSizeMake(100, 100);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
   
    //代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DrawingCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:DrawingCollectionViewCell_Identify];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        //设置view的大小
        make.size.mas_equalTo(CGSizeMake(250, 300));
        make.center.equalTo(self.view);
    }];

    
}
//返回个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}
//cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DrawingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DrawingCollectionViewCell_Identify forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor redColor];
    return cell;
}

//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            DrawingDetailViewController *drawingVC =[DrawingDetailViewController new];
            [self.navigationController pushViewController:drawingVC animated:YES];
            break;
        }
            case 1:
        {
            DynamicViewController *dynamicVC = [[DynamicViewController alloc]init];
            [self.navigationController pushViewController:dynamicVC animated:YES];
            break;
        }
            case 2:
        {
            MiserlyViewController *miserlyVC = [[MiserlyViewController alloc]init];
            [self.navigationController pushViewController:miserlyVC animated:YES];
        }
        default:
            break;
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
