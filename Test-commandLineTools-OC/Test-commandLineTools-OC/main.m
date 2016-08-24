//
//  main.m
//  Test-commandLineTools-OC
//
//  Created by 张俊凯 on 16/8/24.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import <Foundation/Foundation.h>

void testSwap(char *v1,char *v2)
{
    char tmp;
    
    tmp = *v1;
    
    *v1 = *v2;
    
    *v2 = tmp;
    
}



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        

        
        
        
    
    }
    return 0;
}

void pointerOne()
{
    int a = 10;
    
    int *p;//"*"代表这是一个指针变量，但不是变量名的一部分
    //用来存放变量地址的变量称为“指针变量”
    p = &a;
    NSLog(@"p存的地址%p \np自己的地址%p \n变量a的地址%p",p,&p,&a);
}


void test()
{
    //        int a = 10;
    //
    //        int *p = &a;
    //
    //        NSLog(@"%p，%p",p,&a);
    
    
//    int a = 10;
//    char b = 1;
//    
//    int *p = &b;
    
    //printf("%d",*p);
   // NSLog(@"%d",*p);

    
    char a = 10, b = 9;
    printf("更换前：a=%d, b=%d\n", a, b);
    
    testSwap(&a, &b);
    
    printf("更换后：a=%d, b=%d", a, b);
}

