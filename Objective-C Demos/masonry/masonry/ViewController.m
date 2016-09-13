//
//  ViewController.m
//  masonry
//
//  Created by 张俊凯 on 16/9/13.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "Caculator.h"
#import "NSObject+Caculator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   int result = [NSObject makeCaculator:^(Caculator *cau) {
        cau.add(10).add(10);
    }];

    NSLog(@"%d",result);

}


-(void)caculatorTwo
{
    Caculator *cau = [[Caculator alloc] init];
    int result = cau.add(12).add(12).add(12).result;
    
    NSLog(@"%d",result);
}

-(void)caculatorOne
{
    Caculator *cau = [[Caculator alloc] init];
    int result = [[[[cau add:10] add:20] add:30] result];
    NSLog(@"%d",result);
}

-(void)test
{
    UIView *yellowView = [UIView new];
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    
    void(^block)(MASConstraintMaker *maker) = ^(MASConstraintMaker *maker){
        
        
        id(^block)(id attribute) = ^id(id attribute){
            return nil;
        };
        
        block(@20);
        
        maker.left.top.equalTo(@20);
        maker.bottom.right.equalTo(@(-20));
        
    };
    
    [yellowView mas_makeConstraints:block];
    //    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.top.equalTo(@20);
    //        make.bottom.right.equalTo(@(-20));
    //        
    //    }];
}
@end
