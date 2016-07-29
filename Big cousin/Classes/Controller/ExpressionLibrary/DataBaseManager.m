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

//归档
#define KExpressionPack @"expressions"
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
        NSLog(@"打开数据库成功");
        NSString *createSql = @"create table if not exists ExpressionPack(eId text NOT NULL, coverUrl text NOT NULL, eName text NOT NULL, data BLOB)";
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
    NSString *sql = @"insert into ExpressionPack (eId, coverUrl, eName, data) values (?, ?, ?, ?);";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK)
    {
        sqlite3_bind_text(stmt, 1, [pack.eId UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [pack.coverUrl UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, pack.eName.UTF8String, -1, NULL);
        
        NSString *archiverKey = [NSString stringWithFormat:@"%@%@",KExpressionPack, pack.eId];
        NSData *data = [self dataOfArchiverObject:pack forKey:archiverKey];
        
        sqlite3_bind_blob(stmt, 4, [data bytes], (int)[data length], NULL);
        
        sqlite3_step(stmt);
        NSLog(@"插入成功");
    }
    
    sqlite3_finalize(stmt);
}

//删除某表情包
- (ExpressionLibraryModel *)deleteExpressionPack:(NSString *)ID
{
    [self openDB];
    sqlite3_stmt *stmt = nil;
    NSString *sql = @"delete from ExpressionPack where eId = ?";
    
    ExpressionLibraryModel *model = nil;

    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK)
    {
        NSLog(@"删除成功");
        sqlite3_bind_text(stmt, 1, [ID UTF8String], -1, NULL);
        if (sqlite3_step(stmt) == SQLITE_ROW)
        {
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 0) length:sqlite3_column_bytes(stmt, 0)];
            NSString *archiverKey = [NSString stringWithFormat:@"%@%@",KExpressionPack,ID];
            model = [self unarchiverObject:data forKey:archiverKey];
        }
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
    return model;
}

//获取某个表情对象
- (ExpressionLibraryModel *)selectExpressionPackWithID:(NSString *)ID
{
    [self openDB];
    sqlite3_stmt * stmt = nil;
    char *sql = "select data from ExpressionPack where eId = ?";
    
    ExpressionLibraryModel *model = nil;
    
    if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) == SQLITE_OK)
    {
        sqlite3_bind_text(stmt, 1, [ID UTF8String], -1, NULL);
        if (sqlite3_step(stmt) == SQLITE_ROW)
        {
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 0) length:sqlite3_column_bytes(stmt, 0)];
            NSString *archiverKey = [NSString stringWithFormat:@"%@%@",KExpressionPack,ID];
            model = [self unarchiverObject:data forKey:archiverKey];
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
    char *sql = "select * from ExpressionPack where eId = ? and data = ?;";
    
    NSMutableArray *packArray = [NSMutableArray array];
    
    if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL) == SQLITE_OK)
    {
        ExpressionLibraryModel *model = [[ExpressionLibraryModel alloc] init];
        while (sqlite3_step(stmt) == SQLITE_ROW)
        {
            model.eId = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            model.coverUrl = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            model.eName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            [packArray addObject:model];
            
//            NSString * eId = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
//
//            NSData * data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
//            
//            NSString * archiverKey = [NSString stringWithFormat:@"%@%@",KExpressionPack,eId];
//            
//            ExpressionLibraryModel * act = [self unarchiverObject:data forKey:archiverKey];
//            [packArray addObject:act];
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

- (BOOL)isDelectExpressionPackWithID:(NSString *)ID;
{
    ExpressionLibraryModel * act = [self deleteExpressionPack:ID];
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

//将对象归档
- (NSData *)dataOfArchiverObject:(id)object forKey:(NSString *)key
{
    NSMutableData * data = [NSMutableData data];
    
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:object forKey:key];
    [archiver finishEncoding];
    
    return data;
}

//反归档
- (id)unarchiverObject:(NSData *)data forKey:(NSString *)key
{
    NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    id object = [unarchiver decodeObjectForKey:key];
    
    [unarchiver finishDecoding];
    
    return object;
}


@end
