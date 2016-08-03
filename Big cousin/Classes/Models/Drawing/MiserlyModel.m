//
//  MiserlyModel.m
//  Big cousin
//
//  Created by HMS,CK,SS,LYB on 16/7/21.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "MiserlyModel.h"

@implementation MiserlyModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+ (NSMutableArray *)presentMiserlyWithArray:(NSArray *)array
{
    NSArray *miserlyArr = [array lastObject];
    NSMutableArray *returnArray = [NSMutableArray array];
    for (NSDictionary *dict in miserlyArr) {
        MiserlyModel *model = [[MiserlyModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [returnArray addObject:model];
    }
    return returnArray;
}



@end
