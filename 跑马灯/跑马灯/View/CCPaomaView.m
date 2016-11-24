//
//  PaomaView.m
//  跑马灯
//
//  Created by CC on 2016/10/18.
//  Copyright © 2016年 CC. All rights reserved.
//

#import "CCPaomaView.h"
#import "CCPaomaModel.h"

#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

@interface CCPaomaView ()<CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *maskView; //跑马灯底图
@property (nonatomic, strong) UILabel *paomaLabel; //跑马的label
@property (nonatomic, strong) CABasicAnimation *pmAniamtion; //跑马的动画实例
@property (nonatomic, strong) NSUserDefaults *defaults;

@end

@implementation CCPaomaView

#pragma mark -单例,全局跑马灯
+ (instancetype)shareManager {
    static CCPaomaView *pModel = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        pModel = [[CCPaomaView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 0.0468 *KScreenHeight)];
    });
    return pModel;
}

#pragma mark -- 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        [self layoutUI];
        NSDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:[CCPaomaModel filename]];
        _array = [[NSMutableArray alloc]initWithObjects:dict, nil];
        //NSLog(@"paomaArray ---------------- %@",[PaomaModel filename]);
    }
    return self;
}

#pragma mark 构建 UI
- (void)layoutUI {
    CGFloat x = KScreenWidth / 667;
    
    _maskView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 35)];
    [self addSubview:_maskView];
    _maskView.userInteractionEnabled = NO;
    _maskView.image = [UIImage imageNamed:@"跑马底图"];
    _maskView.clipsToBounds = YES;
    
    _paomaLabel = [[UILabel alloc]initWithFrame:_maskView.bounds];
    [_maskView addSubview:_paomaLabel];
    _paomaLabel.textColor = [UIColor whiteColor];
    [_paomaLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15 * x]];
    _paomaLabel.userInteractionEnabled = NO; //设为不可交互，为了传递响应链
}

#pragma mark -- 暂停动画
- (void)pauseAnimation {
    CFTimeInterval pausedTime = [_paomaLabel.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    _paomaLabel.layer.speed = 0.0;
    _paomaLabel.layer.timeOffset = pausedTime;
}

#pragma mark -- 恢复动画
-(void)resumeAnimation
{
    CFTimeInterval pausedTime = [_paomaLabel.layer timeOffset];
    _paomaLabel.layer.speed = 1.0;
    _paomaLabel.layer.timeOffset = 0.0;
    _paomaLabel.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [_paomaLabel.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    _paomaLabel.layer.beginTime = timeSincePause;
    
    //是否进入后台
    _defaults = [NSUserDefaults standardUserDefaults];
    NSString *backStr = [_defaults objectForKey:@"isBack"];
    if ([backStr intValue] == 1) {
        [_paomaLabel.layer addAnimation:_pmAniamtion forKey:@"paoMaDeng"];
        [_defaults setObject:@"0" forKey:@"isBack"];
    }
}

#pragma mark -- 代理监听动画停止
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"%@",[self.paomaLabel.layer animationForKey:@"paoMaDeng"]);
    //记录运行的动画的时间
    _pmAniamtion.timeOffset = anim.timeOffset;
    //如果回到前台
    NSString *backStr = [_defaults objectForKey:@"isBack"];
    if ([backStr intValue] == 0) {
        if ([self.paomaLabel.layer animationForKey:@"paoMaDeng"] == anim) {
            NSDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:[CCPaomaModel filename]];
            _array = [[NSMutableArray alloc]initWithObjects:dict, nil];
            [CCPaomaModel removePaomaPlist];
            [_array writeToFile:[CCPaomaModel filename] atomically:YES];
            //动画停止之后，将实例置为 nil
            _pmAniamtion = nil;
            
            //移除整个 plist
            [CCPaomaModel removePaomaPlist];
            
            //重新写入
            [_array writeToFile:[CCPaomaModel filename] atomically:YES];
            
            //动画停止之后，将实例置为 nil
            _pmAniamtion = nil;
            
            //数组为空之后移除跑马灯
            if (_array.count > 0) {
                [self showPaomaView:self.superview];
            }else{
                self.hidden = YES;
                [self removeFromSuperview];
            }
            NSLog(@"%@",self.array);
        }
    }
}
#pragma mark -- 跑马灯
- (void)showPaomaView:(UIView *)view {

    //判断是否处于隐藏状态
    if (self.hidden == YES) {
        //用字典接收 plist 的数据
        NSDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:[CCPaomaModel filename]];
        //转为数组
        _array = [[NSMutableArray alloc]initWithObjects:dict, nil];
    }
    
    if (_array.count > 0) {
        //名字
        NSString *username = [NSString stringWithFormat:@"%@",_array[0][@"username"]];
        //循环次数
        NSString *animationAount = [NSString stringWithFormat:@"%@",_array[0][@"count"]];
        //商品名
        NSString *goodName = [NSString stringWithFormat:@"%@",_array[0][@"goodName"]];
        _paomaLabel.text   = [NSString stringWithFormat:@"%@购买了%@",username,goodName];
        [view addSubview:self];
        
        [self paomaAniamtion:[animationAount intValue]];
        
        self.hidden = NO;

    }else{
        self.hidden = YES;
    }
}

#pragma mark 执行动画
- (void)paomaAniamtion:(CGFloat)count{
    //判断动画实例存不存在，存在继续，不存在即创建
    if (_pmAniamtion == nil) {
        _pmAniamtion = [CABasicAnimation animation];
        _pmAniamtion.keyPath = @"transform.translation.x";
        CGFloat W = CGRectGetWidth(_paomaLabel.bounds);
        _pmAniamtion.fromValue = @(W);
        _pmAniamtion.toValue = @(-W);
        _pmAniamtion.duration = _aniTime;
        _pmAniamtion.repeatCount = count;
        _pmAniamtion.removedOnCompletion = NO;       //动画结束不移除
        _pmAniamtion.fillMode = kCAFillModeForwards; //动画结束会保持结束的状态
        _pmAniamtion.delegate = self;                //设置代理
        [_paomaLabel.layer addAnimation:_pmAniamtion forKey:@"paoMaDeng"];
    }else{
        _pmAniamtion.repeatCount = count;
    }
}

@end
