//
//  BaseViewController.m
//  Big cousin
//
//  Created by HMS on 16/7/13.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBarController.tabBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    // title set text color
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:KColorGlyodin}];
}

- (void)setupProgressHud
{
    [GiFHUD setGifWithImageName:@"48.gif"];
    [GiFHUD show];
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
