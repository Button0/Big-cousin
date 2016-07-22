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
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    //表情展示框
    _singleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SWidth/2.0f, SHeight)];
    _singleImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_singleImageView];
    
    _shareView = [[UIView alloc] initWithFrame:CGRectMake(_singleImageView.frame.size.width +25, 0, SWidth/2.0f, SHeight)];
    [self addSubview:_shareView];
    
    //分享按钮
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SWidth/2.0f, SHeight/3.0f-30)];
    label.text = @"发送表情到：";
    label.textColor = KColorHighGray;
    [self.shareView addSubview:label];
    
    for (int num = 0; num < 4; num++)
    {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(0+((SWidth/4.0f-60)*num), label.frame.size.height+20, SWidth/4.0f-60, SHeight/3.0f-30);
        button.backgroundColor = [UIColor redColor];
        [self.shareView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
    }
    UIButton *wechatBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    wechatBtn.frame = CGRectMake(0, SHeight - (SHeight/3.0f), SWidth/2.f+20, SHeight/3.0f-15);
    wechatBtn.backgroundColor = [UIColor whiteColor];
    [self.shareView addSubview:wechatBtn];
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(wechatBtn.frame.size.width+20, SHeight-(SHeight/3.0f), SWidth/4.0f-20, wechatBtn.frame.size.height);
    btn.backgroundColor = [UIColor blueColor];
    [self.shareView addSubview:btn];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
