//
//  FinshedViewController.m
//  Big cousin
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "FinshedViewController.h"

@interface FinshedViewController ()<UMSocialUIDelegate>

@property (strong, nonatomic) UIView *finshedView;

@property (strong, nonatomic) UILabel *finshedLabel;



@end

@implementation FinshedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"保存/分享";
    self.view.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
    _finshedView = [[UIView alloc]initWithFrame:CGRectMake(100, 10,200 , 300)];
    _finshedView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_finshedView];
    //自定义navigationItem
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, 0, 40, 30);
    [button setTitle:@"分享" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor colorWithRed:38.0/255.0 green:38.0/255.0 blue:38.0/255.0 alpha:38.0/255.0] forState:1];
    
    [button addTarget:self action:@selector(rightBarItemClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    //设置圆角
    button.layer.cornerRadius = 10;
    button.backgroundColor = [UIColor redColor];
    UIBarButtonItem *finishItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = @[finishItem];
    
    //添加两个button
    UIButton *saceButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    saceButton.frame = CGRectMake(CGRectGetMinX(_finshedView.frame), CGRectGetMaxY(_finshedView.frame)+20, 80, 30);
    
    _finshedLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    _finshedLabel.backgroundColor = [UIColor redColor];
    _finshedLabel.text = self.labelText;
    NSLog(@"==========%@", _finshedLabel.text);
    _finshedLabel.numberOfLines = 0;
    [_finshedLabel sizeToFit];
    _finshedLabel.frame = CGRectMake(10, 10, 100, _finshedLabel.frame.size.height);

    [_finshedView addSubview:_finshedLabel];
    
    
    
    saceButton.layer.cornerRadius = 15;
    [saceButton addTarget:self action:@selector(saceButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [saceButton setTitle:@"保存到作品" forState:(UIControlStateNormal)];
    
    saceButton.backgroundColor = [UIColor grayColor];
    [self.view addSubview:saceButton];
    //button上字体的大小
    saceButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    
    UIButton *downloadButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    downloadButton.frame = CGRectMake(CGRectGetMaxX(saceButton.frame) + 30, CGRectGetMinY(saceButton.frame) , 80, 30);
    [downloadButton setTitle:@"下载至本地" forState:(UIControlStateNormal)];
    downloadButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    downloadButton.layer.cornerRadius = 15;
    [downloadButton addTarget:self action:@selector(downloadClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    downloadButton.backgroundColor = [UIColor grayColor];
    [self.view addSubview:downloadButton];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"⏮" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
    
}

- (void)leftClicked
{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController popViewControllerAnimated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

//分享
- (void)rightBarItemClicked:(UIButton *)sender
{
    [UMSocialData defaultData].extConfig.title = @"分享的title";
    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"507fcab25270157b37000010"
                                      shareText:self.finshedLabel.text
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
                                       delegate:self];

}
//保存
- (void)saceButtonClicked:(UIButton *)sender
{
    
}
//下载
- (void)downloadClicked:(UIButton *)sender
{
    
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
