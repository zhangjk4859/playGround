//
//  MenuController.m
//  OC-TestProhect
//
//  Created by 张俊凯 on 16/9/6.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "MenuController.h"
@interface MenuController()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
@implementation MenuController
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.webView loadHTMLString:@"<div  style=\"color : red\">你好</div>" baseURL:nil];
    
    
}

@end
