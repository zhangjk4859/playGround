//
//  JKLabel.m
//  OC-TestProhect
//
//  Created by 张俊凯 on 16/9/6.
//  Copyright © 2016年 张俊凯. All rights reserved.
//

#import "JKLabel.h"

@implementation JKLabel

-(void)awakeFromNib
{
    [self setup];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

-(void)setup
{
    self.userInteractionEnabled  = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)]];
}

-(void)labelClick
{
    //变成第一响应者
    [self becomeFirstResponder];
    
    //显示菜单控制器
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:self.frame inView:self.superview];
    
    [menu setMenuVisible:YES animated:YES];
   
    NSLog(@"%s",__func__);
}

//允许label成为第一响应者
-(BOOL)canBecomeFirstResponder
{
    return YES;
}

//可以执行哪些操作
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copy:) || action == @selector(paste:)|| action == @selector(cut:)) {
        return YES;
    }
    return NO;
}

-(void)cut:(UIMenuController *)menu
{
    //复制到粘贴板
    [self copy:menu];
    //清空文字
    self.text = nil;
}

-(void)copy:(UIMenuController *)menu
{
    //复制到粘贴板
    [UIPasteboard generalPasteboard].string = self.text;
    
}
-(void)paste:(UIMenuController *)menu
{
    self.text = [UIPasteboard generalPasteboard].string;
}
@end
