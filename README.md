# CCScoops
## Change log

January 5th: Backstage returns to frontstage, unlimited playback `bug`<br>
December 21: Use `FMDB` replace `plist`<br>

## Implementation ideas
1.Create a singleton Label</br>
2.Store received data locally `sqlite`,Each time one piece of data is fetched, the current data is deleted after the animation is executed, and then the next piece of data is fetched.</br>
3.According to the animation agent, monitor the end of animation execution and set the animation instance to `nil`</br>
4.Determine whether the animation instance is empty, so that switching interfaces and tickers continue instead of starting again</br>
5.Switch interfaces, pause and resume animations</br>
6.Go back to the foreground and re-add the animation because the animation has changed</br>
## Function
1.Switch interface to continue playing</br>
2.Enter the background to pause playback, return to the foreground to continue playback</br>
## How to use?

## adding data

 ```obj-c
    NSDictionary *dict = @{@"username":@"Jin Sanpang",
                           @"count":@"3",
                           @"prize_name":@"Japan.avi"};
    /** Insert data into database **/
    [_ccPaomaModel insert:dict];
    if (self.paomaView.hidden == YES) {
        [_paomaView showPaomaView:self.view];
    }
```

<h3>Switch interface, front and back operations</h3>

```obj-c
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
