//
//  ViewController.m
//  代码广场
//
//  Created by 张俊凯 on 16/9/23.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "ViewController.h"
#import "JKBag.h"

NS_ASSUME_NONNULL_BEGIN

//范围之间都是属性不可为空

@interface ViewController ()
///*
///**不可为空*/
//@property(nonatomic,strong,nonnull)NSArray *names;
//
///**不可为空*/
//@property(nonatomic,strong)NSArray * __nonnull persons;
//
//
//@property(nonatomic,strong)NSArray * __nullable children;
//
////set方法可为空
//@property(null_resettable, nonatomic,strong)NSArray * tests;



/**
 *  不能修饰基本数据类型
 */
//@property(nonatomic,assign,nonnull)int count;


/*泛型**/
@property(nonatomic,strong)NSMutableArray <NSString *> *names;

/**限制类型*/
@property(nonatomic,strong)NSMutableDictionary <NSString *,NSNumber *>*books;
@end

NS_ASSUME_NONNULL_END

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //自定义泛型，相加什么类型自己定义
    
    JKBag * bag = [[JKBag alloc] init];
    JKBag <NSString *>* bag1 = [[JKBag alloc] init];
    JKBag <NSMutableString *>* bag2 = [[JKBag alloc] init];
    
    //可以互相转换，ID指向字符串
    bag = bag1;
    bag = bag2;
    
    //字符串类型指针指向 ID
    bag2 = bag;
    bag1 = bag;
    
    
    //子类互相转换
    bag1 = bag2;//父类类型指向子类，会报警告，加了 covariant，消除警告，强制转换
    bag2 = bag1;//contravariant 消除此处警告，可以让子类指针指向父类
    
    
     
    self.books[@"key"] = @10;
    
//    self.books[@"key"].stringValue = @"11-";
    
    //    self.names = @[];
    //    self.names = nil;
    //
    //    [self setNames:nil];
    //
    //    test(nil);
    //
    //    [self getSomething:nil];
    
    [self.names addObject:@"1"];
    
    self.names.lastObject.length;
    
    
}


-(void)setTests:(NSArray *)tests
{
//    if (tests == nil) return;
//    
//    _tests = tests;
}

//参数不可为空
void test(NSArray * __nonnull names)
{
    UILabel;
}


//对象方法参数不能为空
-(NSString *__nonnull)getSomething:(NSArray *__nonnull)things
{
    return @"";
}



@end
