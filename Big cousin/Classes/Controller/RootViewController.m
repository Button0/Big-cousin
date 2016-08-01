//
//  RootViewController.m
//  Big cousin
//
//  Created by HMS on 16/7/13.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "RootViewController.h"
#import "ExpressionLibraryViewController.h"
#import "DrawingViewController.h"
#import "XFEssenceViewController.h"

@interface RootViewController ()
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : KColorCartoonBlue } forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : KColorGlyodin } forState:UIControlStateSelected];
    UITabBarItem *item = [UITabBarItem appearance];
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateSelected];
    self.tabBarItem.imageInsets = UIEdgeInsetsMake(0, -10, -6, -10);

    [self setTabBar];
    
}

//setTabBar
- (void)setTabBar
{
    ExpressionLibraryViewController *packVC = [[ExpressionLibraryViewController alloc] init];
    UIImage * exHomenormalImage = [[UIImage imageNamed:@"bqName@2x.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * exHomeselectImage = [[UIImage imageNamed:@"bqNames@2x.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    packVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:exHomenormalImage selectedImage:exHomeselectImage];
    
    UINavigationController *naPackVC = [[UINavigationController alloc] initWithRootViewController:packVC];
    naPackVC.tabBarItem = packVC.tabBarItem;
    
    DrawingViewController *drawVC = [[DrawingViewController alloc] init];
    UIImage * drHomenormalImage = [[UIImage imageNamed:@"1names@2x.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * drHomeselectImage = [[UIImage imageNamed:@"1name@2x.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    drawVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"大制作" image:drHomenormalImage selectedImage:drHomeselectImage];
    UINavigationController *naDrawVC = [[UINavigationController alloc] initWithRootViewController:drawVC];
    naDrawVC.tabBarItem = drawVC.tabBarItem;
    
    XFEssenceViewController *xfeVC = [[XFEssenceViewController alloc] init];
    UIImage * xfHomenormalImage = [[UIImage imageNamed:@"playerName@2x.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * xfHomeselectImage = [[UIImage imageNamed:@"playerqName@2x.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    xfeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"不得姐" image:xfHomenormalImage selectedImage:xfHomeselectImage];
    UINavigationController *naBigVC = [[UINavigationController alloc] initWithRootViewController:xfeVC];
    naBigVC.tabBarItem = xfeVC.tabBarItem;
    
    self.viewControllers = @[naPackVC,naDrawVC,naBigVC];
}

- (void)addSystemTabBarItem:(UIViewController *)viewController title:(NSString *)title imageName:(NSString *)image selectedImage:(NSString *)selectedImage
{
    viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:image] selectedImage:[UIImage imageNamed:selectedImage]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
