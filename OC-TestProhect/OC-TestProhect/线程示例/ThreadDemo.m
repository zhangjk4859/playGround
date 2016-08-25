//
//  ThreadDemo.m
//  OC-TestProhect
//
//  Created by 张俊凯 on 16/8/24.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "ThreadDemo.h"
#import <pthread.h>
@interface ThreadDemo ()

@end

@implementation ThreadDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 *  pthread
 *
 *  @param sender <#sender description#>
 */
- (IBAction)buttonClick:(UIButton *)sender
{
    
    pthread_t thread;
    pthread_create(&thread, NULL, run, NULL);
    
    
}

void *run(void *param)
{
    NSLog(@"%s",__func__);
    return NULL;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self creatThreadThree];
    
}

/**
 *  隐式创建线程
 */

-(void)creatThreadThree
{
    //[self performSelectorInBackground:@selector(threadRun:) withObject:@"backGround"];
    [self performSelectorOnMainThread:@selector(threadRun:) withObject:@"mainThread" waitUntilDone:NO];
}

/**
 *  拿到线程做简单的事情
 */
-(void)threadTwo
{
    [NSThread detachNewThreadSelector:@selector(threadRun:) toTarget:self withObject:@"lily"];
}

/**
 *  可单独定制线程
 */
-(void)creatThreadOne
{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadRun:) object:@"kevin"];
    thread.name = @"kevinThread";
    [thread start];
    
    
}

/**
 *  耗时操作
 *
 *  @param params <#params description#>
 */
-(void)threadRun:(NSString *)params
{
    for (int i = 0; i < 10000; i++) {
        NSLog(@"-----run------%@ ----%@",params,[NSThread currentThread].name);
    }
}



@end
