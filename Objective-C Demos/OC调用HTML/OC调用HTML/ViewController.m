//
//  ViewController.m
//  OC调用HTML
//
//  Created by 张俊凯 on 16/9/22.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载网页
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    
  }



#pragma mark 直接操作网页
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //删除
    NSString *str = @"var word = document.getElementById('word');";
    NSString *str2 = @"word.remove();";
    
    
    //用来执行JS代码
    [webView stringByEvaluatingJavaScriptFromString:str];
    [webView stringByEvaluatingJavaScriptFromString:str2];
    
    //更改内容
    NSString *str3 = @"var change = document.getElementsByClassName('change')[0];""change.innerHTML = '第N个';";
    [webView stringByEvaluatingJavaScriptFromString:str3];
    
    //插入
    NSString *str4 = @"var img = document.createElement('img');"
                      "img.src = 'img_01.jpg';"
                      "img.width = '160';"
                      "img.height = '80';"
                      "document.body.appendChild(img);";
    [webView stringByEvaluatingJavaScriptFromString:str4];
    
}

@end
