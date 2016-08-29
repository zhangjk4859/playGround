//
//  NSURLConnectionDemo.m
//  OC-TestProhect
//
//  Created by 张俊凯 on 16/8/29.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "NSURLConnectionDemo.h"

@interface NSURLConnectionDemo ()<NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@end

@implementation NSURLConnectionDemo

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self delegateAsync];
}

-(void)delegateAsync
{
   
    //1
//    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=520it&pwd=520it"];
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/images/minion_01.png"];
    //2
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3 默认自动开始
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    [NSURLConnection connectionWithRequest:request delegate:self];
//   NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
//    [con start];
    
    
}

#pragma mark NSURLConnectionDataDelegate
//代理故事三部曲
//接收到响应
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"%s",__func__);
}
//开始接受数据,大会调用多次
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%s  %zd",__func__,data.length);
}

//完成
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"%s",__func__);
}


- (IBAction)login {
    
    /**
      * NSURLConnection的故事
      * 1.找哪个服务器
      * 2.准备好正式的需求
      * 3.开始发出去
     */
    NSString *name = self.nameTextField.text;
    NSString *pwd = self.pwdTextField.text;
    
    //1
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://120.25.226.186:32812/login?username=%@&pwd=%@",name,pwd]];
    //2
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3 block 是预测代码，延迟代码，
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
    }];
}


@end
