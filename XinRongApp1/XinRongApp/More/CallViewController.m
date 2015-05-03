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
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"mailto://service@xr58.com"]];
            break;
        default:
            break;
    }
    
}

- (void)showWeiXin
{
    _weiXinImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    _weiXinImg.center = self.view.center;
    _weiXinImg.userInteractionEnabled = YES;
    _weiXinImg.image = [UIImage imageWithName:@"weixi_call.png"];
    [self.view addSubview:_weiXinImg];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImg)];
    [_weiXinImg addGestureRecognizer:tap];
}

- (void)hideImg
{
    [_weiXinImg removeFromSuperview];
}

@end
