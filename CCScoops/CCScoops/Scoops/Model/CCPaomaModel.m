//
//  PaomaModel.m
//  跑马灯
//
//  Created by CC on 2016/10/18.
//  Copyright © 2016年 CC. All rights reserved.
//

#import "CCPaomaModel.h"

@interface CCPaomaModel ()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation CCPaomaModel

#pragma mark - 数据库路径
- (NSString *)sqlitePath {
    NSString *path = [NSTemporaryDirectory()stringByAppendingString:@"Scoops.db"];
    NSLog(@"path:%@",path);
    return path;
}

#pragma mark - 建数据库
- (void)openDB {
    _db = [FMDatabase databaseWithPath:[self sqlitePath]];
    if ([_db open]) {
        //建表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS UserInfo(id integer PRIMARY KEY AUTOINCREMENT,username text NOT NULL,count text NOT NULL,prize_name text NOT NULL)"];
        if (result) {
            NSLog(@"create table success");
        }else{
            NSLog(@"create tabble success");
            [_db close];
        }
    }else{
        [_db close];
        NSLog(@"open db failed");
    }
}

#pragma mark - 查询数据库
- (NSMutableArray *)selectTable
{
    NSMutableArray *tempArray = [NSMutableArray array];
    if (![_db open]) {
        [self openDB];
    }
    
    if ([_db open]) {
        /** 查询下一条数据 **/
        FMResultSet *resultSet = [_db executeQuery:@"select *from UserInfo limit 1;"];
        while ([resultSet next]) {
            NSString *idStr    = [resultSet objectForColumnName:@"id"];
            NSString *username = [resultSet objectForColumnName:@"username"];
            NSString *count    = [resultSet objectForColumnName:@"count"];
            NSString *prize_name = [resultSet objectForColumnName:@"prize_name"];
            
            [tempArray addObject:idStr];
            [tempArray addObject:username];
            [tempArray addObject:count];
            [tempArray addObject:prize_name];
        }
        [_db close];
    }
    return tempArray;
}

#pragma mark - 更新循环次数
- (void)updateCount:(NSMutableArray *)array {
    if (!_db) {
        [self openDB];
        [_db open];
    }
    NSString *newCount = [NSString stringWithFormat:@"%d",[array[2]intValue] - 1];
    NSLog(@"减掉一个之后的次数:%@",newCount);
    BOOL result = [_db executeUpdate:@"UPDATE UserInfo set count = ?",newCount];
    if (result) {
        NSLog(@"Update success");
    }else{
        NSLog(@"Update failed");
    }
}

#pragma mark -- 插入进表
- (void)insert:(NSMutableDictionary *)dictionary
{
    if (!_db) {
        [self openDB];
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:dictionary];
    [_db executeUpdate:@"INSERT INTO UserInfo(username,count,prize_name)VALUES(?,?,?)",dict[@"username"],dict[@"count"],dict[@"prize_name"]];
}

#pragma mark -- 删除某行
- (void)deleteRow:(NSString *)rowId {
    if (!_db) {
        [self openDB];
    }
    [_db executeUpdate:@"DELETE FROM UserInfo WHERE id = ?",rowId];
}

#pragma mark - 删除数据库
- (void)removeSqlite {
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:[self sqlitePath]]) {
        NSError *error;
        [manager removeItemAtPath:[self sqlitePath] error:&error];
        if (error) {
            NSLog(@"delete sqlite failed");
        }else{
            NSLog(@"exist sqlite");
    }
    }else{
        NSLog(@"Isn't exist sqlite");
    }
}

@end
