//
//  ChildVC.m
//  跑马灯
//
//  Created by CC on 2016/10/19.
//  Copyright © 2016年 CC. All rights reserved.
//

#import "ChildVC.h"
#import "CCPaomaView.h"

#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ChildVC ()

@property (nonatomic, strong) CCPaomaView *paomaView;
@property (nonatomic, strong) UIButton *backBtn;

@end

@implementation ChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backBtn];
    
    _paomaView = [CCPaomaView shareManager];
}

- (void)backClick {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark -- 界面出现、消失，创建、恢复、暂停动画
- (void)viewWillAppear:(BOOL)animated {
    [_paomaView showPaomaView:self.view];
    [_paomaView resumeAnimation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [_paomaView pauseAnimation];
}

#pragma mark -- getter
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0.08 *KScreenWidth, 0.08 *KScreenWidth)];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

@end
