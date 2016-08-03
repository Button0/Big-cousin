//
//  DataBaseManager.m
//  Big cousin
//
//  Created by Mushroom on 16/7/28.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DataBaseManager.h"
#import <sqlite3.h>
#import "ExpressionLibraryModel.h"

//文件名
#define KDataBaseName @"Big_cousin.sqlite"

@implementation DataBaseManager

static DataBaseManager *handle = nil;
+ (DataBaseManager *)shareInstance
{
    if (handle == nil)
    {
        handle = [[[self class] alloc] init];
        [handle openDB];
    }
    return  handle;
}

static sqlite3 *db = nil;

//打开
- (void)openDB
{
    if (db != nil)
    {
        return;
    }
    
    //数据库存储在沙盒中的caches文件
    NSString *dbPath = [self dataBaseFilePath:KDataBaseName];
    
    int result = sqlite3_open([dbPath UTF8String], &db);
    if (result == SQLITE_OK)
    {
        NSString *createSql = @"create table if not exists ExpressionPack(eId text NOT NULL)";
        sqlite3_exec(db, [createSql UTF8String], NULL, NULL, NULL);
    }
}

//关闭
- (void)closeDB
{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK)
    {
        NSLog(@"数据库关闭成功");
        db = nil;
    }
}

//添加新表情包
- (void)insertNewExpressionPack:(ExpressionLibraryModel *)pack
{
    [self openDB];
    sqlite3_stmt *stmt = nil;
    NSString *sql = @"insert into ExpressionPack (eId) values (?);";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK)
    {
        sqlite3_bind_text(stmt, 1, [pack.eId UTF8String], -1, NULL);
        
        int ret = sqlite3_step(stmt);
        if (ret == SQLITE_DONE)
        {
            NSLog(@"插入成功");
        }
        else
        {
            NSLog(@"%s", sqlite3_errmsg(db));
        }
    }
    
    sqlite3_finalize(stmt);
}

//删除某表情包
- (void)deleteExpressionPack:(NSString *)ID
{
    [self openDB];
    sqlite3_stmt *stmt = nil;
    NSString *sql = @"delete from ExpressionPack where eId = ?";
    

    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK)
    {
        sqlite3_bind_text(stmt, 1, [ID UTF8String], -1, NULL);
        int result = sqlite3_step(stmt);

        if (result == SQLITE_DONE)
        {
            NSLog(@"删除ID成功");
        }
        else
        {
            NSLog(@"删除ID失败%s", sqlite3_errmsg(db));
        }
    }

    sqlite3_finalize(stmt);
}

//获取某个表情对象
- (ExpressionLibraryModel *)selectExpressionPackWithID:(NSString *)ID
{
    [self openDB];
    sqlite3_stmt * stmt = nil;
    char *sql = "select * from ExpressionPack where eId = ?";
    
    ExpressionLibraryModel *model = nil;
    
    if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) == SQLITE_OK)
    {
        sqlite3_bind_text(stmt, 1, [ID UTF8String], -1, NULL);

        int result = sqlite3_step(stmt);
        
        if (result == SQLITE_ROW)
        {
            NSLog(@"查询id成功");
            model = [[ExpressionLibraryModel alloc] init];
            model.eId = ID;
        }
        else
        {
            NSLog(@"查询ID nil %s", sqlite3_errmsg(db));
        }
    }
    sqlite3_finalize(stmt);
    return model;
}

//获取所有
- (NSMutableArray *)selectAllExpressionPack
{
    [self openDB];
    sqlite3_stmt *stmt = nil;
    char *sql = "select * from ExpressionPack;";
    
    NSMutableArray *packArray = [NSMutableArray array];
    
    if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(stmt) == SQLITE_ROW)
        {
            ExpressionLibraryModel *model = [[ExpressionLibraryModel alloc] init];
            
            NSString *tempeId = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            model.eId = tempeId;
            
            [packArray addObject:model];
        }
    }
    sqlite3_finalize(stmt);
    return packArray;
}

//判断是否已收藏
- (BOOL)isFavoriteExpressionPackWithID:(NSString *)ID;
{
    ExpressionLibraryModel * act = [self selectExpressionPackWithID:ID];
    if (act == nil)
    {
        return NO;
    }
    return YES;
}

- (NSString *)cachesPath
{
    return  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

//数据库存储的路径
- (NSString *)dataBaseFilePath:(NSString *)dataBaseName
{
    NSLog(@"sandbox－－ %@",[[self cachesPath] stringByAppendingPathComponent:dataBaseName]);
    return [[self cachesPath] stringByAppendingPathComponent:dataBaseName];
}

@end
