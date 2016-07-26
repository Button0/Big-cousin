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
<<<<<<< HEAD
#import "BigCousinViewController.h"
=======
>>>>>>> cb5711d996d27c9995ae0479f5522b35b8add22c
#import "MyViewController.h"

@interface RootViewController ()
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : KColorCartoonBlue } forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : KColorGlyodin } forState:UIControlStateSelected];
    [self setTabBar];
}

//setTabBar
- (void)setTabBar
{
    ExpressionLibraryViewController *packVC = [[ExpressionLibraryViewController alloc] init];
    [self addSystemTabBarItem:packVC title:@"表情库" imageName:@"" selectedImage:@""];
    UINavigationController *naPackVC = [[UINavigationController alloc] initWithRootViewController:packVC];
    naPackVC.tabBarItem = packVC.tabBarItem;
    
    DrawingViewController *drawVC = [[DrawingViewController alloc] init];
    [self addSystemTabBarItem:drawVC title:@"大制作" imageName:@"" selectedImage:@""];
    UINavigationController *naDrawVC = [[UINavigationController alloc] initWithRootViewController:drawVC];
    naDrawVC.tabBarItem = drawVC.tabBarItem;
    
<<<<<<< HEAD
    BigCousinViewController *bigVC = [[BigCousinViewController alloc] init];
=======
    XFEssenceViewController *bigVC = [[XFEssenceViewController alloc] init];
>>>>>>> cb5711d996d27c9995ae0479f5522b35b8add22c
    [self addSystemTabBarItem:bigVC title:@"大表姐" imageName:@"" selectedImage:@""];
    UINavigationController *naBigVC = [[UINavigationController alloc] initWithRootViewController:bigVC];
    naBigVC.tabBarItem = bigVC.tabBarItem;
    
    self.viewControllers = @[naPackVC,naDrawVC,naBigVC];
}

- (void)addSystemTabBarItem:(UIViewController *)viewController title:(NSString *)title imageName:(NSString *)image selectedImage:(NSString *)selectedImage
{
    viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:image] selectedImage:[UIImage imageNamed:selectedImage]];
}

/*
//代理方法
- (void)expressionItemDidClicked:(ExpressionTabBar *)tabbar
{
    self.selectedIndex = tabbar.currentSelected;
}
//*/

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
