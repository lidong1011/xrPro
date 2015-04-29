//
//  BeginTenderViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/13.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "BeginTenderViewController.h"
#import "ChongZhiViewController.h"
#import "KaiTongHFViewController.h"
@interface BeginTenderViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) int btnSelectFlag;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BeginTenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"投标";
    //充值
    //UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //rightBtn.frame = CGRectMake(0, 100, 60, 31);
//    [rightBtn setBackgroundImage:[UIImage imageNamed:@"person.png"] forState:UIControlStateNormal];
    //[rightBtn setTitle:@"充值" forState:UIControlStateNormal];
    //[rightBtn addTarget:self action:@selector(chongZhi) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"充值" style:UIBarButtonItemStylePlain target:self action:@selector(chongZhi)];
    self.navigationItem.rightBarButtonItem = right;
    
    _keTouLab.text = [NSString stringWithFormat:@"%ld元",_keTouMoney];
    
    NSDictionary *msg = [[NSUserDefaults standardUserDefaults]objectForKey:kUserMsg];
    _jiFenLab.text = [msg[@"points"] stringValue];
    [_changJFTF addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview];
    
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

#pragma mark - 确认投标请求
- (void)touBiaoRequest
{
    /*用户ID customerId 必填
     投标金额 tenderMoney 必填
     标ID biddingId 必填
     depositNo F码抵扣 非必填
     agioPoint 积分抵扣 非必填
     页面上面抵扣金额的积分 dikb 非必填
     是否为定向标 authStr 非必填
     请求类别 reqType 必填*/
    [SVProgressHUD showWithStatus:@"努力加载中..."];
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, kNavigtBarH, kWidth, kHeight-kNavigtBarH)];
    _webView.hidden=YES;
    [self.view addSubview:_webView];
    _webView.delegate = self;
    
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    NSString *tenderMoney = _inputMoneyTF.text;
    NSString *url;
    if (_btnSelectFlag==1) {
        url = [NSString stringWithFormat:@"%@&customerId=%@&tenderMoney=%@&biddingId=%@&reqType=ios&depositNo=%@",kinitiativeTenderUrl,custId,tenderMoney,_biddingId,_FCodeTF.text];
    }
    else if(_btnSelectFlag==2)
    {
        url = [NSString stringWithFormat:@"%@&customerId=%@&tenderMoney=%@&biddingId=%@&reqType=ios&dikb=%@",kinitiativeTenderUrl,custId,tenderMoney,_biddingId,_changJFTF.text];
    }
    else
    {
        url = [NSString stringWithFormat:@"%@&customerId=%@&tenderMoney=%@&biddingId=%@&reqType=ios",kinitiativeTenderUrl,custId,tenderMoney,_biddingId];
    }
    //    string = @"http://baidu.com";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
    _webView.hidden = NO;
    [self.view addSubview:_webView];
    
//    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
//    [SVProgressHUD showWithStatus:@"加载数据中..."];
//    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
//    [parameter setObject:custId forKey:@"customerId"];
//    [parameter setObject:_biddingId forKey:@"biddingId"];
//    [parameter setObject:_inputMoneyTF.text forKey:@"tenderMoney"];
//    [parameter setObject:@"ios" forKey:@"reqType"];
//    if (_btnSelectFlag==1)
//    {
//        [parameter setObject:_FCodeTF.text forKey:@"depositNo"];
//    }
//    else if(_btnSelectFlag==2)
//    {
//        [parameter setObject:_diKeJiFenLab.text forKey:@"dikb"];
//    }
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
//    //https请求方式设置
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//    securityPolicy.allowInvalidCertificates = YES;
//    manager.securityPolicy = securityPolicy;
//    [manager POST:kinitiativeTenderUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [self success:responseObject];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        MyLog(@"%@",error);
//        [self.tableView reloadData];
//    }];
}

#pragma mark - 请求返回数据
- (void)touBiaoSuccess:(id)response
{
//    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        //        [SVProgressHUD showSuccessWithStatus:@"成功"];
        self.keYongLab.text = [NSString stringWithFormat:@"%@元",dic[@"avlBal"]];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}


- (void)addSubview
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.redBagFBtn.bottom, kWidth, kHeight-self.redBagFBtn.bottom) style:UITableViewStylePlain];
    _tableView.tableFooterView = _queRenView;
    [self.view addSubview:_tableView];
    _tableView.scrollEnabled = NO;
    _keTouLab.text = [NSString stringWithFormat:@"%ld",_keTouMoney];
}

- (void)chongZhi
{
    ChongZhiViewController *chongZhiVC = [[ChongZhiViewController alloc]init];
    [self.navigationController pushViewController:chongZhiVC animated:YES];
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

- (IBAction)changeBtnAct:(UIButton *)sender
{
    sender.selected = !(sender.selected);
    if (sender.tag == 0)
    {
        _jiFenBtn.selected = NO;
        //判断是否选中
        if(_redBagFBtn.selected)
        {
            _btnSelectFlag = 1;
            _tableView.tableHeaderView = _redBagView;
        }
        else
        {
            _btnSelectFlag = 0;
            _tableView.tableHeaderView = nil;
        }
    }
    else
    {
        _redBagFBtn.selected = NO;
        if(_jiFenBtn.selected)
        {
            _btnSelectFlag = 2;
            _tableView.tableHeaderView = _jiFenView;
        }
        else
        {
            _btnSelectFlag = 0;
            _tableView.tableHeaderView = nil;
        }
    }
}

- (IBAction)comfireTuoZi:(UIButton *)sender {
    if ([self isRightInput]) {
        [self touBiaoRequest];
    }
}

- (BOOL)isRightInput
{
    if ([_inputMoneyTF.text integerValue]<100||[_inputMoneyTF.text integerValue]%100!=0) {
        [SVProgressHUD showErrorWithStatus:@"投资金额必须是100的整数倍！" maskType:SVProgressHUDMaskTypeGradient];
        return NO;
    }
    if (_btnSelectFlag==1) {
        //
        if (_FCodeTF.text.length<10) {
            [SVProgressHUD showErrorWithStatus:@"F码输入有误" maskType:SVProgressHUDMaskTypeGradient];
            return NO;
        }
    }
    else if(_btnSelectFlag==2)
    {
        if (_changJFTF.text.length<1) {
            [SVProgressHUD showErrorWithStatus:@"积分输入有误" maskType:SVProgressHUDMaskTypeGradient];
            return NO;
        }
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

- (void)textChange:(UITextField *)sender
{
    NSInteger money = [_changJFTF.text integerValue]*10;
//    _diKeJiFenLab.text = [NSString stringWithFormat:@"￥%ld元",[_changJFTF.text integerValue]];
    _diKeJiFenLab.text = [NSString stringWithFormat:@"%ld元",money];
    NSDictionary *msg = [[NSUserDefaults standardUserDefaults]objectForKey:kUserMsg];
    if (money>[msg[@"points"] integerValue]) {
        [SVProgressHUD showErrorWithStatus:@"抵换积分不能大于拥有积分"];
    }
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
            
            /*111 投标失败：抵扣投资金额时候只能使用一种                 抵扣方式。
             --112 投标失败：该红包F码已过期
             --113 投标失败：该类型的红包F码只能兑换几次
             --114 投标失败：红包无效。
             --115 投标失败：投标金额小于红包使用条件金额
             --116 投标失败：红包F码不存在
             --117 投标失败：非推广员用户不能使用积分抵扣
             --118 投标失败：理财师投资总额低于3万元时不能使用积分抵扣
             --119 投标失败：抵扣金额输入非法
             --120 投标失败：抵扣金额超出投资金额
             --121 投标失败：抵扣积分不足
             --122 投标失败：账户余额不足，请充值
             --123 投标失败：该标为定向标，投标需持有密码才能投标
             --124 投标失败：定向标投标密码不正确
             --125 投标失败：投资金额超过该标的可投金额
             --126 投标失败：红包F码不能为空*/
            if ([[components objectAtIndex:1] isEqualToString:@"000"]) {
                [SVProgressHUD showInfoWithStatus:@"投标成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else if([[components objectAtIndex:1] isEqualToString:@"000"])
            {
                [SVProgressHUD showInfoWithStatus:@"投标失败"];
                self.webView.hidden = YES;
            }
        }
        return NO;
    }
    return YES;
}

@end
