//
//  NSObject+Caculator.m
//  masonry
//
//  Created by 张俊凯 on 16/9/13.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "NSObject+Caculator.h"


@implementation NSObject (Caculator)
+(int)makeCaculator:(void(^)(Caculator *cau))block
{
    Caculator *cau = [[Caculator alloc] init];
    block(cau);
    return cau.result;
}
@end
