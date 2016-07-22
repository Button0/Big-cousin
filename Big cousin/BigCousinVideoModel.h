//
//  BigCousinVideoModel.h
//  Big cousin
//
//  Created by HMS,CK,LYB,SS on 16/7/15.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BigCousinVideoModel : NSObject

@property (nonatomic, copy) NSString * title;

@property (nonatomic, assign) NSInteger  upNum;

@property (nonatomic, assign) NSInteger  downNum;

@property (nonatomic, assign) NSInteger  commentNum;

@property (nonatomic, assign) NSInteger  shareNum;

@property (nonatomic, strong)NSString * userId;

@property (nonatomic, copy) NSString * playTime;

@property (nonatomic, assign) NSInteger clickNum;



@end
