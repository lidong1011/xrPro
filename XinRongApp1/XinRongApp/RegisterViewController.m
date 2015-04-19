//
//  RegisterViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/3/10.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "RegisterViewController.h"
#import "LookXieYiViewController.h"

#import "User.h"
#import "AccountManager.h"
#import "DESEncryptFile.h"
#import "NSString+DES.h"
@interface RegisterViewController ()<UITextFieldDelegate>
@property (nonatomic, assign) BOOL isAgress;
@property (weak, nonatomic) IBOutlet UIButton *yanZhengMBtn;
@property (nonatomic, strong) NSString *yanZhengMa;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int timeInt;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"注册";
    
    [self initData];
    
    [self initSubview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    //默认为选中同意
    _isAgress = YES;
    
    //测试用
//    self.phoneNum.text = @"15575394951";
//    self.passwordTF.text = @"0618ldq";
//    self.confirmPsTF.text = @"0618ldq";
}

- (void)initSubview
{
    _phoneNum.delegate = self;
    _passwordTF.secureTextEntry = YES;
    _confirmPsTF.secureTextEntry = YES;
}

//获取验证码
- (IBAction)getYanZhengCode:(UIButton *)sender
{
    
    if (_phoneNum.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"手机号码不对"];
        return;
    }
    
    sender.enabled = NO;
    _timeInt = 60;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(returnYanCode) userInfo:nil repeats:YES];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:_phoneNum.text forKey:@"mobile"];

    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    [manager POST:ksendSMSUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"code"] isEqualToString:@"000"]) {
            [SVProgressHUD showSuccessWithStatus:@"发送请求成功"];
            _yanZhengMa = dic[@"msg"];
        }
        MyLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
    }];
}

#pragma mark 倒计时
- (void)returnYanCode
{
    _timeInt--;
    if (_timeInt==0) {
        //        self.registerView.verficationBtn.selected = NO;
        self.yanZhengMBtn.enabled = YES;
        [_timer invalidate];
    }
    NSString *string = [NSString stringWithFormat:@"重新发送(%d)",_timeInt];
    [self.yanZhengMBtn setTitle:string forState:UIControlStateDisabled];
}

//查看协议
- (IBAction)lookXieYi:(UIButton *)sender {
    LookXieYiViewController *lookXieYiVC = [[LookXieYiViewController alloc]init];
    [self.navigationController pushViewController:lookXieYiVC animated:YES];
}

- (IBAction)isAgressXieYi:(UIButton *)sender {
    sender.selected = !sender.selected;
    _isAgress = sender.selected;
}

//确认注册
- (IBAction)registerAction:(UIButton *)sender
{
    //是否同意新融网协议了
    if(_isAgress == NO)
    {
        [SVProgressHUD showInfoWithStatus:@"请同意新融网协议！"];
        return;
    }
    if ([self isNullOfInput])
    {
        return;
    }
    else
    {
        [self registerRequest];
    }
}

#pragma mark - 注册请求
- (void)registerRequest
{
//    [SVProgressHUD showWithStatus:@"注册中..."];

    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:_phoneNum.text forKey:@"mobile"];
    //密码加密 MD5
    NSString *md5String = [NSString md5_base64:_passwordTF.text];
    [parameter setObject:md5String forKey:@"pwd"];
    if(_tuiGuangNumTF.text.length >0)
    {
        [parameter setObject:_tuiGuangNumTF.text forKey:@"referee"];
    }
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    [manager POST:kRegisterUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:responseObject];
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
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [SVProgressHUD showSuccessWithStatus:@"注册成功"];
        User *user = [[User alloc]init];
        user.username = _phoneNum.text;
        user.password = _passwordTF.text;
        [AccountManager shareManager].user = user;
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}


- (BOOL)isNullOfInput
{
    if (_phoneNum.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"手机号码有误！"];
        return YES;
    }
    if (_passwordTF.text.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"密码太短！"];
        return YES;
    }
    if ([_phoneNum.text isEqualToString:_confirmPsTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次密码输入不一致！"];
        return YES;
    }
    if (_msgCodeTF.text.length != 6) {
        [SVProgressHUD showErrorWithStatus:@"手机验证码有误！"];
        return YES;
    }
    if (([_msgCodeTF.text isEqualToString:_yanZhengMa] != YES)) {
        [SVProgressHUD showErrorWithStatus:@"手机验证码有误！"];
        return YES;
    }
    return NO;
}

#pragma mark - textfeild delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location>=11) {
        return NO;
    }
    return YES;
}

@end
