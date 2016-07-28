//
//  weiboViewController.m
//  Big cousin
//
//  Created by wuhan107 on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "weiboViewController.h"

@interface weiboViewController ()

@end

@implementation weiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIWebView *webV = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:webV];
    [webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://weibo.com/5982507523/profile?rightmod=1&wvr=6&mod=personnumber&is_all=1"]]];

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
