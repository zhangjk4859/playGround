//
//  JKTabBarController.m
//  环信
//
//  Created by 张俊凯 on 16/9/12.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "JKTabBarController.h"

@interface JKTabBarController ()

@end

@implementation JKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

  //此法作用从UIStoryboard群抓取对应的控制器
  UIViewController *vc = [[UIStoryboard storyboardWithName:@"main" bundle:nil] instantiateViewControllerWithIdentifier:@"identifier"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
