</br>实现思路</br>
1.创建一个单例 Label</br>
2.把接收的数据存在本地的 plist，不适用于大量数据，每次读取第一个数据，读取完成删除整个 plist，再把剩下的重新存进 plist</br>
3.根据动画代理，监听动画执行结束，将动画实例置为 nil</br>
4.判断动画实例是否为空，使得切换界面，跑马灯继续，而不是重新开始</br>
5.切换界面，暂停、恢复动画</br>
<hr width=70% size=3 color=bule alingn=center  /></br>
<b>功能</b></br>
1.切换界面继续播放</br>
2.进入后台暂停播放，回到前台继续播放</br>
<hr width=70% size=3 color=bule alingn=center  /></br>
<h2>用法</h2></br>
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
        [_paomaView showPaomaView:self.view];
        [_paomaView resumeAnimation];
}

- (void)viewWillDisappear:(BOOL)animated {
        [_paomaView pauseAniamtion];
}
```
