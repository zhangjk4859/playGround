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
/**<#注释#>*/
@property(nonatomic,strong)NSOperationQueue *queue;
@end

@implementation TableViewController
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            
            //开启子线程
            [self.queue addOperationWithBlock:^{
               
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:app.icon]];
                UIImage *image = [UIImage imageWithData:data];
                //回到主线程刷新图片
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                    cell.imageView.image = image;
                }];
                
                
                
                //写到字典里
                self.imagesCaches[app.icon] = image;
                
                //将图片数据写入沙盒中caches文件夹中
                
                //根据文件路径存储到沙盒中
                [data writeToFile:file atomically:YES];
                NSLog(@"%@",file);
                

            }];

            
        }
        
    }
    
    
    return cell;
}


@end
