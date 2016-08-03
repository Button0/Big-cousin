//
//  smileViewController.m
//  Big cousin
//
//  Created by wuhan107 on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "smileViewController.h"


@interface smileViewController ()
@end

@implementation smileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(turn:)];
    
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:self.view.bounds];
#warning 这里可以改一下文字
    label1.text = @"我们是一款制作图片和分享图片的app，同时还兼有娱乐功能";
    label1.numberOfLines = 0;
    [self.view addSubview:label1];

}


-(void)turn:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];

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
