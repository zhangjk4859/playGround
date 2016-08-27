//
//  TableViewController.m
//  OC-TestProhect
//
//  Created by 张俊凯 on 16/8/26.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "TableViewController.h"
#import "App.h"

@interface TableViewController ()
/**数组*/
@property(nonatomic,strong)NSArray *apps;
/**图片字典*/
@property(nonatomic,strong)NSMutableDictionary *imagesCaches;
/**规定的轨道，可以多开轨道*/
@property(nonatomic,strong)NSOperationQueue *queue;
/**小工登记手册*/
@property(nonatomic,strong)NSMutableDictionary *operations;
@end

@implementation TableViewController
- (NSMutableDictionary *)operations
{
    if (!_operations) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}
- (NSOperationQueue *)queue
{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc]init];
        _queue.maxConcurrentOperationCount = 3;
    }
    return _queue;
}
- (NSMutableDictionary *)imagesCaches
{
    if (!_imagesCaches) {
        _imagesCaches = [NSMutableDictionary dictionary];
    }
    return _imagesCaches;
}

-(NSArray *)apps
{
    if (_apps == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"apps" ofType:@"plist"];
        NSArray *tmpArray = [NSArray arrayWithContentsOfFile:filePath];
        NSMutableArray *marray = [NSMutableArray array];
        for (NSDictionary *dic in tmpArray) {
            App * app = [[App alloc]init];
            [app setValuesForKeysWithDictionary:dic];
            [marray addObject:app];
        }
        _apps = marray;
    }
    return _apps;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}



#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return self.apps.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"app";
    App * app = self.apps[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = app.download;
    //先设置一个占位图片
    cell.imageView.image = [UIImage imageNamed:@"placeholder"];
    
    //先去缓存拿图片
    UIImage *image = self.imagesCaches[app.icon];
    if (image) {//如果缓存有图片，直接加载
        cell.imageView.image = image;
    
    }else{//如果没有，再做下一步判断
       
        NSString *cachesPath =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        //atomically为YES，下载完全后才会存储，NO,即使下载失败，也会有残留
        //获取一个存储的文件名
        NSString *fileName = [app.icon lastPathComponent];
        //计算出文件的全路径
        NSString *file = [cachesPath stringByAppendingPathComponent:fileName];
        NSData *data = [NSData dataWithContentsOfFile:file];
        
        if (data) {//去沙盒加载
            cell.imageView.image = [UIImage imageWithData:data];
            //沙盒取出来以后还是放到内存供优先使用
            self.imagesCaches[app.icon] = cell.imageView.image;
            
        }else{//子线程去网络下载
            
        
            //先看有没有已经在下载
         NSOperation *op = self.operations[app.icon];
            if (op == nil) {//叫一个小工开始干活，下载图片
                op = [NSBlockOperation blockOperationWithBlock:^{
                                        //开启子线程
                    
                        
                        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:app.icon]];
                        UIImage *image = [UIImage imageWithData:data];
                        
                        //数据下载失败控制
                        if (image == nil) {
                            
                            //移除小工名单，让指挥后续重新发配人干活
                            [self.operations removeObjectForKey:app.icon];
                            
                            return;
                        }
                        
                        //回到主线程刷新图片
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            
                            //只刷新下载图片的特定行，解决
                            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                        }];
                    
                        
                        //写到字典里
                        self.imagesCaches[app.icon] = image;
                        
                        //将图片数据写入沙盒中caches文件夹中
                        
                        //根据文件路径存储到沙盒中
                        [data writeToFile:file atomically:YES];
                    
                        //下载完成移除操作（留着也没意义）
                    [self.operations removeObjectForKey:app.icon];
                        
                    
                }];
                
                //添加到队列（干活的计划）
                [self.queue addOperation:op];
                
                //添加到已经在干活的小工名单中
                self.operations[app.icon] = op;
                
            }
            
        
        }
        
    }
    
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    //取消所有下载操作
    [self.queue cancelAllOperations];
    //操作数组清空
    self.operations = nil;
    //清除图片缓存
    self.imagesCaches = nil;
    
    
}


@end
