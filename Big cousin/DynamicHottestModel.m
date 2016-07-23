//
//  DynamicHottestModel.m
//  Big cousin
//
//  Created by HMS,CK,SS,LYB3g on 16/7/21.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DynamicHottestModel.h"

@implementation DynamicHottestModel



- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+ (NSMutableArray *)presentDynamicHottestWithArray:(NSArray *)array
{
    NSArray *dynamicArr = [array lastObject];
    NSMutableArray *returnArray = [NSMutableArray array];
    for (NSDictionary *dict in dynamicArr) {
        DynamicHottestModel *model = [[DynamicHottestModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [returnArray addObject:model];
    }
    return returnArray;
}


@end
