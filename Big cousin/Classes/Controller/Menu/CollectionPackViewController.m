//
//  shoucangViewController.m
//  Big cousin
//
//  Created by wuhan107 on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "CollectionPackViewController.h"
#import "DataBaseManager.h"


@interface CollectionPackViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic,strong) NSMutableArray * expressionsPack;
@end

@implementation CollectionPackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.title = @"收藏";


}

//获取当前用户收藏过的活动
- (void)getAllActivities
{
    // 从数据库中读取活动对象数据
    self.expressionsPack = [[DataBaseManager shareInstance] selectAllExpressionPack];
    if (_expressionsPack.count == 0)
    {
        NSLog(@"暂无收藏！");
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
