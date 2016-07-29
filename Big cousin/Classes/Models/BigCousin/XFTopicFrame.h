//
//  XFTopicFrame.h
//  XFBaiSiBuDeJie
//
//  Created by shishuai on 16/7/23.
//  Copyright © 2016年 shishuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFTopicModel.h"

@interface XFTopicFrame : NSObject
@property (nonatomic,strong)XFTopicModel *topic;
@property (assign, nonatomic) CGFloat cellHeight;
@property (assign, nonatomic) CGRect  contentViewFrame;//图片或视频或声音内容尺寸
@end
