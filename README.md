1.创建一个单例 Label</br>
2.把接收的数据存在本地的 plist，不适用于大量数据，每次读取第一个数据，读取完成删除整个 plist，再把剩下的重新存进 plist</br>
3.根据动画代理，监听动画执行结束，将动画实例置为 nil</br>
4.判断动画实例是否为空，使得切换界面，跑马灯继续，而不是重新开始</br>
5.切换界面，暂停、恢复动画</br>
<hr width=70% size=3 color=bule alingn=center  /></br>
<b>用法</b></br>
#pragma mark -- 界面出现、消失，创建、恢复、暂停动画
```Objective-c
- (void)viewWillAppear:(BOOL)animated {
        [_paomaView showPaomaView:self.view];
        [_paomaView resumeAnimation];
}
```
```Objective-c
- (void)viewWillDisappear:(BOOL)animated {
        [_paomaView pauseAniamtion];
}
```
