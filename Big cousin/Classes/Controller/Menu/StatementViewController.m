//
//  StatementViewController.m
//  Big cousin
//
//  Created by wuhan107 on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "StatementViewController.h"

@interface StatementViewController ()

@end

@implementation StatementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"严正声明";
    UILabel *ViewLable = [[UILabel alloc]initWithFrame:self.view.bounds];
    ViewLable.text = @"声明个毛线，随便转载随便用，就是这么大方";
    ViewLable.numberOfLines = 0;
    ViewLable.font = [UIFont systemFontOfSize:80];
    [self.view addSubview:ViewLable];
    
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
