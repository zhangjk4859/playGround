//
//  AppDelegate.m
//  环信
//
//  Created by 张俊凯 on 16/9/9.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    //添加tabbar控制器
    [self.window makeKeyAndVisible];
    return YES;
}



@end
