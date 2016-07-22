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
#import "WordViewController.h"
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
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //间距
//    flowLayout.minimumInteritemSpacing = 1;
    //行距
    flowLayout.minimumLineSpacing = 50;
    //每个分区边缘的ulinix
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //每行显示个数
    flowLayout.itemSize = CGSizeMake(100, 100);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame)+40, CGRectGetMinY(self.view.bounds) + 150, self.view.bounds.size.width - 80, self.view.bounds.size.height - (CGRectGetMaxY(self.view.bounds) - 300)) collectionViewLayout:flowLayout];
   
    //代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DrawingCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:DrawingCollectionViewCell_Identify];
    self.collectionView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.collectionView];
    
}
//返回个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
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
    if (indexPath.row == 2) {
        self.hidesBottomBarWhenPushed = YES;
        WordViewController *wordVC = [[WordViewController alloc]init];
        [self.navigationController pushViewController:wordVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else{
    DrawingDetailViewController *drawingVC = [[DrawingDetailViewController alloc] init];
    [self.navigationController pushViewController:drawingVC animated:YES];
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
