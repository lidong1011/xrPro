//
//  TransferViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/18.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "TransferViewController.h"

@interface TransferViewController ()
@property (nonatomic, strong) NSDictionary *balaDic;
@end

@implementation TransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"转让";
    _balaDic = [NSDictionary dictionary];
    [self getTransfDataRequest];
}

#pragma mark - 转让标数据请求
- (void)getTransfDataRequest
{
    /*用户IDcustomerId 必填
     转让标ID tenderId 必填
     */
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:custId forKey:@"customerId"];
    [parameter setObject:_tenderId forKey:@"tenderId"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    __weak typeof(self) weakSelf = self;
    [manager POST:ktoTransferUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf transDataSuccess:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        
    }];
}

#pragma mark - 请求返回数据
- (void)transDataSuccess:(id)response
{
    //    [SVProgressHUD dismiss];
    /*restCap 本笔投资金额
     useRestCap本笔投资已转金额
     hasrestCap 本笔投资可转金额
     tenderId 转让标的ID*/
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
        _balaDic = dic;
        self.tenderMoneyLab.text = [dic[@"restCap"] stringValue];
        self.didTransLab.text = [dic[@"useRestCap"] stringValue];
        self.canTransLab.text = [dic[@"hasrestCap"] stringValue];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

#pragma mark - 转让请求
- (void)transferRequest
{
    /*用户IDcustomerId 必填
     转让标ID tenderId 必填
     转让本金 transAmt  必填
     承接价格 creditDealAmt   必填
     */
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:custId forKey:@"customerId"];
    [parameter setObject:_tenderId forKey:@"tenderId"];
    [parameter setObject:_transMoneyTF.text forKey:@"transAmt"];
    [parameter setObject:_transPriceTF.text forKey:@"creditDealAmt"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    __weak typeof(self) weakSelf = self;
    [manager POST:ktransferUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf transSuccess:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        
    }];
}

#pragma mark - 请求返回数据
- (void)transSuccess:(id)response
{
//    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
//        self.keYongLab.text = [dic[@"avlBal"] stringValue];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
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

- (IBAction)changeCode:(UIButton *)sender {
    [self.code changeCode];
}

- (IBAction)transBtnAct:(UIButton *)sender {
    if (_transMoneyTF.text.length<3) {
        [SVProgressHUD showInfoWithStatus:@"转让金额输入有误"];
        return;
    }
    if ([_transMoneyTF.text integerValue]>[_balaDic[@"hasrestCap"] integerValue]) {
        [SVProgressHUD showInfoWithStatus:@"转让金额不能大于可转金额"];
        return;
    }
    if (_transPriceTF.text.length<3) {
        [SVProgressHUD showInfoWithStatus:@"承接价格输入有误"];
        return;
    }
    if ([_transPriceTF.text integerValue]>[_transMoneyTF.text integerValue]||[_transPriceTF.text integerValue]<[_transMoneyTF.text integerValue]*0.9) {
        [SVProgressHUD showInfoWithStatus:@"承接价格不能大于转让金额且不能低于转让金额的90%"];
        return;
    }
    if ([[_yanCodeTF.text uppercaseString] isEqualToString:[self.code.changeString uppercaseString]] == NO) {
        [SVProgressHUD showInfoWithStatus:@"验证码有误"];
        return;
    }
    [self transferRequest];
}
@end
