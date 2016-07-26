//
//  XFTalkCell.h
//  XFBaiSiBuDeJie
//
//  Created by shishuai on 16/7/23.
//  Copyright © 2016年 shishuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFTopicFrame.h"

@interface XFTopicCell : UITableViewCell
@property (nonatomic, strong) XFTopicFrame *topicFrame;
+ (instancetype)cell;
@end
