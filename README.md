#CCScoops
<h2>更新日志</h2>

1月5号: 后台回到前台,无限播放的 `bug`<br>
12月21号: 使用 `FMDB` 更换 `plist`<br>

<h2>实现思路</h2>
1.创建一个单例 Label</br>
2.把接收的数据存在本地的 `sqlite`,每次取一个数据,动画执行完删除当前数据,再取下一条数据</br>
3.根据动画代理，监听动画执行结束，将动画实例置为 `nil`</br>
4.判断动画实例是否为空，使得切换界面，跑马灯继续，而不是重新开始</br>
5.切换界面，暂停、恢复动画</br>
6.回到前台重新添加动画，因为动画已经改变</br>
<h2>功能</h2>
1.切换界面继续播放</br>
2.进入后台暂停播放，回到前台继续播放</br>
<h2>How to use?</h2>
<h3>添加数据</h3>
```Objective-c
    NSDictionary *dict = @{@"username":@"金三胖",
                           @"count":@"3",
                           @"prize_name":@"日韩.avi"};
    /** 数据插入数据库 **/
    [_ccPaomaModel insert:dict];
    if (self.paomaView.hidden == YES) {
        [_paomaView showPaomaView:self.view];
    }
```
<h3>切换界面、前后台操作</h3>
```Objective-c
- (void)applicationDidEnterBackground:(UIApplication *)application {
    CCPaomaView *ccView = [CCPaomaView shareManager];
    [_defaults setObject:@"1" forKey:@"isBack"];
    [ccView pauseAnimation];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    CCPaomaView *pView = [CCPaomaView shareManager];
    [pView resumeAnimation];
}

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
        [_paomaView pauseAniamtion];
}
```
