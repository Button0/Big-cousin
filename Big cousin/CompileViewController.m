//
//  CompileViewController.m
//  Big cousin
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "CompileViewController.h"

@interface CompileViewController ()

@property (strong, nonatomic)UIView *comipleView;


@end

@implementation CompileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _comipleView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, self.view.frame.size.width - 200, 300)];
    _comipleView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_comipleView];
    
    
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
