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

/** 收藏表情包 */
- (void)insertNewExpressionPack:(ExpressionLibraryModel *)pack;

- (void)deleteExpressionPack:(NSString *)ID;

- (ExpressionLibraryModel *)selectExpressionPackWithID:(NSString *)ID;

- (NSMutableArray *)selectAllExpressionPack;

/** 判断是否被收藏 */
- (BOOL)isFavoriteExpressionPackWithID:(NSString *)ID;

@end
