//
//  WordViewController.m
//  Big cousin
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "WordViewController.h"

@interface WordViewController ()

@property (strong, nonatomic) UITextView *textView;

@property (strong, nonatomic) UIBarButtonItem *scaleItem;


@end

@implementation WordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    self.scaleItem = [[UIBarButtonItem alloc]initWithTitle:@"2:1" style:(UIBarButtonItemStylePlain) target:self action:@selector(scaleItemClicked:)];
    self.navigationItem.rightBarButtonItems = @[finishItem,self.scaleItem];
    //添加一个textView
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 250)];
    self.textView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.textView];

    
    /** 添加一个button */
    UIButton *wordButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    wordButton.frame = CGRectMake(self.view.frame.size.width - 100, self.view.frame.size.height -100 , 50, 50);
    [wordButton setTitle:@"字" forState:(UIControlStateNormal)];
    wordButton.layer.cornerRadius = 25;
    [wordButton addTarget:self action:@selector(wordButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    wordButton.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:wordButton];
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
        self.textView.frame = CGRectMake(0, 150, self.view.frame.size.width, 350);
        
    }else if ([self.scaleItem.title isEqualToString:@"1:1"]){

        self.scaleItem.title = @"3:4";
        self.textView.frame =CGRectMake(100, 150, self.view.frame.size.width - 200, 300);
        
    }else if ([self.scaleItem.title isEqualToString:@"3:4"]) {
        self.scaleItem.title = @"2:1";
        self.textView.frame = CGRectMake(0, 200, self.view.frame.size.width, 250);
        
    }
    
}

- (void)wordButtonClicked:(UIButtonType *)btn
{
    [self addAlertingColler];
}

/** 添加弹框 */
- (void)viewWillAppear:(BOOL)animated
{
    [self addAlertingColler];
}


- (void)addAlertingColler
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"编辑文字" message:@"输入文字" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:nil];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"请输入文字";
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
