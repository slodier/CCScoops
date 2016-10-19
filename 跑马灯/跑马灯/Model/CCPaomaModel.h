//
//  PaomaModel.h
//  跑马灯
//
//  Created by CC on 2016/10/18.
//  Copyright © 2016年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCPaomaModel : NSObject

//跑马 plist 的路径
+ (NSString *)filename;

//删掉跑马 plist
+ (void)removePaomaPlist;

@end
