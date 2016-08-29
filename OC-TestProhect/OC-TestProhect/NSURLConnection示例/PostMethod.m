//
//  PostMethod.m
//  OC-TestProhect
//
//  Created by 张俊凯 on 16/8/29.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "PostMethod.h"

@interface PostMethod ()

@end

@implementation PostMethod

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self chinesePOST];

}

-(void)chinesePOST
{
    //0
    NSString *str = @"http://120.25.226.186:32812/login2";
    
    //1
    NSURL *url = [NSURL URLWithString:str];
    
    //2
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"?username=汉字&pwd=111" dataUsingEncoding:NSUTF8StringEncoding];
    //3 block 是预测代码，延迟代码，
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
    }];

}

-(void)chineseGET
{
    //0
    NSString *str = @"http://120.25.226.186:32812/login2?username=汉字&pwd=111";
    //URL进行转码
    str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //1
    NSURL *url = [NSURL URLWithString:str];
    
    //2
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3 block 是预测代码，延迟代码，
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
    }];
}

-(void)commonPost
{
    //1  ?username=520it&pwd=520it
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login"];
    //2
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"username=520it&pwd=520it" dataUsingEncoding:NSUTF8StringEncoding];
    request.timeoutInterval = 5.0;
    //设置请求头
    // [request setValue:@"Android" forHTTPHeaderField:@"User-Agent"];
    
    //3
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (connectionError) {//请求失败
            NSLog(@"%@",connectionError);
        }else{
            NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            
        }
        
    }];
}



@end
