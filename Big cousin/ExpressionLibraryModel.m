//
//  ExpressionLibraryModel.m
//  Big cousin
//
//  Created by Mushroom on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "ExpressionLibraryModel.h"

@implementation ExpressionLibraryModel

//表情库首页cell解析
+ (NSMutableArray *)presentLibraryCellWithArray:(NSArray *)array
{
    NSMutableArray<ExpressionLibraryModel *> *returnData = [NSMutableArray array];
    if (array.count >= 3
        && [[array objectAtIndex:2] isKindOfClass:[NSArray class]])
    {
        NSMutableArray *categoryArray = [array objectAtIndex:2];
        for (NSDictionary *dataDictionary in categoryArray)
        {
            ExpressionLibraryModel *model = [[ExpressionLibraryModel alloc] init];
            [model setValuesForKeysWithDictionary:dataDictionary];
            [returnData addObject:model];
        }
    }
    else
    {
        NSLog(@"Error: datat Error %@", array);
    }
    return returnData;
}

//最新最热解析
+ (NSMutableArray *)presentPublicWithArray:(NSArray *)array
{
    NSMutableArray *returnData = [NSMutableArray array];
    if (array.count >= 3
        && [[array objectAtIndex:2] isKindOfClass:[NSArray class]])
    {
        NSArray *categoryArray = [array objectAtIndex:2];
        for (NSMutableDictionary *dict in categoryArray)
        {
            ExpressionLibraryModel *model = [[ExpressionLibraryModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [returnData addObject:model];
        }
    }
    else
    {
        NSLog(@"Error: data error %@", array);
    }
    return returnData;
}

//轮播图
+ (NSMutableArray *)presentCycleWithDictionary:(NSDictionary *)dict
{
    NSMutableArray <ExpressionLibraryModel *> *returnData = [NSMutableArray array];
    NSString *urlString = [NSString string];
    NSMutableArray *totalArray = [NSMutableArray array];
    [totalArray addObject:returnData];
    
    NSDictionary *data = [dict objectForKey:@"data"];
    NSArray *itemViewList = [data objectForKey:@"itemViewList"];
    for (NSDictionary *items in itemViewList)
    {
        ExpressionLibraryModel *model = [[ExpressionLibraryModel alloc] init];
        [model setValuesForKeysWithDictionary:items];
        [returnData addObject:model];
        urlString = returnData[0].gifPath;
        [totalArray addObject:urlString];
    }
    return totalArray;
}

//点击详情单个表情组
+ (NSMutableArray *)presentSingleWithArray:(NSArray *)array
{
    NSMutableArray <ExpressionLibraryModel *> *returnData = [NSMutableArray array];
    NSString *urlString = [NSString string];
    NSMutableArray *totalArray = [NSMutableArray array];
    [totalArray addObject:returnData];
    
    if (array.count >= 3
        && [[array objectAtIndex:2] isKindOfClass:[NSArray class]])
    {
        NSArray *categoryArray = [array objectAtIndex:2];
        for (NSMutableDictionary *dict in categoryArray)
        {
            ExpressionLibraryModel *model = [[ExpressionLibraryModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [returnData addObject:model];
            urlString = [returnData[0].Url replacingStringToURL];
            [totalArray addObject:urlString];
        }
    }
    else
    {
        NSLog(@"Error: data error %@", array);
    }
    return totalArray;
}

@end
