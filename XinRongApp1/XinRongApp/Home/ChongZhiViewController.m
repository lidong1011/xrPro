//
//  ChongZhiViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/13.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "ChongZhiViewController.h"

@interface ChongZhiViewController ()<UIWebViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSDictionary *dic;
@end

@implementation ChongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"充值";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_chongView];
    [_chongZJinTF addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    _dic = [NSDictionary dictionary];
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
        _dic = dic;
        self.keYongELab.text = [dic[@"avlBal"] stringValue];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

- (void)viewWillLayoutSubviews
{
    _chongView.frame = CGRectMake(0, kNavigtBarH, kWidth, kHeight-kNavigtBarH);
}

- (void)addWebView
{
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, kNavigtBarH, kWidth, kHeight)];
    _webView.hidden=YES;
    [self.view addSubview:_webView];
    _webView.delegate = self;
    /*用户ID customerId  必填
     充值金额 transAmt  必填
     请求类别 reqType 必填  必填
     */
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    NSString *transAmt = _chongZJinTF.text;
    NSString *url = [NSString stringWithFormat:@"%@&customerId=%@&transAmt=%@&reqType=ios",krechargeUrl,custId,transAmt];
    //    string = @"http://baidu.com";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
    _webView.hidden = NO;
    _chongView.hidden = YES;
    _webView.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:_webView];
}

#pragma mark - 转让请求
- (void)transferRequest
{
    /*用户ID customerId  必填                
     充值金额 transAmt  必填
     请求类别 reqType 必填  必填
     */
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:custId forKey:@"customerId"];
//    [parameter setObject:_tenderId forKey:@"tenderId"];
//    [parameter setObject:_transMoneyTF.text forKey:@"transAmt"];
//    [parameter setObject:_transPriceTF.text forKey:@"creditDealAmt"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    __weak typeof(self) weakSelf = self;
    [manager POST:ktransferUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [weakSelf transSuccess:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        
    }];
}

//#pragma mark - 请求返回数据
//- (void)transSuccess:(id)response
//{
//    //    [SVProgressHUD dismiss];
//    NSDictionary *dic = (NSDictionary *)response;
//    MyLog(@"%@",dic);
//    if ([dic[@"code"] isEqualToString:@"000"])
//    {
//        [SVProgressHUD showSuccessWithStatus:dic[@"msg"]];
//        //        self.keYongLab.text = [dic[@"avlBal"] stringValue];
//    }
//    else
//    {
//        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
//    }
//}

#pragma mark webView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}


//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
}

//监听
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //    //    [self setNavigationLeftBg:@"ishome.png"];
    //    NSString *requestString = [[request URL] absoluteString];
    //    NSString *protocol = @"leave_view";
    //    NSLog(@"%@",requestString);
    //
    ////    if ([requestString rangeOfString:flagStr].location != NSNotFound)
    ////    {
    ////    }
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@"//"];
    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"xr58app:"]) {
        NSString *string = (NSString *)[components objectAtIndex:1];
        components = [string componentsSeparatedByString:@"/"];
        if([(NSString *)[components objectAtIndex:0] isEqualToString:@"state"])
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"code" message:[components objectAtIndex:1]
                                  delegate:self cancelButtonTitle:nil
                                  otherButtonTitles:@"OK", nil];
            [alert show];
            [self.navigationController popViewControllerAnimated:YES];
        }
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textChange:(UITextField *)sender
{
    NSInteger money = [_dic[@"avlBal"] integerValue]+[_chongZJinTF.text integerValue];
    _cZHouJinLab.text = [NSString stringWithFormat:@"%ld元",money];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)chongZhiAct:(UIButton *)sender {
    NSString *transAmt = _chongZJinTF.text;
    if ([transAmt integerValue]<100) {
        [SVProgressHUD showErrorWithStatus:@"输入金额有误"];
        return;
    }
    [self addWebView];
}
@end
