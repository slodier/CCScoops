//
//  PaomaModel.m
//  跑马灯
//
//  Created by CC on 2016/10/18.
//  Copyright © 2016年 CC. All rights reserved.
//

#import "CCPaomaModel.h"

@implementation CCPaomaModel

#pragma mark -- 获取路径
+ (NSString *)filename {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *filename = [path stringByAppendingPathComponent:@"paomadeng.plist"];
    return filename;
}

#pragma mark -- 移除跑马灯 plist
+ (void)removePaomaPlist {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *filename  = [path stringByAppendingPathComponent:@"paomadeng.plist"];
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filename]) {
        [fileManager removeItemAtPath:filename error:&error];
        if (error) {
            NSLog(@"paomadeng remove failed");
        }else{
            NSLog(@"paomadeng remove successed");
        }
    }else{
        NSLog(@"paomadeng is't exists");
    }
}

@end
