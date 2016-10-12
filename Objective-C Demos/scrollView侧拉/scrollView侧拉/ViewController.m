//
//  ViewController.m
//  scrollView侧拉
//
//  Created by 张俊凯 on 16/10/12.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property(nonatomic,weak)UIView *topBar;
@property(nonatomic,weak)UIView *leftBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    CGFloat contentW = 500;
    CGFloat contentH = 1000;
    
    CGFloat barSpacing = 50;
    
    
    
    //右下角内容
    UIView *contentView = [[UIView alloc] init];
    contentView.frame = CGRectMake(barSpacing, barSpacing,contentW - barSpacing,contentH - barSpacing);
    contentView.backgroundColor = [UIColor yellowColor];
    [scrollView addSubview:contentView];
    
    //顶部条
    UIView *topBar = [[UIView alloc] init];
    topBar.frame = CGRectMake(barSpacing, 0, contentW, barSpacing);
    topBar.backgroundColor = [UIColor redColor];
    [scrollView addSubview:topBar];
    self.topBar = topBar;
    
    //左边条
    UIView *leftBar = [[UIView alloc] init];
    leftBar.frame = CGRectMake(0, barSpacing, barSpacing, contentH);
    leftBar.backgroundColor = [UIColor greenColor];
    [scrollView addSubview:leftBar];
    self.leftBar = leftBar;
    
    //scrollView尺寸
    scrollView.contentSize = CGSizeMake(contentW, contentH);
    scrollView.delegate = self;
    
    
    //添加空隙View
    UIView *coverView = [[UIView alloc] init];
    [self.view addSubview:coverView];
    coverView.frame = CGRectMake(0, 0, barSpacing, barSpacing);
    coverView.backgroundColor = [UIColor whiteColor];
    
    
    
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect leftF = self.leftBar.frame;
    CGRect topF = self.topBar.frame;
    
    topF.origin.y = scrollView.contentOffset.y;
    self.topBar.frame = topF;
    
    leftF.origin.x = scrollView.contentOffset.x;
    self.leftBar.frame = leftF;
    
}




@end
