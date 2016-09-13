//
//  Caculator.m
//  masonry
//
//  Created by 张俊凯 on 16/9/13.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "Caculator.h"


@implementation Caculator

-(instancetype)add:(int)num
{
    _result += num;
    return self;
}

-(Caculator *(^)(int num))add
{
    //返回一个block
    return ^(int num){
    
        _result += num;
       // NSLog(@"%d",num);
        return self;
    
    };
    
}

@end
