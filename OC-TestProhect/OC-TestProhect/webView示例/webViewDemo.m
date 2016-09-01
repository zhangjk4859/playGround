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
    //[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.sogou.com"]]];
   NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    
    self.webView.delegate = self;
    
   NSMethodSignature *signature = [webViewDemo instanceMethodSignatureForSelector:@selector(openFlash)];
    NSInvocation *invocation = [NSInvocation invocati];
    
}

- (IBAction)forward:(UIBarButtonItem *)sender {
    [self.webView goForward];

}

- (IBAction)backward:(UIBarButtonItem *)sender {
    
     [self.webView goBack];
}
- (IBAction)refresh:(UIBarButtonItem *)sender {
    [self.webView reload];
    
}

- (IBAction)homePage:(UIBarButtonItem *)sender {
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.sogou.com"]]];
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
    
    [self.webView stringByEvaluatingJavaScriptFromString:@""];
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

//请求发出去之前调用，拦截用，在这里做文章和OC进行交互

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
   NSString *urlStr = request.URL.absoluteString;
   NSString *regular = @"zjk://";
    if ([urlStr hasPrefix:regular]) {
        
        //截取出方法
        NSString *methodStr = [urlStr substringFromIndex:regular.length];

        
#pragma clang diagnostic push
        
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        
         [self performSelector:NSSelectorFromString(methodStr) withObject:nil];
        
#pragma clang diagnostic pop
       
        return NO;
    }
    
    //if ([request.URL.absoluteString containsString:@"map"]) return NO;
    
    return YES;
}

-(void)openFlash
{
    NSLog(@"%s",__func__);
}

@end
