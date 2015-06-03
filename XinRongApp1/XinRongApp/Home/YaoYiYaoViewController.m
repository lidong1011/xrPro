//
//  ExepericeBiaoViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/3/27.
//  Copyright (c) 2015年 ldq. All rights reserved.
//
#import <AudioToolbox/AudioToolbox.h>
#import "YaoYiYaoViewController.h"
#import "ExpericeBiaoDetailViewController.h"
#import "YaoYaoPopView.h"
#import "KLCoverView.h"
@interface YaoYiYaoViewController ()
@property (nonatomic, strong) UIImageView *imagView;
@property (nonatomic, strong) YaoYaoPopView *popView;
@property (nonatomic, strong) KLCoverView *coverView;
@property (nonatomic, assign) int money;
@end

@implementation YaoYiYaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"摇一摇获取体验金";
    //随机产生钱
     _money = arc4random()%10*1000+1000;

    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
    
    _imagView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kNavigtBarH, kWidth, kHeight)];
    _imagView.image = [UIImage imageNamed:@"yaoyyao1.png"];
    [self.view addSubview:_imagView];
//    [self test];
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [self test];
//}


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
        
//        [self test];
        
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
    _imagView.animationRepeatCount = 5; // 0 = loops forever 动画重复次数
    [_imagView startAnimating];
//    [self addSubview:myAnimatedView];
//    [UIView animateKeyframesWithDuration:1.5 delay:0 options:nil animations:^{
//        _imagView.image = [UIImage imageNamed:@"yaoyyao2.png"];
//    } completion:^(BOOL finished) {
        //
//    }];
    [self performSelector:@selector(getMoneyRequest) withObject:self afterDelay:2];
//    [self showPopView];
    NSLog(@"完成摇动后处理事件");
    
}

#pragma mark - 获取赠送体验金
- (void)getMoneyRequest
{
    /*用户IDcustomerId
     体验金额 transAmt
     类型 ordRes*/
//    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    [parameter setObject:custId forKey:kCustomerId];
    [parameter setObject:@(_money) forKey:@"transAmt"];
    [parameter setObject:@(3) forKey:@"ordRes"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    __weak typeof(self) weakSelf = self;
    [manager POST:kexperienceUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf success:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        [SVProgressHUD showInfoWithStatus:@"体验金获取失败"];
    }];
}

#pragma mark - 注册请求返回数据
- (void)success:(id)response
{
    //    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    //    [self.tableView.footer endRefreshing];
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [self showPopView];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

- (void)showPopView
{
    _coverView = [KLCoverView coverWithTarget:self action:@selector(hideMenuView)];
    _coverView.frame = CGRectMake(0, 0, kWidth, kHeight);
    [self.view addSubview:_coverView];
    
    _popView = [YaoYaoPopView createView];
    _popView.center = self.view.center;
    _popView.moneyLab.text = [NSString stringWithFormat:@"%d元",_money];
    [self.view addSubview:_popView];
    [self performSelector:@selector(goToTender) withObject:self afterDelay:2];
}

- (void)goToTender
{
    //去投体验标
    ExpericeBiaoDetailViewController *detailVC = [[ExpericeBiaoDetailViewController alloc]init];
    detailVC.biddingId = _biddingId;
    detailVC.ordType = _ordType;
    [self.navigationController pushViewController:detailVC animated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
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
