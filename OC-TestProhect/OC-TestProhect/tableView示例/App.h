//
//  App.h
//  OC-TestProhect
//
//  Created by 张俊凯 on 16/8/26.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface App : NSObject
/** 名字 */
@property(nonatomic,copy)NSString *name;
/** 图标 */
@property(nonatomic,copy)NSString *icon;
/** 下载次数 */
@property(nonatomic,copy)NSString *download;
@end
