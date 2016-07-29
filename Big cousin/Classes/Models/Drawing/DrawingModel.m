//
//  DrawingModel.m
//  Big cousin
//
//  Created by HMS,CK,LYB,SS on 16/7/16.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DrawingModel.h"

@implementation DrawingModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+ (NSMutableArray *)parseDrawingWihArray:(NSArray *)array
{
    NSArray *drawing = [array lastObject];
    NSMutableArray *returnDrawing = [NSMutableArray array];
    for (NSDictionary *dict in drawing) {
    DrawingModel *model = [[DrawingModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [returnDrawing addObject:model];
    }
    return returnDrawing;
}

@end
