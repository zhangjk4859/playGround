//
//  AddRunloopDemo.m
//  OC-TestProhect
//
//  Created by 张俊凯 on 16/8/28.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "AddRunloopDemo.h"

@interface AddRunloopDemo ()
/**轨道*/
@property(nonatomic,strong)NSThread *thread;
@end

@implementation AddRunloopDemo

- (void)viewDidLoad {
    [super viewDidLoad];

    //故事情节，添加一条轨道，添加一个工头
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [_thread start];
    
    //线程退出函数
    //[NSThread exit];
}

-(void)run
{
    //故事情节  活--->告诉工头----> 干活
    //做完一次就释放一次，罐车全部倒掉，工头睡觉之前
    @autoreleasepool {
        
       //活
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTest) userInfo:nil repeats:YES];
        
        //开工
        [[NSRunLoop currentRunLoop] run];
        
    }
}

//-(void)run
//{
//    //故事情节  活--->告诉工头----> 干活
//    //活
//    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerTest) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//    
//    [[NSRunLoop currentRunLoop] run];
//}

//-(void)run
//
////两大原则，干那些活，活呢？
//{
//    NSLog(@"%s",__func__);
//    //添加工头要管的活
//    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
//    //添加工头
//    [[NSRunLoop currentRunLoop] run];
//    NSLog(@"---------");
//}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}

-(void)test
{
    NSLog(@"%s",__func__);
}

-(void)timerTest
{
    NSLog(@"%s",__func__);
}
@end
