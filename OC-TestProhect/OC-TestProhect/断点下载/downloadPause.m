//
//  downloadPause.m
//  OC-TestProhect
//
//  Created by 张俊凯 on 16/9/2.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "downloadPause.h"

//视频资源路径
#define videoURLStr @"http://120.25.226.186:32812/resources/videos/minion_01.mp4"

//下载文件安放路径
#define downloadFilePath  [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"test.mp4"]

//已经下载文件（包括半成品）的长度
#define existFileLength [[[NSFileManager defaultManager] attributesOfItemAtPath:downloadFilePath error:nil][NSFileSize] integerValue]


@interface downloadPause ()<NSURLSessionDataDelegate>
/**下载任务*/
@property(nonatomic,strong)NSURLSessionDataTask *task;
/**下载会话*/
@property(nonatomic,strong)NSURLSession *session;
/**把文件从内存写到硬盘的流处理对象*/
@property(nonatomic,strong)NSOutputStream *stream;
/**
 *  文件的总长度
 */
@property(nonatomic,assign)NSInteger fileLength;
@end

@implementation downloadPause

//session懒加载
- (NSURLSession *)session
{
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    }
    return _session;
}
//stream 懒加载
- (NSOutputStream *)stream
{
    if (!_stream) {
        _stream = [NSOutputStream outputStreamToFileAtPath:downloadFilePath append:YES];
    }
    return _stream;
}

//task懒加载
- (NSURLSessionDataTask *)task
{
    if (!_task) {
        
        //创建请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:videoURLStr]];
        //设置请求头 从已经存在的长度开始下载
        NSInteger start = existFileLength;
        NSString *range = [NSString stringWithFormat:@"bytes=%zd-",start];
        [request setValue:range forHTTPHeaderField:@"Range"];
        
        //创建一个data任务
        _task  = [self.session dataTaskWithRequest:request];
        
    }
    return _task;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    

}

- (IBAction)start:(UIButton *)sender {
    
    
    [self.task resume];
}

- (IBAction)pause:(UIButton *)sender {
    [self.task suspend];
}




#pragma mark NSURLSessionDataDelegate
//接受到数据第一次响应
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    [self.stream open];
    
    self.fileLength = [response.allHeaderFields[@"Content-Length"] integerValue] + existFileLength;//上次已经下载好的文件长度
    
    //允许接受服务器数据
    completionHandler(NSURLSessionResponseAllow);
    
}


//接受到具体的数据
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    //写入数据
    [self.stream write:data.bytes maxLength:data.length];
    
    //打印下载进度
    NSLog(@"%f",1.0 * existFileLength / self.fileLength);
}

//下载完毕以后
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    //关闭写入流
    [self.stream close];
    self.stream = nil;
}

@end
