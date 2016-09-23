//
//  JKBag.h
//  代码广场
//
//  Created by 张俊凯 on 16/9/23.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fruit.h"

//__covariant contravariant
@interface JKBag<__contravariant Type>: NSObject
-(void)add:(Type)object;
-(Type)get:(int)index;
@end
