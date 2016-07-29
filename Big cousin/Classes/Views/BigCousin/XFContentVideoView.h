//
//  XFContentVideoView.h
//  XFBaiSiBuDeJie
//
//  Created by shishuai on 16/7/23.
//  Copyright © 2016年 shishuai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XFTopicModel;

@interface XFContentVideoView : UIView
@property (nonatomic, strong) XFTopicModel *topic;
+(instancetype)videoView;
- (void)reset;
@end
