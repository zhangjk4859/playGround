//
//  ServicesListener.m
//  OC-TestProhect
//
//  Created by 张俊凯 on 16/9/7.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "ServicesListener.h"
#import "GCDAsyncSocket.h" 
@interface ServicesListener()<GCDAsyncSocketDelegate>
/**<#注释#>*/
@property(nonatomic,strong)GCDAsyncSocket *socket;
/**客户端的socket组*/
@property(nonatomic,strong)NSMutableArray *clientSockets;
@end

@implementation ServicesListener
- (NSMutableArray *)clientSockets
{
    if (!_clientSockets) {
        _clientSockets = [NSMutableArray array];
    }
    return _clientSockets;
}
-(void)start
{
    //创建socket对象 在子线程
    GCDAsyncSocket *server =[[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    self.socket = server;
    
    //绑定端口 并且监听
    NSError * error = nil;
    [server acceptOnPort:3001 error:&error];
    if (!error) {//如果没有错误，开启成功
        NSLog(@"开启成功");
    }else{
        NSLog(@"打印错误日志%@",error);
    }
    
    //开启监听
}

#pragma MARK  GCDAsyncSocketDelegate

//收到了连接请求
-(void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    [self.clientSockets addObject:newSocket];
    NSLog(@"server%@ client%@",sock,newSocket);
    //-1代表不超时，开启监听客户端数据
    [newSocket readDataWithTimeout:-1 tag:0];
}

//读取到数据
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
   // NSLog(@"didReadDataSocket%@",sock);
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"服务器接收到数据%@",str);
    
    str = [str stringByAppendingString:@"服务器收到了"];
    NSData *strData = [str dataUsingEncoding:NSUTF8StringEncoding];
    //服务器返回给客户端的数据
    [sock writeData:strData withTimeout:-1 tag:0];
    
    //读完数据以后都要调用一下监听的方法
    [sock readDataWithTimeout:-1 tag:0];
}

@end
