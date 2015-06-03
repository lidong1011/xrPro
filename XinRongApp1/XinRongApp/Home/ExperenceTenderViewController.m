//
//  ExperenceTenderViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/5/2.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "ExperenceTenderViewController.h"
#import "KaiTongHFViewController.h"
#import "TiYanJinViewController.h"
@interface ExperenceTenderViewController ()
@property (nonatomic, assign) NSInteger keYongTYJ;

@end

@implementation ExperenceTenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"体验标投标";
    
    _keTouLab.text = [NSString stringWithFormat:@"￥%ld",_keTouMoney];
    
    //获取可用余额
    [self getMyTiYanJinRequest];
}

//- (void)back
//{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

#pragma mark - 获取我的体验金请求
- (void)getMyTiYanJinRequest
{
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:custId forKey:@"customerId"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    [manager POST:kexperienceRecordUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        
    }];
}

#pragma mark - 请求返回数据
- (void)success:(id)response
{
    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        //        [SVProgressHUD showSuccessWithStatus:@"成功"];
        self.keYongTiYJLab.text = [NSString stringWithFormat:@"￥%@",[dic[@"unTenderAmt"] stringValue]];
        _keYongTYJ = [dic[@"unTenderAmt"] integerValue];
        if (_keTouMoney>=_keYongTYJ)
        {
            _inputMoneyTF.text = [NSString stringWithFormat:@"%ld",_keYongTYJ];
        }
        else
        {
            _inputMoneyTF.text = [NSString stringWithFormat:@"%ld",_keTouMoney];
        }
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

#pragma mark - 确认投标请求
- (void)touBiaoRequest
{
    /*用户IDcustomerId
     投资金额 transAmt：int型
     体验标id biddingId：string
     */
//    [SVProgressHUD showWithStatus:@"努力加载中..."];
//    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, kNavigtBarH, kWidth, kHeight-kNavigtBarH)];
//    _webView.hidden=YES;
//    [self.view addSubview:_webView];
//    _webView.delegate = self;
//    
//    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
//    NSString *tenderMoney = _inputMoneyTF.text;
//    NSString *url;
//    
//        url = [NSString stringWithFormat:@"%@&customerId=%@&tenderMoney=%@&biddingId=%@&reqType=ios",kinitiativeTenderUrl,custId,tenderMoney,_biddingId];
//    
//    //    string = @"http://baidu.com";
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    [_webView loadRequest:request];
//    _webView.hidden = NO;
//    [self.view addSubview:_webView];
    
        NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
        [SVProgressHUD showWithStatus:@"加载数据中..."];
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        [parameter setObject:custId forKey:@"customerId"];
        [parameter setObject:_biddingId forKey:@"biddingId"];
        [parameter setObject:_inputMoneyTF.text forKey:@"transAmt"];
        [parameter setObject:_ordType forKey:@"ordType"];
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
        //https请求方式设置
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        manager.securityPolicy = securityPolicy;
        [manager POST:kexperienceTenderUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self touBiaoSuccess:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            MyLog(@"%@",error);
            [SVProgressHUD showImage:[UIImage imageWithName:kLogo] status:@"投标失败"];
//            [self.tableView reloadData];
        }];
}

#pragma mark - 请求返回数据
- (void)touBiaoSuccess:(id)response
{
    //    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

- (IBAction)comfireTuoZi:(UIButton *)sender
{
    if ([self isRightInput]) {
        [self touBiaoRequest];
    }
}

- (BOOL)isRightInput
{
    if (_keYongTYJ<=0) {
        [SVProgressHUD showErrorWithStatus:@"你的体验金不足，或是数据未加载完！" maskType:SVProgressHUDMaskTypeGradient];
        return NO;
    }
    if ([[_yanZCode.text uppercaseString] isEqualToString:[_codeView.changeString uppercaseString]]==NO) {
        [SVProgressHUD showErrorWithStatus:@"验证码输入有误" maskType:SVProgressHUDMaskTypeGradient];
        return NO;
    }
    //先判断是否开通汇付
    NSDictionary *userMsgDic = [[NSUserDefaults standardUserDefaults]objectForKey:kUserMsg];
    if(userMsgDic[@"usrCustId"]==nil)
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"还未开通汇付，请开通汇付"];
        KaiTongHFViewController *kaitongHFVC = [[KaiTongHFViewController alloc]init];
        [self.navigationController pushViewController:kaitongHFVC animated:YES];
        return YES;
    }
    return  YES;
}

- (IBAction)getCodeAct:(UIButton *)sender {
    [_codeView changeCode];
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
