//
//  ThreadComunicate.m
//  OC-TestProhect
//
//  Created by 张俊凯 on 16/8/25.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "ThreadComunicate.h"

@interface ThreadComunicate ()
@property(nonatomic,weak)UIImageView *imageView;
@end

@implementation ThreadComunicate

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:imageView];
    self.imageView = imageView;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self performSelectorInBackground:@selector(download3) withObject:nil];
}


- (void)download3
{
    // 图片的网络路径
    NSURL *url = [NSURL URLWithString:@"http://www.photophoto.cn/m2/012/001/0120010123.jpg"];
    
    // 加载图片
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    // 生成图片
    UIImage *image = [UIImage imageWithData:data];
    
    // 回到主线程，显示图片
    [self.imageView performSelector:@selector(setImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:NO];
    //    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
    //    [self performSelectorOnMainThread:@selector(showImage:) withObject:image waitUntilDone:YES];
}

//- (void)showImage:(UIImage *)image
//{
//    self.imageView.image = image;
//}

- (void)download2
{
    // 图片的网络路径
    NSURL *url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
    
    CFTimeInterval begin = CFAbsoluteTimeGetCurrent();
    // 根据图片的网络路径去下载图片数据
    NSData *data = [NSData dataWithContentsOfURL:url];
    CFTimeInterval end = CFAbsoluteTimeGetCurrent();
    
    NSLog(@"%f", end - begin);
    
    // 显示图片
    self.imageView.image = [UIImage imageWithData:data];
}

- (void)download
{
    // 图片的网络路径
    NSURL *url = [NSURL URLWithString:@"http://www.photophoto.cn/m2/012/001/0120010123.jpg"];
    
    NSDate *begin = [NSDate date];
    // 根据图片的网络路径去下载图片数据
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDate *end = [NSDate date];
    
    NSLog(@"%f", [end timeIntervalSinceDate:begin]);
    
    // 显示图片
    self.imageView.image = [UIImage imageWithData:data];
}





@end
