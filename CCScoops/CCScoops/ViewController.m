//
//  ViewController.m
//  跑马灯
//
//  Created by CC on 2016/10/18.
//  Copyright © 2016年 CC. All rights reserved.
//

#import "ViewController.h"
#import "CCPaomaView.h"
#import "CCPaomaModel.h"
#import "ChildVC.h"

#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong) CCPaomaView *paomaView;

@property (nonatomic, strong) CCPaomaModel *ccPaomaModel;

@property (nonatomic, strong) UIButton *jumpBtn;
@property (nonatomic, strong) UIButton *addDataBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _paomaView = [CCPaomaView shareManager];
    _paomaView.aniTime = 5;
    
    _ccPaomaModel = [[CCPaomaModel alloc]init];
    
    [self.view addSubview:self.jumpBtn];
    [self.view addSubview:self.addDataBtn];
    
    [self test];
}

#pragma mark -- 创建测试数据
- (void)test {
    NSDictionary *dict = @{@"username":@"小明",
                           @"count":@"5",
                           @"prize_name":@"一汽大众CC"};
    /** 数据插入数据库 **/
    [_ccPaomaModel insert:dict];
    if (self.paomaView.hidden == YES) {
        [_paomaView showPaomaView:self.view];
    }
}

#pragma mark -- 按钮
#pragma mark 添加测试数据
- (void)addData {
    NSDictionary *dict = @{@"username":@"金三胖",
                           @"count":@"3",
                           @"prize_name":@"日韩.avi"};
    /** 数据插入数据库 **/
    [_ccPaomaModel insert:dict];
    if (self.paomaView.hidden == YES) {
        [_paomaView showPaomaView:self.view];
    }
}

#pragma mark 跳转方法
- (void)jumpClick {
    ChildVC *childVC = [[ChildVC alloc]init];
    [self presentViewController:childVC animated:NO completion:nil];
}

#pragma mark -- 界面出现、消失，创建、恢复、暂停动画
- (void)viewWillAppear:(BOOL)animated {
    
    [_paomaView resumeAnimation];
    
    if (_paomaView.hidden == YES) {
        [_paomaView showPaomaView:self.view];
    }
    
    if (_paomaView.array.count > 0) {
        [self.view addSubview:_paomaView];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [_paomaView pauseAnimation];
    
    [_paomaView.timer invalidate];
    _paomaView.timer = nil;
}

#pragma mark -- getter
- (UIButton *)addDataBtn {
    if (!_addDataBtn) {
        _addDataBtn = [[UIButton alloc]initWithFrame:CGRectMake(0.25 *KScreenWidth, (KScreenHeight - 0.1 *KScreenWidth)/2, 0.15 *KScreenWidth, 0.1 *KScreenWidth)];
        _addDataBtn.backgroundColor = [UIColor greenColor];
        [_addDataBtn setTitle:@"添加数据" forState:UIControlStateNormal];
        [_addDataBtn addTarget:self action:@selector(addData) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addDataBtn;
}

- (UIButton *)jumpBtn {
    if (!_jumpBtn) {
        _jumpBtn = [[UIButton alloc]initWithFrame:CGRectMake(0.45 *KScreenWidth, (KScreenHeight - 0.1 *KScreenWidth)/2, 0.15 *KScreenWidth, 0.1 *KScreenWidth)];
        _jumpBtn.backgroundColor = [UIColor greenColor];
        [_jumpBtn setTitle:@"去下级界面" forState:UIControlStateNormal];
        [_jumpBtn addTarget:self action:@selector(jumpClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jumpBtn;
}

@end
