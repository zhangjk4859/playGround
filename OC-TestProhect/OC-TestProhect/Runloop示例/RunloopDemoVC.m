//
//  RunloopDemoVC.m
//  OC-TestProhect
//
//  Created by 张俊凯 on 16/8/27.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "RunloopDemoVC.h"

@interface RunloopDemoVC ()

@end

@implementation RunloopDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
}

-(void)observerDemo
{
    //故事主线，给工头添加一个监控
    //步骤一，建立一个监控
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        NSLog(@"监听工头的状态 --- %lu",activity);
    });
    //步骤二，添加监控给工头
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    //释放内存
    CFRelease(observer);
}

/**
 *  在CF框架中，Create Copy Release后，必须要FRelease();
 */


-(void)runTest
{
  static  int i = 0;
    
        NSLog(@"%p,%d",[NSRunLoop currentRunLoop],i);
        i++;
    
    
}

-(void)timer2
{
    //这种定时器默认加入runloop普通模式
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runTest) userInfo:nil repeats:YES];
    //但是依然可以更改模式为通用模式
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    
}


-(void)testTimer
{
    //self.view.backgroundColor = [UIColor redColor];
    //接下来是工头的故事
    //    NSRunLoop *runloop;
    //
    //    CFRunLoopGetMain();
    //    CFRunLoopGetCurrent();
    //
    //    [NSRunLoop currentRunLoop];
    //    [NSRunLoop mainRunLoop];
    //    NSLog(@"%p",[NSRunLoop mainRunLoop]);
    //
    //  NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(runTest) object:nil];
    //    [thread start];
    
    //每个人自动配置一个工头来监视
    
   
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(runTest) userInfo:nil repeats:YES];
    
    //加监督开始干活
    //[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];//令牌，哪个监工都管用
    
    //普通模式跑
    //[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    //只在视图滚动时候工作
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
}


@end
