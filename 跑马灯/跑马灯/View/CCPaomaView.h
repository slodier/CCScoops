//
//  PaomaView.h
//  跑马灯
//
//  Created by CC on 2016/10/18.
//  Copyright © 2016年 CC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCPaomaView : UIView

@property (nonatomic, strong) NSMutableArray *array; //跑马的数组
@property (nonatomic, assign) int aniTime; //动画循环次数

//单例
+ (instancetype)shareManager;
//动画执行次数
- (void)paomaAniamtion:(CGFloat)count;
//开始跑
- (void)showPaomaView:(UIView *)view;
//暂停动画
- (void)pauseAnimation;
//恢复动画
-(void)resumeAnimation;

@end
