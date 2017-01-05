//
//  PaomaModel.h
//  跑马灯
//
//  Created by CC on 2016/10/18.
//  Copyright © 2016年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface CCPaomaModel : NSObject

#pragma mark -- 查询数据库
- (NSMutableArray *)selectTable;

#pragma mark -- 插入进表
- (void)insert:(NSDictionary *)dict;

#pragma mark - 修改某个值
- (void)updateCount:(NSMutableArray *)array;

#pragma mark -- 删除某行
- (void)deleteRow:(NSString *)rowId;

#pragma mark - 删除数据库
- (void)removeSqlite;

@end
