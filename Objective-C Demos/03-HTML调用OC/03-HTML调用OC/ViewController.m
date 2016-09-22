//
//  ViewController.m
//  03-HTML调用OC
//
//  Created by 张俊凯 on 16/9/22.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate,UINavigationControllerDelegate,UIPickerViewDelegate>
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


#pragma UIWebViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //可以截取到每一次的请求
    NSString *str = request.URL.absoluteString;
//    NSLog(@"%@",str);
    NSRange range = [str rangeOfString:@"zjk://"];
    
    //能找到
    if (range.location != NSNotFound) {
        //把协议头取消掉
        NSString *method = [str substringFromIndex:range.location + range.length];
        NSLog(@"%@",method);
        SEL sel = NSSelectorFromString(method);
        [self performSelector:sel];
    }
    
    
    return YES;
}


//访问相册的方法
-(void)getImage{
    UIImagePickerController *pickerImg =[[UIImagePickerController alloc] init];
    pickerImg.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:pickerImg animated:YES completion:nil];
}

@end
