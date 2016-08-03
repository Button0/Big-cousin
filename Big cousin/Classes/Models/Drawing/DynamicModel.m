//
//  DynamicModel.m
//  Big cousin
//
//  Created by HMS,CK,SS,LYB on 16/7/21.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DynamicModel.h"

@implementation DynamicModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+ (NSMutableArray *)presentDynamicWithArray:(NSArray *)array
{
    NSArray *aynamicArr = [array lastObject];
    NSMutableArray *returnArray = [NSMutableArray array];
    for (NSDictionary *dict in aynamicArr) {
        DynamicModel *model = [[DynamicModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [returnArray addObject:model];
    }
    return returnArray;
}

@end
