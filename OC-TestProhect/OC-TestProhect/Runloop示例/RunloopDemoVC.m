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
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runTest) userInfo:nil repeats:YES];
    //加监督开始干活
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    //[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
}

-(void)runTest
{
  static  int i = 0;
    
        NSLog(@"%p,%d",[NSRunLoop currentRunLoop],i);
        i++;
    
    
}

@end
