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


@interface downloadPause ()<NSURLSessionDelegate>
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
        _session = [NSURLSession sharedSession];
        _session.delegate = self;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
   //文件已经下载的长度
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:downloadFilePath error:nil];
    
    

}

- (IBAction)start:(UIButton *)sender {
    
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:videoURLStr]];
    //设置请求头 从已经存在的长度开始下载
    NSInteger start = existFileLength;
    NSString *range = [NSString stringWithFormat:@"bytes=%zd-",start];
    [request setValue:range forHTTPHeaderField:@"Range"];
    
    //创建一个data任务
    self.task = [self.session dataTaskWithRequest:request];
    
    [self.task resume];
}

- (IBAction)pause:(UIButton *)sender {
}

- (IBAction)continue:(UIButton *)sender {
}


@end
