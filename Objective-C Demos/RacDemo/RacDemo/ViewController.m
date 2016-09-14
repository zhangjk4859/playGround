//
//  ViewController.m
//  RacDemo
//
//  Created by 张俊凯 on 16/9/14.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveCocoa.h"
#import "YellowView.h"


@interface ViewController ()
//拥有黄色的view
@property (weak, nonatomic) IBOutlet YellowView *yellow;
/**
 *  自身一个age属性
 */
@property(nonatomic,assign)NSInteger age;

@property (weak, nonatomic) IBOutlet UIButton *button;
//把文本框拿过来
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   

    

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.age ++;
}


//第一，RAC监听子视图的按钮点击事件
-(void)yellowView
{
    //黄色view本身调用某个方法的时候，监听产生的信号
    [[_yellow rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(id x) {
        NSLog(@"viewDidLoad监听点击了按钮");
    }];
}

//第二，用rac实现简便KVO,只要age发生改变，就能监听到
-(void)KVODemo
{
    [[self rac_valuesForKeyPath:@"age" observer:nil] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

//第三，把按钮点击事件转换为信号
-(void)buttonSignal
{
    [[_button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"点击了蓝色的按钮");
    }];
}

//第四，把原生框架中通知的实现方法集合在一起
-(void)notificationSignal
{
    RACSignal *notiSignal = [[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil];
    [notiSignal subscribeNext:^(id x) {
        NSLog(@"监听到了键盘弹出");
    }];
}

//第五，文本框拿过来用RAC监听
-(void)textSignal
{
    RACSignal *textSignal = [_textField rac_textSignal];
    [textSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

//第六个需求，有两个完成时间不确定的请求，两个都完成以后再进行下一步操作
-(void)conbineSignals
{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //1.处理请求
        NSLog(@"处理请求A");
        
        //2.完成后发送数据
        [subscriber sendNext:@"请求A结果"];
        
        //3.返回空数据
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //1.处理请求
        NSLog(@"处理请求B");
        
        //2.完成后发送数据
        [subscriber sendNext:@"请求B结果"];
        
        //3.返回空数据
        return nil;
    }];
    
    //两个信号都发出，就执行特定的方法
    [self rac_liftSelector:@selector(dealResultsWithParamA:paramB:) withSignalsFromArray:@[signalA,signalB]];
}

-(void)dealResultsWithParamA:(NSString *)one paramB:(NSString *)two
{
    NSLog(@"%@------%@",one,two);
}

@end
