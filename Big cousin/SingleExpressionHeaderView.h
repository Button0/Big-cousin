//
//  SingleExpressionHeaderView.h
//  Big cousin
//
//  Created by Mushroom on 16/7/20.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol shareDelegate <NSObject>

- (void)QQshare:(UIButton *)sender;
- (void)weiboShare:(UIButton *)sender;
- (void)wechatShare:(UIButton *)sender;
- (void)circleShare:(UIButton *)sender;
@end

@interface SingleExpressionHeaderView : UIView
/** 点击单个表情图展示框 */
@property (nonatomic, strong) UIImageView *singleImageView;
@property (nonatomic, weak) id<shareDelegate> sharedelegate;

@end
