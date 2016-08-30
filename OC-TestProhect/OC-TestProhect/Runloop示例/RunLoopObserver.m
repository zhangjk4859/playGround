//
//  RunLoopObserver.m
//  OC-TestProhect
//
//  Created by 张俊凯 on 16/8/30.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "RunLoopObserver.h"

@interface RunLoopObserver ()<NSURLConnectionDataDelegate>
/**输出流*/
@property(nonatomic,strong)NSOutputStream *stream;
/**runloop*/
@property(nonatomic,assign)CFRunLoopRef runloop;
@end

@implementation RunLoopObserver

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //如果在子线程启动，会无法回调代理方法
        //子线程开启工头，必须要自己开启，自己停掉,开启和代理不是同一个线程（打印验证）
        NSURLConnection *conn = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"]] delegate:self];
        
        //[[NSRunLoop currentRunLoop] run];
        self.runloop = CFRunLoopGetCurrent();
        CFRunLoopRun();
        
    });

    //故事主线，用资源搜索器，找视频下载到沙盒缓存，会自动在子线程进行，但是必须在主线程启动，因为主线程会监控数据回调
//    NSURLConnection *conn = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"]] delegate:self];
    //决定代理方法在子线程执行
    //[conn setDelegateQueue:[[NSOperationQueue alloc] init]];

}

#pragma mark NSURLConnectionDelegate
//接受到响应
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //服务器建议的文件名
    response.suggestedFilename;
    
    //写到沙盒里
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *file = [caches stringByAppendingPathComponent:response.suggestedFilename];
    
    //一个写入硬盘数据的工具，内存传输到硬盘
    self.stream = [[NSOutputStream alloc] initToFileAtPath:file append:YES];
    NSLog(@"%@",file);
    [self.stream open];
    
}

//开始接受数据
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [self.stream write:[data bytes] maxLength:data.length];
    NSLog(@"-----data");
}

//下载结束
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.stream close];
    NSLog(@"-----DidFinish");
    CFRunLoopStop(self.runloop);
}

-(void)addObserver
{
    //监听到工头进来，说明要干活了，就创建一个自动释放池（罐车）
    //kCFRunLoopEntry = (1UL << 0),
    
    //工头要睡觉或者不干了，就把销毁自动释放池（罐车翻掉货）
    //kCFRunLoopBeforeWaiting = (1UL << 5),（销毁一个，创建一个）
    //kCFRunLoopExit = (1UL << 7),
    
    
    //故事重要情节，开一条线程，增加一个监控
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(execute) object:nil];
    [thread start];
}

-(void)execute
{
    
    //从C语言给工头增加一个摄像头（observer）
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"-----%lu",activity);
    });
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    CFRelease(observer);
    
    //增加一个工头（runloop）
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSRunLoopCommonModes];
    [[NSRunLoop currentRunLoop] run];
    NSLog(@"------");
}



@end
