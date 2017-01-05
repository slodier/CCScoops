//
//  PaomaView.h
//  跑马灯
//
//  Created by CC on 2016/10/18.
//  Copyright © 2016年 CC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCPaomaView : UIView

@property (nonatomic, strong) NSTimer *timer;  // 定时器

@property (nonatomic, strong) NSMutableArray *array; //跑马的数组
@property (nonatomic, assign) int aniTime; // 动画循环次数

#pragma mark - 单例
+ (instancetype)shareManager;

- (void)paomaAniamtion:(CGFloat)count;


#pragma mark - 跑马灯动画
- (void)showPaomaView:(UIView *)view;

#pragma mark - 暂停动画
- (void)pauseAnimation;

#pragma mark - 恢复动画
-(void)resumeAnimation;

@end
