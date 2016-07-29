//
//  XFCommentModel.h
//  XFBaiSiBuDeJie
//
//  Created by shishuai on 16/7/23.
//  Copyright © 2016年 shishuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XFUserModel;
@interface XFCommentModel : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) XFUserModel *user;
/** 有声音时的行高 */
@property (nonatomic,assign) CGFloat cellHeight;

@end

