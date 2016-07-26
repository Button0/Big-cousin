//
//  DrawingHottesModel.m
//  Big cousin
//
//  Created by HMS,CK,LYB,SS on 16/7/16.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DrawingHottesModel.h"

@implementation DrawingHottesModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+ (NSMutableArray *)presentDrawingHottesWithArray:(NSArray *)array
{
    NSArray *drawing = [array lastObject];
    NSMutableArray *returnDrawing = [NSMutableArray array];
    for (NSDictionary *dict in drawing) {
        DrawingHottesModel *model = [[DrawingHottesModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [returnDrawing addObject:model];
    }
    return returnDrawing;

}

@end
