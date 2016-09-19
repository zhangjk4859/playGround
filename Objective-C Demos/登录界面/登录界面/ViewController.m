//
//  ViewController.m
//  登录界面
//
//  Created by 张俊凯 on 16/9/19.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL fileURLWithPath:@"/Users/kevin/Desktop/个人代码仓库/playGround/HTML Demos/登录界面/index.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];


}

@end
