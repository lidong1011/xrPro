//
//  ForgetPasswordViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/9.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "NSString+DES.h"
@interface ForgetPasswordViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) NSString *yanZhengMa;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int timeInt;
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"忘记密码";
    self.phoneTF.delegate = self;
    self.knewPsdTF.secureTextEntry = YES;
    self.comfirmTF.secureTextEntry = YES;
}



#pragma mark 倒计时
- (void)returnYanCode
{
    _timeInt--;
    if (_timeInt==0) {
        //        self.registerView.verficationBtn.selected = NO;
        self.getCodeBtn.enabled = YES;
        [_timer invalidate];
    }
    NSString *string = [NSString stringWithFormat:@"重新发送(%d)",_timeInt];
    [self.getCodeBtn setTitle:string forState:UIControlStateDisabled];
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

- (IBAction)getPassword:(UIButton *)sender
{
    if([self isNullOfInput])
    {
        return;
    }
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:_phoneTF.text forKey:@"mobile"];
    [parameter setObject:@"ios" forKey:@"reqType"];
    //密码加密 MD5
    NSString *md5String = [NSString md5_base64:_knewPsdTF.text];
    [parameter setObject:md5String forKey:@"psw"];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    [manager POST:klosePwdUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        [SVProgressHUD showSuccessWithStatus:@"找回成功"];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:kIsRemembPsd];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}


- (BOOL)isNullOfInput
{
    if (_phoneTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"手机号码有误！"];
        return YES;
    }
    if (_knewPsdTF.text.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"密码太短！"];
        return YES;
    }
    if ([_knewPsdTF.text isEqualToString:_comfirmTF.text]==NO) {
        [SVProgressHUD showErrorWithStatus:@"两次密码输入不一致！"];
        return YES;
    }
    if (_codeTF.text.length != 6) {
        [SVProgressHUD showErrorWithStatus:@"手机验证码有误！"];
        return YES;
    }
    if (([_codeTF.text isEqualToString:_yanZhengMa] != YES)) {
        [SVProgressHUD showErrorWithStatus:@"手机验证码有误！"];
        return YES;
    }
    return NO;
}

- (IBAction)getCode:(UIButton *)sender
{
    if (_phoneTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"手机号码不对"];
        return;
    }
    
    sender.enabled = NO;
    _timeInt = 60;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(returnYanCode) userInfo:nil repeats:YES];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:_phoneTF.text forKey:@"mobile"];
    
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

#pragma mark - textfeild delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField==_phoneTF)
    {
        if (range.location>=11) {
            return NO;
        }
    }
    return YES;
}
@end
