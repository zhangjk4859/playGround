//
//  NSOperationQueueDemo2.m
//  OC-TestProhect
//
//  Created by 张俊凯 on 16/8/26.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "NSOperationQueueDemo2.h"

@interface NSOperationQueueDemo2 ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic,weak)NSOperationQueue *queue;
@end

@implementation NSOperationQueueDemo2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//每一段程序，都是一段故事
-(void)downloadImage
{
    //建立队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //建立任务
    __block UIImage *image1;
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        //下载第一张图片
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://banbao.chazidian.com/uploadfile/2016-01-25/s145368924044608.jpg"]];
        image1 = [UIImage imageWithData:data];
    }];
    
    __block UIImage *image2;
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        //下载第二张图片
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://pic32.nipic.com/20130829/12906030_124355855000_2.png"]];
        image2 = [UIImage imageWithData:data];
        
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        //合成图片
        UIGraphicsBeginImageContext(CGSizeMake(375, 667));
        
        [image1 drawInRect:CGRectMake(0, 0, 375, 333.5)];
        image1 = nil;
        [image2 drawInRect:CGRectMake(0, 333.5, 375, 333.5)];
        image2 = nil;
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        //回到主线程更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageView.image = image;
        }];
        
    }];
    //添加依赖
    [op3 addDependency:op1];
    [op3 addDependency:op2];
    
    //加入队列
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}
-(void)operationQueue3
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];//怎么样干活
    
    [NSOperationQueue mainQueue];//主工人干活
    
    //并发队列分两种，全局和自己创建
    //串行队列有两种，主队列和自己创建
    //NSOperation 是即将要干的活
    
    
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download1------%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download2------%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download3------%@",[NSThread currentThread]);
    }];
    
    //设置依赖性
    [op3 addDependency:op1];
    [op3 addDependency:op2];
    //依然是子线程执行
    op3.completionBlock = ^{
        NSLog(@"下载完成以后------%@",[NSThread currentThread]);
    };
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}

-(void)operationQueue2
{
    
    self.queue.suspended = YES;
    
    //取消所有的操作，正在进行中的操作会执行完
    [self.queue cancelAllOperations];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //    queue.maxConcurrentOperationCount = 3;
    queue.maxConcurrentOperationCount = 1;//串行队列
    self.queue = queue;
    
    [queue addOperationWithBlock:^{
        for (NSInteger i = 0; i <  5000; i ++) {
            NSLog(@"download1--%zd----%@",i,[NSThread currentThread]);
            //[NSThread sleepForTimeInterval:0.1];
        }
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"download2------%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"download3------%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.0];
    }];
}

-(void)operationQueue1
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //    queue.maxConcurrentOperationCount = 3;
    queue.maxConcurrentOperationCount = 1;//串行队列
    
    [queue addOperationWithBlock:^{
        NSLog(@"download1------%@",[NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"download2------%@",[NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"download3------%@",[NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"download4------%@",[NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"download5------%@",[NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"download6------%@",[NSThread currentThread]);
    }];
}
-(void)operationQueue
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];//怎么样干活
    
    [NSOperationQueue mainQueue];//主工人干活
    
    //并发队列分两种，全局和自己创建
    //串行队列有两种，主队列和自己创建
    //NSOperation 是即将要干的活
    
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download1) object:nil];
    
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download2) object:nil];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download3------%@",[NSThread currentThread]);
    }];
    [op3 addExecutionBlock:^{
        NSLog(@"download4------%@",[NSThread currentThread]);
    }];
    [op3 addExecutionBlock:^{
        NSLog(@"download5------%@",[NSThread currentThread]);
    }];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperationWithBlock:^{
        //直接添加要干的活
    }];
    //可以开多条轨道同时干活
}
-(void)download1
{
    NSLog(@"download1------%@",[NSThread currentThread]);//哪一条轨道干活
}

-(void)download2
{
    NSLog(@"download2------%@",[NSThread currentThread]);//哪一条轨道干活
}


@end
