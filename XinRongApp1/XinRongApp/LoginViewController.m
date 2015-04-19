//
//  LoginViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/3/10.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "AccountManager.h"
#import "NSString+DES.h"
#import "KeychainItemWrapper.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *isRemembBtn;
@property (nonatomic, assign) BOOL isRememb;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登陆";
    
    [self initSubview];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //用户名
    self.userName.text = [AccountManager shareManager].user.username;
    self.password.secureTextEntry = YES;
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kIsRemembPsd]) {
        self.isRemembBtn.selected = YES;
        _isRememb = YES;
        self.password.text = [AccountManager shareManager].user.password;
    }
}

- (void)initSubview
{
    //注册
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 100, 51, 31);
//    [rightBtn setBackgroundImage:[UIImage imageNamed:@"person.png"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"注册" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(registerBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    
}

- (void)registerBtn
{
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

//登陆
- (IBAction)loginAction:(UIButton *)sender
{
    if([self isNullOfInput])
    {
        return;
    }
    [self loginRequest];
}

- (BOOL)isNullOfInput
{
    if (_userName.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"手机号码有误！"];
        return YES;
    }
    if (_password.text.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"密码有误！"];
        return YES;
    }
    return NO;
}

#pragma mark - 登陆
- (void)loginRequest
{
//    [SVProgressHUD showWithStatus:@"登录中..."];

    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:_userName.text forKey:@"mobile"];
    //密码加密 MD5
    NSString *md5String = [NSString md5_base64:_password.text];
    [parameter setObject:md5String forKey:@"pwd"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    __weak typeof(self) weakSelf = self;
    [manager POST:kLoginUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf success:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        
    }];
}

#pragma mark - 注册请求返回数据
- (void)success:(id)response
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
        user.username = _userName.text;
        user.password = _password.text;
        [AccountManager shareManager].user = user;
        [[NSUserDefaults standardUserDefaults]setBool:_isRememb forKey:kIsRemembPsd];
        [[NSUserDefaults standardUserDefaults]setObject:dic[@"customerId"] forKey:kCustomerId];
        [[NSUserDefaults standardUserDefaults]setObject:dic forKey:kUserMsg];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
    }
}


//忘记密码
- (IBAction)forgetPassword:(UIButton *)sender {
    ForgetPasswordViewController *forgetPasswordVC = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:forgetPasswordVC animated:YES];
}

- (IBAction)jiZhuPsd:(UIButton *)sender
{
    sender.selected = !sender.selected;
    _isRememb = sender.selected;
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
