//
//  SingleExpressionHeaderView.m
//  Big cousin
//
//  Created by Mushroom on 16/7/20.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "SingleExpressionHeaderView.h"
#import "SingleExpressionViewController.h"
#import "SVProgressHUD.h"

#define SWidth self.bounds.size.width
#define SHeight self.bounds.size.height

@interface SingleExpressionHeaderView ()
/** 分享视图 */
@property (nonatomic, strong) UIView *shareView;
/** 分享按钮 */
@property (nonatomic, strong) UIButton *QQBtn;
@property (nonatomic, strong) UIButton *weibo;
@property (nonatomic, strong) UIButton *download;
@property (nonatomic, strong) UIButton *head;
@property (nonatomic, strong) UIButton *wechatBtn;
@property (nonatomic, strong) UIButton *circle;

@end

@implementation SingleExpressionHeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setupUI];
        self.backgroundColor = KColorLightBlue;
    }
    return self;
}

- (void)setupUI
{
    //表情展示框
    _singleImageView = [[UIImageView alloc] init];
    _singleImageView.contentMode = UIViewContentModeScaleAspectFit;
    _singleImageView.clipsToBounds = YES;
    [self addSubview:_singleImageView];
    
    //分享按钮容器
    _shareView = [[UIView alloc] init];
    [self addSubview:_shareView];
    
    //分享提示
    UILabel *label = [[UILabel alloc] init];
    label.text = @"得瑟表情给：";
    label.adjustsFontSizeToFitWidth = YES;
    [label.text stringByAppendingString:@"\n "];
    label.textColor = KColorHighGray;
    [_shareView addSubview:label];

    //分享按钮
    _QQBtn = [self addButtonWithImage:@"QQicon" action:@selector(QQshare:)];
    _weibo = [self addButtonWithImage:@"sinaWeibo" action:@selector(weiboShare:)];
    _wechatBtn = [self addButtonWithImage:@"wechat" action:@selector(wechatShare:)];
    _circle = [self addButtonWithImage:@"friendCircle" action:@selector(circleShare:)];
    _download = [self addButtonWithImage:@"downloads" action:@selector(download:)];
    _head = [self addButtonWithImage:@"douban" action:@selector(head:)];
    
    //layout
    [_singleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20.f);
        make.bottom.mas_equalTo(-20.f);
        make.left.mas_equalTo(20.f);
        make.width.mas_equalTo(self.mas_width).multipliedBy(.3f);
    }];

    [_shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_singleImageView.mas_top);//.mas_offset(-8.f);
        make.bottom.mas_equalTo(_singleImageView.mas_bottom);
        make.left.mas_equalTo(_singleImageView.mas_right).offset(22.f);
        make.right.mas_equalTo(self.mas_right).offset(-20.f);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_shareView.mas_left);
        make.right.mas_equalTo(_shareView.mas_right).mas_offset(-80);
        //make.height.mas_greaterThanOrEqualTo(0);
        make.height.mas_equalTo(25.f);
    }];
    
    NSArray *shareVertical = @[label, _QQBtn, _wechatBtn];
    [shareVertical mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:25.f leadSpacing:20.f tailSpacing:20.f];
    
    [_QQBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25.f);
    }];

    NSArray *shareButton1 = @[_QQBtn, _weibo, _download];
    [shareButton1 mas_distributeViewsHorizontalWithFixedItemSize:CGSizeMake(25.f, 25.f) leadSpacing:20.f tailSpacing:10.f];

    NSArray *shareButton2 = @[_wechatBtn, _circle, _head];
    [shareButton2 mas_distributeViewsHorizontalWithFixedItemSize:CGSizeMake(25.f, 25.f) leadSpacing:20.f tailSpacing:10.f];
}

//分享
- (void)QQshare:(UIButton *)sender
{
    [self.sharedelegate QQshare:sender];
}

- (void)weiboShare:(UIButton *)sender
{
    [self.sharedelegate weiboShare:sender];
}

- (void)wechatShare:(UIButton *)sender
{
    [self.sharedelegate wechatShare:sender];
}

- (void)circleShare:(UIButton *)sender
{
    [self.sharedelegate circleShare:sender];
}

- (void)head:(UIButton *)sender
{
//    [self.sharedelegate doubanShare:sender];
}

- (UIButton *)download:(UIButton *)sender
{
    [[_download rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self saveImageBtn];
    }];
    return _download;
}

//保存图片
-(void)saveImageBtn
{
    if(_singleImageView.image != nil)
    {
        UIImageWriteToSavedPhotosAlbum(_singleImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
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
        [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"sure"]];
        [SVProgressHUD showSuccessWithStatus:@"save success"];
    }
}

/** 圆角设置 */
- (void)setRadius:(UIView *)object
{
    object.layer.masksToBounds = YES;
    object.layer.cornerRadius = 7.0f;
}

- (UIButton *)addButtonWithImage:(NSString *)imageName action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
    [button addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    [self setRadius:button];
    [_shareView addSubview:button];
    
    return button;
}

@end
