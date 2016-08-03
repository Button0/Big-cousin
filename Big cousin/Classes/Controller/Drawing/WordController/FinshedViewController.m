//
//  FinshedViewController.m
//  Big cousin
//
//  Created by HMS,CK,SS,LYB on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "FinshedViewController.h"
#import "SVProgressHUD.h"

@interface FinshedViewController ()<UMSocialUIDelegate>

@property (strong, nonatomic) UIView *finshedView;

@property (strong, nonatomic) UILabel *finshedLabel;

@end

@implementation FinshedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"保存/分享";
    self.view.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
    _finshedView = [[UIView alloc]init];
    
    _finshedView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_finshedView];
    //约束
    [_finshedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(10);
        make.left.mas_equalTo(self.view.mas_left).with.offset(50);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-50);
        make.height.mas_equalTo(300);
    }];


    //自定义navigationItem
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, 0, 35, 25);
    [button setTitle:@"分享" forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setTitleColor:[UIColor whiteColor] forState:1];//[UIColor colorWithRed:38.0/255.0 green:38.0/255.0 blue:38.0/255.0 alpha:38.0/255.0] forState:1];
    
    [button addTarget:self action:@selector(rightBarItemClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    //设置圆角
    button.layer.cornerRadius = 10;
    button.backgroundColor = KColorGlyodin;
    UIBarButtonItem *finishItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = @[finishItem];
    
    //添加两个button
    UIButton *saceButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    saceButton.frame = CGRectMake(CGRectGetMinX(_finshedView.frame), CGRectGetMaxY(_finshedView.frame)+20, 80, 30);
    
    _finshedLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    _finshedLabel.backgroundColor = [UIColor redColor];
    _finshedLabel.text = self.labelText;
//    NSLog(@"==========%@", _finshedLabel.text);
    _finshedLabel.numberOfLines = 0;
    [_finshedLabel sizeToFit];
    CGFloat width = self.finshedView.frame.size.width - 20;
    CGRect rect = [_finshedLabel.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName:_finshedLabel.font} context:nil];

    _finshedLabel.frame = CGRectMake(10, 10, width, rect.size.height);

    [_finshedView addSubview:_finshedLabel];
    
    
    
    saceButton.layer.cornerRadius = 15;
    [saceButton addTarget:self action:@selector(saceButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [saceButton setTitle:@"save" forState:(UIControlStateNormal)];
    
    saceButton.backgroundColor = [UIColor grayColor];
    [self.view addSubview:saceButton];
    [saceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.top.mas_equalTo(self.finshedView.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.finshedView.mas_centerX);
    }];

    //button上字体的大小
    /*
    saceButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    
    UIButton *downloadButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [downloadButton setTitle:@"下载至本地" forState:(UIControlStateNormal)];
    downloadButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    downloadButton.layer.cornerRadius = 15;
    [downloadButton addTarget:self action:@selector(downloadClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    downloadButton.backgroundColor = [UIColor grayColor];
    [self.view addSubview:downloadButton];
    [downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.top.mas_equalTo(self.finshedView.mas_bottom).with.offset(10);
//        make.left.mas_equalTo(saceButton.mas_right).with.offset(50);
        make.right.mas_equalTo(self.finshedView.mas_right).with.offset(0);
    }];
//*/
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
    
    
    _imagesV = [[UIImageView alloc]init];
//    _imagesV.backgroundColor = [UIColor redColor];
    [self.finshedView addSubview:_imagesV];
    [_imagesV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.mas_equalTo(_finshedView.mas_centerX);
        make.bottom.mas_equalTo(_finshedView.mas_bottom).with.offset(-10);
    }];
    
    NSData *data = [[NSData alloc]initWithBase64Encoding:self.imageVString];
    UIImage *decodedImage = [UIImage imageWithData:data];
    self.imagesV.image = decodedImage;
}

- (void)leftClicked
{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController popViewControllerAnimated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

//分享
- (void)rightBarItemClicked:(UIButton *)sender
{
    [UMSocialData defaultData].extConfig.title = @"分享的title";
    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"507fcab25270157b37000010"
                                      shareText:self.finshedLabel.text
                                     shareImage:self.imagesV.image
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
                                delegate:self];
}

//保存
- (void)saceButtonClicked:(UIButton *)sender
{
    if(_imagesV.image != nil)
    {
        UIImageWriteToSavedPhotosAlbum(_imagesV.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"download failure..."];
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error)
    {
        [SVProgressHUD showErrorWithStatus:@"save failure"];
    }
    else
    {
        [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"success"]];
        [SVProgressHUD showSuccessWithStatus:@"save success"];
    }
}

//下载
/*
- (void)downloadClicked:(UIButton *)sender
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSData *data = UIImageJPEGRepresentation(self.imagesV.image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//
//    NSURL *URL = [NSURL URLWithString:[encodedImageStr replacingStringToURL]];
//    NSLog(@"encodedImageStr ======== %@",encodedImageStr);
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([path count])>0?[path objectAtIndex:0]:nil;
    NSURL *URL = [NSURL fileURLWithPath:[basePath stringByAppendingPathComponent:encodedImageStr]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}
//*/

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
