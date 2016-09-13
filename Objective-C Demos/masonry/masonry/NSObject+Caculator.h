//
//  NSObject+Caculator.h
//  masonry
//
//  Created by 张俊凯 on 16/9/13.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Caculator.h"

@interface NSObject (Caculator)

+(int)makeCaculator:(void(^)(Caculator *cau))block;

@end
