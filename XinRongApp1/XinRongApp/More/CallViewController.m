//
//  CallViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/27.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "CallViewController.h"

@interface CallViewController ()
@property (nonatomic, strong) UIImageView *weiXinImg;
@property (nonatomic, strong) UIView *bgView;
@end

@implementation CallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"联系我们";
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

- (IBAction)call:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://4008925858"]];
            break;
        case 1://网站
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://www.xr58.com"]];
            break;
        case 2:
            [self showWeiXin];
            break;
        case 3://邮箱
//            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"mailto://service@xr58.com"]];
//            {
//                MFMailComposeViewController *mail = [[MFMailComposeViewController alloc]init];
//                mail.mailComposeDelegate = self;
//                [mail setMessageBody:@"jintiantianqibucuo" isHTML:YES];//邮箱内容
//                [mail setToRecipients:[NSArray arrayWithObjects:@"1161913145@qq.com",nil]];//发送对象
//                [mail setCcRecipients:[NSArray arrayWithObjects:@"1161913145@qq.com",nil]];//抄送人
//                [mail setBccRecipients:[NSArray arrayWithObjects:@"1161913145@qq.com",nil]];//密送对象
//                [mail setSubject:@"hello world"];//主题
//                [self presentViewController:mail animated:YES completion:^{}];
//            }
            break;
        default:
            break;
    }
    
}

- (void)showWeiXin
{
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _bgView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_bgView];
    _weiXinImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 172, 172)];
    _weiXinImg.center = self.view.center;
//    _weiXinImg.userInteractionEnabled = YES;
    _weiXinImg.image = [UIImage imageWithName:@"weixin_bg.jpg"];
    [self.view addSubview:_weiXinImg];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImg)];
    [_bgView addGestureRecognizer:tap];
}

- (void)hideImg
{
    [_weiXinImg removeFromSuperview];
    [_bgView removeFromSuperview];
}

@end
