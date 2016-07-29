//
//  LYB_ChouTiViewController.m
//  ChouTi_FengZhuang
//
//  Created by wuhan107 on 16/7/14.
//  Copyright © 2016年 wuhan107. All rights reserved.
//

#import "LYB_ChouTiViewController.h"

#define kMenuLeftWidth [UIScreen mainScreen].bounds.size.width * 0.7

#define vWidth self.view.bounds.size.width
#define vHight self.view.bounds.size.height


@interface LYB_ChouTiViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *LFtableView;

@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)UIButton *setButton;

@property(nonatomic,strong)UIButton *moreButton;



@end

@implementation LYB_ChouTiViewController

// 判断当前是否展开
- (BOOL)isShowing {
    if (self.centerViewController.view.transform.tx > 0) {
        return YES;
    }
    return NO;
}
// 初始化方法
static LYB_ChouTiViewController *LYB_menuVC = nil;
+(instancetype)leftViewController:(UIViewController *)leftVC centerViewController:(UIViewController *)centerVC {
    @synchronized(self) {
        if (!LYB_menuVC) {
            
            LYB_menuVC = [[LYB_ChouTiViewController alloc]init];
            // 设置window的rootViewController
            [UIApplication sharedApplication].keyWindow.rootViewController = LYB_menuVC;
            // 设置属性
            LYB_menuVC.leftViewController = leftVC;
            LYB_menuVC.centerViewController = centerVC;
            // 添加子视图控制器和子视图
            if (leftVC) {
                [LYB_menuVC addChildViewController:leftVC];
                [LYB_menuVC.view addSubview:leftVC.view];
            }else {
                [LYB_menuVC setupLeftViewController];
            }
            if (centerVC) {
                [LYB_menuVC addChildViewController:centerVC];
                [LYB_menuVC.view addSubview:centerVC.view];
            }
        }
    }
    return LYB_menuVC;
}
// 默认的菜单视图
- (void)setupLeftViewController {
    self.LFtableView = [[UITableView alloc]    initWithFrame:CGRectMake(-kMenuLeftWidth, 0, kMenuLeftWidth, self.view.frame.size.height) style:UITableViewStyleGrouped];
    // 设置数据源
    self.LFtableView.dataSource = self;
    // 代理
    self.LFtableView.delegate = self;
    self.LFtableView.backgroundColor = [UIColor colorWithRed:37.0f/255.0 green:37.0f/255.0 blue:37.0f/255.0 alpha:0.95];
    self.LFtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.setButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.setButton.frame = CGRectMake(50, vHight - 100, 30, 30);
    [self.setButton setImage:[UIImage imageNamed:@"设置.png"] forState:UIControlStateNormal];
    self.setButton.tag = 1000;
    [self.setButton addTarget:self action:@selector(ClickSetBut:) forControlEvents:UIControlEventTouchUpInside];
    
    self.moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moreButton.frame = CGRectMake(vWidth - 200, vHight - 100, 30, 30);
    [self.moreButton setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
    self.moreButton.tag = 1001;
    [self.moreButton addTarget:self action:@selector(ClickMoreBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.LFtableView addSubview:self.moreButton];

    [self.LFtableView addSubview:self.setButton];

    [self.view addSubview:self.LFtableView];
}

-(void)ClickSetBut:(UIButton *)sender
{
    [self.menuClickDelegate ClickBut:sender];
    [self hideLeftViewController];

}

-(void)ClickMoreBut:(UIButton *)sender
{
    [self.menuClickDelegate ClickBut:sender];
    [self hideLeftViewController];
}


#pragma mark - UITableViewDataSource
// 数据源代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuserID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserID];
    }
    
    cell.textLabel.text = self.menuArray[indexPath.row];
    
    if (indexPath.row == self.index) {
        cell.textLabel.textColor = [UIColor whiteColor];
    }else {
        cell.textLabel.textColor = [UIColor lightGrayColor];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;

}



// menuArray的setter方法
- (void)setMenuArray:(NSMutableArray *)menuArray {
    if (_menuArray != menuArray) {
        _menuArray  = nil;
        _menuArray  = menuArray;
        [self.LFtableView reloadData];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.index = indexPath.row;
    [tableView reloadData];
    // 代理 传值
    if ([self.menuClickDelegate respondsToSelector:@selector(ClickMenuIndex: Title:)]) {
        [self.menuClickDelegate ClickMenuIndex:indexPath.row Title:self.menuArray[indexPath.row]];
    }
    // 关闭抽屉
    [self hideLeftViewController];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 200;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMenuLeftWidth, 200)];
    
    UIImageView *headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(70, 70, 100, 100)];
//    headerImgView.contentMode = UIViewContentModeScaleAspectFit;
    headerImgView.image = [UIImage imageNamed:@"3.jpg"];
    headerImgView.layer.masksToBounds = YES;
    headerImgView.layer.cornerRadius = 50;
    [headView addSubview:headerImgView];
    return headView;
}

#pragma mark 抽屉

// 获取抽屉方法
+ (instancetype)getMenuViewController {
    return LYB_menuVC;
}

// 展示左侧菜单
- (void)showLeftViewController {
    // 动画展开
    [self showLeftViewController:0.7];
}
- (void)showLeftViewController:(CGFloat)duration{
    [UIView animateWithDuration:duration animations:^{
        self.centerViewController.view.transform = CGAffineTransformMakeTranslation(kMenuLeftWidth, 0);
        self.leftViewController.view.transform = CGAffineTransformMakeTranslation(kMenuLeftWidth, 0);
        self.LFtableView.transform = CGAffineTransformMakeTranslation(kMenuLeftWidth, 0);
    }];
    
}
// 关闭左侧菜单
- (void)hideLeftViewController {
    [self hideLeftViewController:0.7];
}
- (void)hideLeftViewController:(CGFloat)duration {
    // 动画关闭
    [UIView animateWithDuration:duration animations:^{
        self.centerViewController.view.transform = CGAffineTransformMakeTranslation(0, 0);
        self.leftViewController.view.transform = CGAffineTransformMakeTranslation(0, 0);
        self.LFtableView.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panMenuWithPanGesture:)];
    
#warning 手势被collectinview的手势覆盖，需要修复这个bag
       [self.view addGestureRecognizer:pan];


}


// 静态变量保存初始状态
static CGPoint begin;
static CGAffineTransform transform;
- (void)panMenuWithPanGesture:(UIPanGestureRecognizer *)pan {
    // 位移量
    CGPoint translatePoint = CGPointZero;
    // 开始手势时的位置
    if (pan.state == UIGestureRecognizerStateBegan) {
        begin = [pan locationInView:self.view];
        transform = self.centerViewController.view.transform;
    }
    // 手势过程中的位置
    if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint end = [pan locationInView:self.view];
        translatePoint = CGPointMake(end.x - begin.x, 0);
    }
    // 手势结束时的位置
    if (pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateEnded) {
        if ([pan velocityInView:self.view].x > 0) {
            // 动画设置动画时长
            [self showLeftViewController:0.13];
        }else {
            [self hideLeftViewController:0.13];
        }
        return;
    }
    // 手势过程中，对视图进行位移
    if(self.centerViewController.view.transform.tx >= 0 && self.centerViewController.view.transform.tx <= kMenuLeftWidth) {
        self.centerViewController.view.transform = CGAffineTransformTranslate(transform, translatePoint.x, 0);
        self.leftViewController.view.transform = CGAffineTransformTranslate(transform,translatePoint.x, 0);
        self.LFtableView.transform = CGAffineTransformTranslate(transform, translatePoint.x, 0);
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
