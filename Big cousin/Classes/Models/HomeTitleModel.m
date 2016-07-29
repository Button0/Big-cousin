//
//  HomeTitleModel.m
//  Big cousin
//
//  Created by Mushroom on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "HomeTitleModel.h"

@implementation HomeTitleModel

+ (NSMutableArray *)parseTitlesWithArray:(NSArray *)array
{
    NSMutableArray *returnData = [NSMutableArray array];
    NSMutableArray<NSString*> *eId = [NSMutableArray array];
    NSMutableArray *totalArray = [NSMutableArray arrayWithObjects:returnData, eId, nil];
    
    if (array.count >= 3
        && [[array objectAtIndex:2] isKindOfClass:[NSArray class]])
    {
        NSArray *categoryArray = [array objectAtIndex:2];
        for (NSMutableDictionary *category in categoryArray)
        {
            HomeTitleModel *model = [[HomeTitleModel alloc] init];
            [model setValuesForKeysWithDictionary:category];
            [returnData addObject:model];
            [eId addObject:model.eId];
        }
    }
    else
    {
        NSLog(@"Error: data error %@", array);
    }
    return totalArray;
}

@end
