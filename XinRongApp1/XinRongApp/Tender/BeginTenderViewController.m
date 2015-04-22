//
//  BeginTenderViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/13.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "BeginTenderViewController.h"
#import "ChongZhiViewController.h"
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
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 100, 60, 31);
//    [rightBtn setBackgroundImage:[UIImage imageNamed:@"person.png"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"充值" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(chongZhi) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
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
        self.keYongLab.text = [dic[@"avlBal"] stringValue];
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
    _webView.backgroundColor = [UIColor greenColor];
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
        self.keYongLab.text = dic[@"avlBal"];
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
    [self touBiaoRequest];
}

- (IBAction)getCodeAct:(UIButton *)sender {
    
}

- (void)textChange:(UITextField *)sender
{
    NSInteger money = [_changJFTF.text integerValue]*10;
//    _diKeJiFenLab.text = [NSString stringWithFormat:@"￥%ld元",[_changJFTF.text integerValue]];
    _diKeJiFenLab.text = [NSString stringWithFormat:@"%ld",money];
    NSDictionary *msg = [[NSUserDefaults standardUserDefaults]objectForKey:kUserMsg];
    if (money>[msg[@"points"] integerValue]) {
        [SVProgressHUD showErrorWithStatus:@"抵换积分不能大于拥有积分"];
    }
}

@end
