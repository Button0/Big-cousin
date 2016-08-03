//
//  AppStoreViewController.m
//  Big cousin
//
//  Created by wuhan107 on 16/8/1.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "AppStoreViewController.h"

@interface AppStoreViewController ()

@end

@implementation AppStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIWebView *webV = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webV.backgroundColor = [UIColor whiteColor];
    webV.scalesPageToFit = YES;

    [self.view addSubview:webV];
    [webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.apple.com/cn/itunes/charts/free-apps/"]]];
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
