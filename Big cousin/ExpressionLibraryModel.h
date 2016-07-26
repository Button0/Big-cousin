//
//  ExpressionLibraryModel.h
//  Big cousin
//
//  Created by Mushroom on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "BaseModel.h"

@interface ExpressionLibraryModel : BaseModel

/** 图片 */
@property (nonatomic, strong) NSString *coverUrl;
/** 名字 */
@property (nonatomic, strong) NSString *eName;
/** id */
@property (nonatomic, strong) NSNumber *eId;
/** 备忘标题 */
@property (nonatomic, strong) NSString *memo1;

//singleExpression key
/** 单个图片url */
@property (nonatomic, strong) NSString *Url;
/** 轮播图 */
@property (nonatomic, strong) NSString *gifPath;

/** 表情库首页cell解析 */
+ (NSMutableArray *)presentLibraryCellWithArray:(NSArray *)array;
/** 最新最热解析 */
+ (NSMutableArray *)presentPublicWithArray:(NSArray *)array;
/** 轮播图 */
+ (NSMutableArray *)presentCycleWithDictionary:(NSDictionary *)dict;
/** 点击详情组后单个表情组 */
+ (NSMutableArray *)presentSingleWithArray:(NSArray *)array;

@end
