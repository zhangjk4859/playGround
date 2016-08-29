//
//  JSONController.m
//  OC-TestProhect
//
//  Created by 张俊凯 on 16/8/29.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "JSONController.h"

@interface JSONController ()

@end

@implementation JSONController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1  ?username=520it&pwd=520it
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/video"];
    //2
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    
    //3
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        /**
         *   NSJSONReadingMutableContainers = 容器可变，mutableDic
             NSJSONReadingMutableLeaves =     内容可变
             NSJSONReadingAllowFragments    允许非字典和非数组
             kNilOptions  对数据无要求，效率最好
         */
        
        //开始转换JSON为OC
        NSError *error = nil;
      NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        NSLog(@"%@",dic);
        
    }];
    

    
}

-(void)objectToJSON
{
    NSDictionary *dic = @{@"name":@"kevin"};
    NSError *error = nil;
    //把字典和数组对象转换成JSON数据
    NSData *JSONdata = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *dicStr = [[NSString alloc] initWithData:JSONdata encoding:NSUTF8StringEncoding];
    NSLog(@"%@",dicStr);
    
}

@end
