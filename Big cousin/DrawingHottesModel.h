//
//  DrawingHottesModel.h
//  Big cousin
//
//  Created by HMS,CK,LYB,SS on 16/7/16.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrawingHottesModel : NSObject

/** 图片地址 */
@property (strong, nonatomic) NSString *coverUrl;

/** title */
@property (strong, nonatomic) NSString *eName;

+ (NSMutableArray *)presentDrawingHottesWithArray:(NSArray *)array;


@end
