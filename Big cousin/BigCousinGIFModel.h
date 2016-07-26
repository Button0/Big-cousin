//
//  BigCousinGIFModel.h
//  Big cousin
//
//  Created by HMS,CK,LYB,SS on 16/7/15.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BigCousinGIFModel : NSObject

@property (nonatomic, copy) NSString * title;

@property (nonatomic, assign) NSInteger  upNum;

@property (nonatomic, assign) NSInteger  downNum;

@property (nonatomic, assign) NSInteger  commentNum;

@property (nonatomic, assign) NSInteger  shareNum;

@property (nonatomic, copy) NSString * gifPath;

@property (nonatomic, strong)NSString * userId;


@end
