//
//  ZhaiQuanTransViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/16.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "ZhaiQuanTransViewController.h"
#import "ChongZhiViewController.h"
#import "KaiTongHFViewController.h"
@interface ZhaiQuanTransViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ZhaiQuanTransViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"承接";
    //充值
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 100, 40, 31);
    //    [rightBtn setBackgroundImage:[UIImage imageNamed:@"person.png"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"充值" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(chongZhi) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.transMonLab.text = [NSString stringWithFormat:@"%@元",[_transMoney stringValue]];
    self.chengJieLab.text = [NSString stringWithFormat:@"%@元",[_chengJieJin stringValue]];
    self.transMoneyTF.text = [NSString stringWithFormat:@"%@元",[_chengJieJin stringValue]];
    //获取可用余额
    [self getMyBalanceRequest];
}

#pragma mark - 获取我的余额请求
- (void)getMyBalanceRequest
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
    [manager POST:kqueryAmtUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        self.keYongLab.text = [NSString stringWithFormat:@"%@元",[dic[@"avlBal"] stringValue]];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

#pragma mark - 确认转让请求
- (void)transBiaoRequest
{
    [SVProgressHUD showWithStatus:@"努力加载中..."];
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, kNavigtBarH, kWidth, kHeight-kNavigtBarH)];
    _webView.delegate = self;
    
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    NSString *url = [NSString stringWithFormat:@"%@&customerId=%@&ordId=%@&reqType=ios",kcreditAssignUrl,custId,_ordId];

//        url = @"http://baidu.com";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
//    _webView.hidden = NO;
    [self.view addSubview:_webView];
    
//    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
//    
//    [SVProgressHUD showWithStatus:@"加载数据中..."];
//    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
//    [parameter setObject:custId forKey:@"customerId"];
//    [parameter setObject:_ordId forKey:@"ordId"];
//    [parameter setObject:@"ios" forKey:@"reqType"];
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
//    //https请求方式设置
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//    securityPolicy.allowInvalidCertificates = YES;
//    manager.securityPolicy = securityPolicy;
//    __weak typeof(self) weakSelf = self;
//    [manager POST:kcreditAssignUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [weakSelf transBiaoSuccess:responseObject];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        MyLog(@"%@",error);
//    }];
}

#pragma mark - 请求返回数据
- (void)transBiaoSuccess:(id)response
{
//    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
//        self.keYongLab.text = dic[@"avlBal"];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

- (void)chongZhi
{
    ChongZhiViewController *chongZhiVC = [[ChongZhiViewController alloc]init];
    [self.navigationController pushViewController:chongZhiVC animated:YES];
}

#pragma mark webView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}


//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [SVProgressHUD dismiss];
}

//监听
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@"//"];
    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"xr58app:"]) {
        NSString *string = (NSString *)[components objectAtIndex:1];
        components = [string componentsSeparatedByString:@"/"];
        if([(NSString *)[components objectAtIndex:0] isEqualToString:@"state"])
        {
//            UIAlertView *alert = [[UIAlertView alloc]
//                                  initWithTitle:@"code" message:[components objectAtIndex:1]
//                                  delegate:self cancelButtonTitle:nil
//                                  otherButtonTitles:@"OK", nil];
//            [alert show];
            if ([[components objectAtIndex:1] isEqualToString:@"000"]) {
                [SVProgressHUD showInfoWithStatus:@"转让成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [SVProgressHUD showInfoWithStatus:@"承接失败"];
                self.webView.hidden = YES;
            }
        }
        
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

- (IBAction)zhuanRangAct:(id)sender {
    //先判断是否开通汇付
    NSDictionary *userMsgDic = [[NSUserDefaults standardUserDefaults]objectForKey:kUserMsg];
    if(userMsgDic[@"usrCustId"]==nil)
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"还未开通汇付，请开通汇付"];
        KaiTongHFViewController *kaitongHFVC = [[KaiTongHFViewController alloc]init];
        [self.navigationController pushViewController:kaitongHFVC animated:YES];
        return;
    }
    [self transBiaoRequest];
}
@end
