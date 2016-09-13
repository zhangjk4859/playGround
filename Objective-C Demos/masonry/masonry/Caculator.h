//
//  Caculator.h
//  masonry
//
//  Created by 张俊凯 on 16/9/13.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Caculator : NSObject

/**
 *  <#注释#>
 */
@property(nonatomic,assign)int result;;

-(instancetype)add:(int)num;

-(Caculator *(^)(int num))add;

@end
