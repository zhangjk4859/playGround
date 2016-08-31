//
//  webViewDemo.m
//  OC-TestProhect
//
//  Created by 张俊凯 on 16/8/31.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "webViewDemo.h"

@interface webViewDemo ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backward;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *forward;
@end

@implementation webViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    self.webView.delegate = self;
}

- (IBAction)forward:(UIBarButtonItem *)sender {
    [self.webView goForward];

}

- (IBAction)backward:(UIBarButtonItem *)sender {
    
     [self.webView goBack];
}
- (IBAction)refresh:(UIBarButtonItem *)sender {
    [self.webView reload];
    [self.webView ];
}

#pragma mark UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    self.backward.enabled = self.webView.canGoBack;
    self.forward.enabled = self.webView.canGoForward;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.backward.enabled = self.webView.canGoBack;
    self.forward.enabled = self.webView.canGoForward;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
@end
