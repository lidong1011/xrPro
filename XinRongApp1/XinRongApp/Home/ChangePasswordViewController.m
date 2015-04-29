//
//  ChangePasswordViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/10.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "NSString+DES.h"
#import "User.h"
#import "AccountManager.h"
@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
    
    self.oldPasswordTF.secureTextEntry = YES;
    self.kNewPasswordTF.secureTextEntry = YES;
    self.comfirmPwdTF.secureTextEntry = YES;
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

- (IBAction)changAct:(UIButton *)sender
{
    if([self isNullOfInput])
    {
        return;
    }
    [self changePsdRequest];
}

- (BOOL)isNullOfInput
{
    if (_oldPasswordTF.text.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"旧密码输入有误！"];
        return YES;
    }
    if (_kNewPasswordTF.text.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"新密码太短！"];
        return YES;
    }
    if ([_kNewPasswordTF.text isEqualToString:_comfirmPwdTF.text] == NO) {
        [SVProgressHUD showErrorWithStatus:@"两次密码不一致"];
        return YES;
    }
    return NO;
}

#pragma mark - 修改密码
- (void)changePsdRequest
{
    NSString *custId = [[NSUserDefaults standardUserDefaults] stringForKey:kCustomerId];;
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:custId forKey:kCustomerId];
    //密码加密 MD5
    NSString *md5OldPswString = [NSString md5_base64:_oldPasswordTF.text];
    [parameter setObject:md5OldPswString forKey:@"oldPsw"];

    NSString *md5String = [NSString md5_base64:_kNewPasswordTF.text];
    [parameter setObject:md5String forKey:@"psw"];
    [parameter setObject:@"ios" forKey:@"reqType"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    [manager POST:kupdatePwdUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        
    }];
}

#pragma mark - 修改密码请求返回数据
- (void)success:(id)response
{
    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:dic[@"msg"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //        [alert show];
    
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        //自动登录
        [self loginRequest];
    }
    else
    {
        [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
    }
}

#pragma mark - 登陆
- (void)loginRequest
{
    //    [SVProgressHUD showWithStatus:@"登录中..."];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:[AccountManager shareManager].user.username forKey:@"mobile"];
    //密码加密 MD5
    NSString *md5String = [NSString md5_base64:_kNewPasswordTF.text];
    [parameter setObject:md5String forKey:@"pwd"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    [manager POST:kLoginUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self loginSuccess:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        
    }];
}

#pragma mark - 自动登录
- (void)loginSuccess:(id)response
{
    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:dic[@"msg"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //        [alert show];
    
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        User *user = [[User alloc]init];
        user.username = [AccountManager shareManager].user.username;
        user.password = _kNewPasswordTF.text;
        [AccountManager shareManager].user = user;
        [[NSUserDefaults standardUserDefaults]setObject:dic[@"customerId"] forKey:kCustomerId];
        [[NSUserDefaults standardUserDefaults]setObject:dic forKey:kUserMsg];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
