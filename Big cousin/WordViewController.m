//
//  WordViewController.m
//  Big cousin
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "WordViewController.h"

static NSString *aText;

@interface WordViewController ()

@property (strong, nonatomic) UIView* changeView;

@property (strong, nonatomic) UIBarButtonItem *scaleItem;

@property (strong, nonatomic) UILabel * myLabel;

@end


@implementation WordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"👈🏿" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
    
    
    [self addRightnavigationItem];

}
//点击方法
- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
//自定义navigationItem
- (void)addRightnavigationItem
{
    //完成按钮
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"完成" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor colorWithRed:38.0/255.0 green:217.0/255 blue:165.0/255 alpha:1] forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(0, 0, 40, 30);
    btn.layer.cornerRadius = 10;

    [btn addTarget:self action:@selector(rightBarItemClicked:) forControlEvents:(UIControlEventTouchUpInside)];
 
    UIBarButtonItem *finishItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    //比例按钮
    _scaleItem = [[UIBarButtonItem alloc]initWithTitle:@"2:1" style:(UIBarButtonItemStylePlain) target:self action:@selector(scaleItemClicked:)];
    self.navigationItem.rightBarButtonItems = @[finishItem,_scaleItem];
    //添加一个textView
    _changeView = [[UIView alloc]initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 250)];
    _changeView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.changeView];

    
    /** 添加一个button */
    UIButton *wordButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    wordButton.frame = CGRectMake(self.view.bounds.size.width - 100, self.view.bounds.size.height -100 , 50, 50);
    [wordButton setTitle:@"字" forState:(UIControlStateNormal)];
    wordButton.layer.cornerRadius = 25;
    [wordButton addTarget:self action:@selector(wordButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    wordButton.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:wordButton];
    _myLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 0, 0)];
    _myLabel.backgroundColor= [UIColor yellowColor];
    _myLabel.textColor = [UIColor blackColor];
    _myLabel.numberOfLines = 0;
    _myLabel.textAlignment = NSTextAlignmentCenter;
//    _myLabel.text = @"按实际的父亲为家人和银联卡说对方空间的回复近段时间分地方的";

    
    [_changeView addSubview:_myLabel];
    
    NSLog(@"%@",NSStringFromCGRect(self.myLabel.frame));
    NSLog(@"%@",NSStringFromCGRect(_myLabel.frame));
    
    NSLog(@"===========%@",self.myLabel.text);

   
}

//button点击方法
- (void)rightBarItemClicked:(UIButton *)btn
{
    
}

- (void)scaleItemClicked:(UIButton *)btn
{
    if ([self.scaleItem.title isEqualToString:@"2:1"]) {
        ;
        self.scaleItem.title = @"1:1";
        self.changeView.frame = CGRectMake(0, 150, self.view.frame.size.width, 350);
        
    }else if ([self.scaleItem.title isEqualToString:@"1:1"]){

        self.scaleItem.title = @"3:4";
        self.changeView.frame =CGRectMake(100, 150, self.view.frame.size.width - 200, 300);
        
    }else if ([self.scaleItem.title isEqualToString:@"3:4"]) {
        self.scaleItem.title = @"2:1";
        self.changeView.frame = CGRectMake(0, 200, self.view.frame.size.width, 250);
        
    }
    
}

- (void)wordButtonClicked:(UIButtonType *)btn
{
    [self addAlertingColler];
    
}

/** 添加弹框 */
-(void)viewWillAppear:(BOOL)animated
{
     [self addAlertingColler];
}


- (void)addAlertingColler
{
    //定义一个中间变量
    __block UITextField * tempFeild = [[UITextField alloc] init];
    __weak typeof(self)weakSelf = self;
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"编辑文字" message:@"输入内容" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        //赋值
    weakSelf.myLabel.text = tempFeild.text;
        
        [weakSelf.myLabel sizeToFit];
        
        weakSelf.myLabel.frame = CGRectMake(10, 10, 150, weakSelf.myLabel.frame.size.height);
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
         tempFeild = textField;
         tempFeild.placeholder = @"请输入文字";
        
    }];
    [alertC addAction:action];
    [alertC addAction:cancel];
    
    [self presentViewController:alertC animated:YES completion:^{
        
    }];

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
