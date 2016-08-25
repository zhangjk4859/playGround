//
//  ViewController.m
//  OC-TestProhect
//
//  Created by 张俊凯 on 16/8/24.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_queue_t queue = dispatch_queue_create("kevin", DISPATCH_QUEUE_CONCURRENT);//允许工头可以多人同时干活
    
    dispatch_async(queue, ^{
        
    });//工头会派遣多人去干活
    
    dispatch_sync(queue, ^{
        
    });//工头只会派一个人干活
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //dispatch_queue_t queue = dispatch_queue_create("kevin", DISPATCH_QUEUE_CONCURRENT);//允许工头可以多人同时干活
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });//工头会派遣多人去干活
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });//工头会派遣多人去干活
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });//工头会派遣多人去干活
    
}

@end
