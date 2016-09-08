//
//  ViewController.m
//  群聊客户端
//
//  Created by 张俊凯 on 16/9/8.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h"

@interface ViewController ()<UITableViewDataSource,GCDAsyncSocketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**<#注释#>*/
@property(nonatomic,strong)GCDAsyncSocket *clientSocket;
/**消息数组*/
@property(nonatomic,strong)NSMutableArray *messages;

@end

@implementation ViewController

- (NSMutableArray *)messages
{
    if (!_messages) {
        _messages = [NSMutableArray array];
    }
    return _messages;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建socket对象 在子线程
    GCDAsyncSocket *clientSocket =[[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    self.clientSocket = clientSocket;
    
    
    //连接到服务器
    NSError *error = nil;
    [clientSocket connectToHost:@"192.168.0.17" onPort:3001 error:&error];
    
    //总体思路，消息加到数组里，然后显示到tableView
    
    
}

//发送消息按钮
- (IBAction)sendMessage:(UIButton *)sender
{
   NSString *str = self.textField.text;
    [self.clientSocket writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    [self.messages addObject:str];
    [self.tableView reloadData];
    self.textField.text = nil;
}

#pragma mark UITableView datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    cell.textLabel.text = self.messages[indexPath.row];
    return cell;
}

#pragma MARK  GCDAsyncSocketDelegate

//连接到服务器以后开始监听数据
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(nonnull NSString *)host port:(uint16_t)port
{
    [sock readDataWithTimeout:-1 tag:0];
}

//读取到数据
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",message);
    [self.messages addObject:message];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
    
    
    //读取一次以后再监听
    [sock readDataWithTimeout:-1 tag:0];
}


-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"%@",err);
}
@end
