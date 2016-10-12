//
//  FloatViewController.m
//  scrollView侧拉
//
//  Created by 张俊凯 on 16/10/12.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "FloatViewController.h"

@interface FloatViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIView *bar;
@end

@implementation FloatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor  yellowColor];
    scrollView.contentSize = CGSizeMake(1000, 1000);
    
    //加一个开关
    UISwitch *swi = [[UISwitch alloc] init];
    [scrollView addSubview:swi];
    
    //加一个横幅
    UIView *bar = [[UIView alloc] init];
    bar.frame = CGRectMake(0, 70, self.view.frame.size.width, 50);
    bar.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    [scrollView addSubview:bar];
    self.bar = bar;
    
    //再加一个按钮
    UISwitch *swi1 = [[UISwitch alloc] init];
    [scrollView addSubview:swi1];
    CGRect swiF = swi1.frame;
    swiF.origin.x = 0;
    swiF.origin.y = 150;
    swi1.frame = swiF;
    
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y >= 70) {
//        self.bar.frame = CGRectMake(0, 0,self.view.frame.size.width, 50);
//        [self.view addSubview:self.bar];
        
        self.bar.frame = CGRectMake(0, scrollView.contentOffset.y,self.view.frame.size.width, 50);
    }else{
//        self.bar.frame = CGRectMake(0, 70,self.view.frame.size.width, 50);
//        [scrollView addSubview:self.bar];
    }
    
}


@end
