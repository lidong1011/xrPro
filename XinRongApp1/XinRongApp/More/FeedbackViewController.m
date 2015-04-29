//
//  FeedbackViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/3/18.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "FeedbackViewController.h"
#import "LoginViewController.h"
@interface FeedbackViewController ()<UITextViewDelegate>

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.delegate = self;
    self.navigationItem.title = @"用户反馈";
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:kCustomerId]==nil)
    {
        [SVProgressHUD showInfoWithStatus:@"还未登录，去登录或注册" maskType:SVProgressHUDMaskTypeGradient];
        [self performSelector:@selector(goLogin) withObject:nil afterDelay:1];
    }
}

#pragma mark - 获取我的余额请求
- (void)sendMyFeedback
{
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:custId forKey:@"customerId"];
    [parameter setObject:_textView.text forKey:@"content"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    __weak typeof(self) weakSelf = self;
    [manager POST:kaddOpinionUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf sendMyFeedbackSuccess:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        
    }];
}

#pragma mark - 请求返回数据
- (void)sendMyFeedbackSuccess:(id)response
{
//    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [SVProgressHUD showSuccessWithStatus:@"反馈成功"];
        
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

- (void)goLogin
{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (_textView.text.length<200)
    {
        self.syLab.text = [NSString stringWithFormat:@"%ld",200-_textView.text.length];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"字数不能超过200字"];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length>200) {
        return NO;
    }
    return YES;
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

- (IBAction)callBtn:(UIButton *)sender
{
    //联系客服
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://4008925858"]];
}

- (IBAction)sender:(UIButton *)sender
{
    [self sendMyFeedback];
}
@end
