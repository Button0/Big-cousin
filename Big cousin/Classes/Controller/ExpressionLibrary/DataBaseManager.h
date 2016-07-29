//
//  DataBaseManager.h
//  Big cousin
//
//  Created by Mushroom on 16/7/28.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ExpressionLibraryModel;
@interface DataBaseManager : NSObject

+ (DataBaseManager *)shareInstance;

/** 打开数据库 */
- (void)openDB;
/** 关闭数据库 */
- (void)closeDB;

/** 收藏表情包 */
- (void)insertNewExpressionPack:(ExpressionLibraryModel *)pack;

- (ExpressionLibraryModel *)deleteExpressionPack:(NSString *)ID;

- (ExpressionLibraryModel *)selectExpressionPackWithID:(NSString *)ID;

- (NSMutableArray *)selectAllExpressionPack;

/** 判断是否被收藏 */
- (BOOL)isFavoriteExpressionPackWithID:(NSString *)ID;
- (BOOL)isDelectExpressionPackWithID:(NSString *)ID;

@end
