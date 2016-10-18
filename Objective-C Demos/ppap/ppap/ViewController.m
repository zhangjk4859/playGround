//
//  ViewController.m
//  ppap
//
//  Created by 张俊凯 on 16/10/17.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *pen = @"pen";
    NSString *apple = @"apple";
    NSString *pineApple = @"pineApple";

    NSString *ppap = [self ppap:[self ppap:pen :pineApple] :[self ppap:apple :pen]];
    NSLog(@"%@",ppap);
    
    
}

-(NSString *)ppap:(NSString *)a :(NSString *)b
{
    return [[a stringByAppendingString:@"-"] stringByAppendingString:b];
}

@end
