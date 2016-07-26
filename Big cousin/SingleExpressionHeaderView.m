//
//  SingleExpressionHeaderView.m
//  Big cousin
//
//  Created by Mushroom on 16/7/20.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "SingleExpressionHeaderView.h"

#define SWidth self.bounds.size.width
#define SHeight self.bounds.size.height

@interface SingleExpressionHeaderView ()
/** 分享视图 */
@property (nonatomic, strong) UIView *shareView;

@end

@implementation SingleExpressionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupUI];//KColorLightBlue
        self.backgroundColor = KColorLightBlue;
        NSLog(@"---%@",NSStringFromCGRect(self.frame));
    }
    return self;
}

- (void)setupUI
{
    //表情展示框
    _singleImageView = [[UIImageView alloc] init];
    _singleImageView.backgroundColor = [UIColor whiteColor];
    [_singleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [self addSubview:_singleImageView];
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(-20);
        make.left.mas_equalTo(25);
        make.width.mas_equalTo(SWidth/4.0f);
    }];
    NSLog(@"%@",NSStringFromCGRect(_singleImageView.frame));
    
    /*
    //分享按钮view
    _shareView = [[UIView alloc] init];
    [self addSubview:_shareView];
    _singleImageView.backgroundColor = [UIColor redColor];

    CGFloat shareWidth = SWidth- SWidth/4.0f;
    [_shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-25);
        make.width.mas_equalTo(shareWidth);
        make.height.equalTo(_singleImageView.mas_height);
    }];

    //分享按钮
    UILabel *label = [[UILabel alloc] init];
    label.text = @"发送表情到：";
    label.textColor = KColorHighGray;
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        [_shareView addSubview:label];
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
    }];
    
    CGFloat btnWidth = SWidth/10.0f+28;
    CGFloat btnOffset = (shareWidth - btnWidth*4)/5.0f;
    
    UIButton *QQBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self setRadius:QQBtn];
    QQBtn.backgroundColor = [UIColor whiteColor];
    [QQBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        [_shareView addSubview:QQBtn];
        make.top.equalTo(label.mas_bottom).offset(15);
        make.left.equalTo(label.mas_left);
        make.height.and.width.mas_equalTo(btnWidth);
    }];
    
    UIButton *webo = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self setRadius:webo];
    webo.backgroundColor = [UIColor whiteColor];
    [webo mas_makeConstraints:^(MASConstraintMaker *make) {
        [_shareView addSubview:webo];
        make.size.equalTo(QQBtn);
        make.top.equalTo(QQBtn.mas_top);
        make.left.equalTo(QQBtn.mas_right).offset(btnOffset);
    }];
    
    UIButton *downLoad = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self setRadius:downLoad];
    downLoad.backgroundColor = [UIColor whiteColor];
    [downLoad mas_makeConstraints:^(MASConstraintMaker *make) {
        [_shareView addSubview:downLoad];
        make.size.equalTo(QQBtn);
        make.top.equalTo(QQBtn.mas_top);
        make.left.equalTo(webo.mas_right).offset(btnOffset);
    }];
    
    UIButton *head = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self setRadius:head];
    head.backgroundColor = [UIColor whiteColor];
    [head mas_makeConstraints:^(MASConstraintMaker *make) {
        [_shareView addSubview:head];
        make.size.equalTo(QQBtn);
        make.top.equalTo(QQBtn.mas_top);
        make.right.mas_equalTo(0);
    }];
    
    UIButton *wechatBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self setRadius:wechatBtn];
    wechatBtn.backgroundColor = [UIColor whiteColor];
    
    [wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        [_shareView addSubview:wechatBtn];
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(btnWidth*3.0f+btnOffset*2-28, btnWidth));
    }];
    
    UIButton *circle = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self setRadius:circle];
    circle.backgroundColor = [UIColor whiteColor];
    [circle mas_makeConstraints:^(MASConstraintMaker *make) {
        [_shareView addSubview:circle];
        make.size.equalTo(QQBtn);
        make.bottom.equalTo(wechatBtn.mas_bottom);
        make.right.mas_equalTo(0);
    }];
     //*/
}

- (void)setRadius:(UIView *)object
{
    object.layer.masksToBounds = YES;
    object.layer.cornerRadius = 7.0f;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
