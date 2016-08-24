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
    
}
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



@end
