//
//  ViewController.m
//  02-制作HTML页面
//
//  Created by 张俊凯 on 16/9/22.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,weak)UIActivityIndicatorView *activityView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //加载网页
//    NSURL *url = [NSURL URLWithString:@"http://m.xianhua.com.cn/"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"flowers" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    self.webView.scrollView.hidden = YES;
    self.webView.backgroundColor = [UIColor grayColor];
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityView startAnimating];
    activityView.center = self.view.center;
    [self.webView addSubview:activityView];
    self.activityView = activityView;

}

#pragma UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    NSString *str1 = @"var h1 = document.getElementsByTagName('h1')[0];"
//                      "h1.innerHTML = '日本樱花网';";
//    [webView stringByEvaluatingJavaScriptFromString:str1];
//    
//    //删除尾部
//     NSString *str2 =  @"document.getElementById('footer').remove();";
//    [webView stringByEvaluatingJavaScriptFromString:str2];
//    
//    //拿出网页所有内容
//    NSString *str3 = @"document.body.outerHTML";
//  NSString *html =  [webView stringByEvaluatingJavaScriptFromString:str3];
//    NSLog(@"%@",html);
    
    
    //显示完毕后
    self.webView.scrollView.hidden = NO;
    self.activityView.hidden = YES;
}

@end
