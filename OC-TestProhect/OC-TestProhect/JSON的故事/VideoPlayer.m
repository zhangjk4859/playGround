//
//  VideoPlayer.m
//  OC-TestProhect
//
//  Created by 张俊凯 on 16/8/29.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "VideoPlayer.h"
#import <UIImageView+WebCache.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoPlayer ()
/**视频组*/
@property(nonatomic,strong)NSArray *videos;
@end

@implementation VideoPlayer

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //1  ?username=520it&pwd=520it
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/video"];
    //2
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    
    //3
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
       
        
        //开始转换JSON为OC
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        self.videos = dic[@"videos"];
        [self.tableView reloadData];
        NSLog(@"%@",dic);
        
    }];

    
}



#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.videos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"video";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
   NSDictionary *info = self.videos[indexPath.row];
    cell.textLabel.text = info[@"name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"时长：%@秒",info[@"length"]];
    NSString *videoStr = info[@"image"];
    NSString *url = [@"http://120.25.226.186:32812" stringByAppendingPathComponent:videoStr];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSDictionary *info = self.videos[indexPath.row];
    
    NSString *videoStr = info[@"url"];
    NSString *url = [@"http://120.25.226.186:32812" stringByAppendingPathComponent:videoStr];
    
    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc] init];
    playerVC.player = [AVPlayer playerWithURL:[NSURL URLWithString:url]];
    
    [self presentViewController:playerVC animated:YES completion:nil];
}
@end
