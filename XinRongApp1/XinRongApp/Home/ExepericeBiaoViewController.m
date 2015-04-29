//
//  ExepericeBiaoViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/3/27.
//  Copyright (c) 2015年 ldq. All rights reserved.
//
#import <AudioToolbox/AudioToolbox.h>
#import "ExepericeBiaoViewController.h"
#import "YaoYaoPopView.h"
#import "KLCoverView.h"
@interface ExepericeBiaoViewController ()
@property (nonatomic, strong) UIImageView *imagView;
@property (nonatomic, strong) YaoYaoPopView *popView;
@property (nonatomic, strong) KLCoverView *coverView;
@property (nonatomic, assign) NSInteger *money;
@end

@implementation ExepericeBiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"体验标";
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    
    [self becomeFirstResponder];
    _imagView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kNavigtBarH, kWidth, kHeight)];
    _imagView.image = [UIImage imageNamed:@"yaoyyao1.png"];
    [self.view addSubview:_imagView];
//    [self test];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self test];
}


- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    [self test];
    //检测到摇动
    
}


- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    //摇动结束
    
    if (event.subtype == UIEventSubtypeMotionShake) {
        
        //something happens
        
        [self test];
        
    }
    
}


- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    //摇动取消
    
}


- (BOOL)canBecomeFirstResponder {
    
    return YES;
    
}


-(void)test

{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    NSArray *myImages = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"yaoyyao1.png"],
                         [UIImage imageNamed:@"yaoyyao2.png"], nil];
        _imagView.animationImages = myImages; //animationImages属性返回一个存放动画图片的数组
    _imagView.animationDuration = 0.35; //浏览整个图片一次所用的时间
    _imagView.animationRepeatCount = 30; // 0 = loops forever 动画重复次数
    [_imagView startAnimating];
//    [self addSubview:myAnimatedView];
//    [UIView animateKeyframesWithDuration:1.5 delay:0 options:nil animations:^{
//        _imagView.image = [UIImage imageNamed:@"yaoyyao2.png"];
//    } completion:^(BOOL finished) {
        //
//    }];
    [self showPopView];
    NSLog(@"完成摇动后处理事件");
    
}

- (void)showPopView
{
    _coverView = [KLCoverView coverWithTarget:self action:@selector(hideMenuView)];
    _coverView.frame = CGRectMake(0, 0, kWidth, kHeight-kNavigtBarH);
    [self.view addSubview:_coverView];
    
    _popView = [YaoYaoPopView createView];
    _popView.center = self.view.center;
    _popView.moneyLab.text = @"199993元";
    [self.view addSubview:_popView];
}

- (void)hideMenuView
{
    [_coverView removeFromSuperview];
    [_popView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
