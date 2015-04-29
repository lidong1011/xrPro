//
//  TransterJXQViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/24.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "TransterJXQViewController.h"

@interface TransterJXQViewController ()<UITextFieldDelegate>

@end

@implementation TransterJXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _phoneNumTF.delegate = self;
    self.navigationItem.title = @"加息券转让";
}

#pragma mark - 卡券转让请求
- (void)transterRequest
{
    /*用户ID customerId
     加息券状态 status
     手机号 mobile
     转让金额 transAmt
     加息券ID kitId*/
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    [parameter setObject:custId forKey:kCustomerId];
    [parameter setObject:_dataModel.status forKey:@"status"];
    [parameter setObject:_dataModel.kitId forKey:@"kitId"];
    [parameter setObject:_moneyTF.text forKey:@"transAmt"];
    [parameter setObject:_phoneNumTF.text forKey:@"mobile"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    __weak typeof(self) weakSelf = self;
    [manager POST:kkitTransferUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf success:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
    }];
}

#pragma mark - 注册请求返回数据
- (void)success:(id)response
{
    //    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [SVProgressHUD showSuccessWithStatus:@"加息券进入转让中"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==_phoneNumTF)
    {
        if (textField.text.length!=11)
        {
            [SVProgressHUD showErrorWithStatus:@"手机号码有误"];
        }
        else
        {
            [self checkPhone];
        }
    }
}

#pragma mark - 卡券转让请求
- (void)checkPhone
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:_phoneNumTF.text forKey:@"mobile"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
//    __weak typeof(self) weakSelf = self;
    [manager POST:kcheckMobileUniqueUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"code"] isEqualToString:@"000"]) {
            
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
    }];
}

#pragma mark - textfeild delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location>=11&&textField==_phoneNumTF) {
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

- (IBAction)transAct:(UIButton *)sender
{
    if(_phoneNumTF.text.length!=11)
    {
        [SVProgressHUD showErrorWithStatus:@"手机号码有误"];
        return;
    }
    if([_moneyTF.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"输入金额有误"];
        return;
    }
    [self transterRequest];
}
@end
