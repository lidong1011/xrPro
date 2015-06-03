//
//  MyGestureLockView.h
//  手势解锁——0512
//
//  Created by 李冬强 on 15/5/12.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKGestureLockView.h"
@class MyGestureLockView;
@protocol  MyGestureLockViewDelegate<NSObject>
@optional
- (void)myGestureLockView:(MyGestureLockView *)myGestureLockView didEndWithPasscode:(NSString *)passcode;
@end
@interface MyGestureLockView : UIView<KKGestureLockViewDelegate>
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *forgetBut;
@property (nonatomic, strong) KKGestureLockView *gestureView;
@property (nonatomic, weak) id<MyGestureLockViewDelegate> delegate;
@end
