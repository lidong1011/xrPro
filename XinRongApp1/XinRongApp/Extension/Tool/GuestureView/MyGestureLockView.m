//
//  MyGestureLockView.m
//  手势解锁——0512
//
//  Created by 李冬强 on 15/5/12.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "MyGestureLockView.h"

@implementation MyGestureLockView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self _initGestureView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        [self _initGestureView];
    }
    return self;
}


- (void)_initGestureView
{
    CGFloat with = self.bounds.size.width-40;
    _gestureView = [[KKGestureLockView alloc]initWithFrame:CGRectMake(20, self.bounds.size.height-with-100, with, with)];
    //    kkGestureView.backgroundColor = [UIColor redColor];
    //    self.view.backgroundColor = [UIColor whiteColor];
    _gestureView.normalGestureNodeImage = [UIImage imageNamed:@"gesture_node_normal.png"];
    _gestureView.selectedGestureNodeImage = [UIImage imageNamed:@"gesture_node_selected.png"];
    _gestureView.lineColor = [[UIColor orangeColor] colorWithAlphaComponent:0.3];
    _gestureView.lineWidth = 12;
    _gestureView.delegate = self;
    [self addSubview:_gestureView];
    
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-100-with)];
    _titleLab.text = @"手势解锁";
    _titleLab.textAlignment = NSTextAlignmentCenter;
//    _titleLab.backgroundColor = [UIColor redColor];
    [self addSubview:_titleLab];
    
    _forgetBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _forgetBut.frame = CGRectMake(0, self.bounds.size.height-100, self.bounds.size.width, 100);
    [_forgetBut setTitle:@"" forState:UIControlStateNormal];
    [_forgetBut setTitleColor:kZhuTiColor forState:UIControlStateNormal];
    [self addSubview:_forgetBut];
    
//    kkGestureView.center = self.window.center;
    //    [self.view addSubview:kkGestureView];
}

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didBeginWithPasscode:(NSString *)passcode{
    NSLog(@"%@",passcode);
//    _titleLab.text = passcode;
}

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode{
    NSLog(@"%@",passcode);
    if (_delegate!=nil&&[_delegate respondsToSelector:@selector(myGestureLockView:didEndWithPasscode:)])
    {
        [self.delegate myGestureLockView:self didEndWithPasscode:passcode];
    }
//    _titleLab.text = passcode;
}
@end
