//
//  TiXianViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/16.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "TiXianViewController.h"
#import "BankCardModel.h"
@interface TiXianViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tabViewMutArray;
@property (nonatomic, assign) BOOL isDiJiFen;
@property (nonatomic, strong) UITableView *bankCardTabView;
@end

@implementation TiXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     账户余额 acctBal
     冻结金额 frzBal
     待收总额(待收本金+待收利息)
     待收本金restCap
     待收利息restInt
     可用余额avlBal
     待收奖励collectionReward*/

    //初始化数据
    _tabViewMutArray = [NSMutableArray array];
    self.navigationItem.title = @"提现";
    _totalMoneyLab.text = [NSString stringWithFormat:@"￥%@元",[_balDic[@"acctBal"] stringValue]];
    _keYongLab.text = [NSString stringWithFormat:@"￥%@元",[_balDic[@"avlBal"] stringValue]];
    _keQuMonLab.text = [NSString stringWithFormat:@"￥%@元",[_balDic[@"avlBal"] stringValue]];
    [self addSubview];
    [_jieFenChangTF addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [_inputMoneyTF addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self getMyBankCardRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addSubview
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHScare(self.shouXuFenLab.bottom)+15, kWidth, kHeight-kHScare(self.shouXuFenLab.bottom)-5) style:UITableViewStylePlain];
    _tableView.tableFooterView = _footView;
    [self.view addSubview:_tableView];
    
    _bankCardTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigtBarH, kWidth, kHeight) style:UITableViewStylePlain];
    _bankCardTabView.delegate = self;
    _bankCardTabView.dataSource = self;
    _bankCardTabView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _bankCardTabView.hidden = YES;
    [self.view addSubview:_bankCardTabView];
//    _keTouLab.text = [NSString stringWithFormat:@"%ld",_keTouMoney];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_tabViewMutArray.count==0) {
        return 1;
    }
    return _tabViewMutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if(_tabViewMutArray.count==0)
    {
        cell.textLabel.text = @"还没绑定银行卡";
    }
    else
    {
        BankCardModel *dataModel = _tabViewMutArray[indexPath.row];
        cell.textLabel.text = dataModel.openAcctId;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankCardModel *dataModel = _tabViewMutArray[indexPath.row];
    _bankCardLab.text = dataModel.openAcctId;
    _bankCardTabView.hidden = YES;
}

- (void)addWebView
{
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _webView.hidden=YES;
    [self.view addSubview:_webView];
    _webView.delegate = self;
    /*用户ID customerId 必填
     提现金额 transAmt 必填
     卡号 openAcctId 必填
     输入抵扣的积分 dikb  非必填
     备注 remark 非必填
     返回地址 wxUrl 必填
     请求类别 reqType 必填
     */
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    NSString *transAmt = _inputMoneyTF.text;
    NSString *url;
    if (_isDiJiFen) {
        url = [NSString stringWithFormat:@"%@&customerId=%@&transAmt=%@&openAcctId=%@&reqType=ios&dikb=%.1f",kwithdrawUrl,custId,transAmt,_bankCardLab.text,[_jieFenChangTF.text floatValue]/10];
    }
    else
    {
        url = [NSString stringWithFormat:@"%@&customerId=%@&transAmt=%@&openAcctId=%@&reqType=ios",kwithdrawUrl,custId,transAmt,_bankCardLab.text];
    }
    //    string = @"http://baidu.com";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
    _webView.hidden = NO;
    _webView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_webView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)jiFenBtnAct:(UIButton *)sender {
    sender.selected = !sender.selected;
    _isDiJiFen = sender.selected;
    if (sender.selected) {
        _tableView.tableHeaderView = _jiFenView;
        _jieFenChangTF.delegate = self;
        NSDictionary *msg = [[NSUserDefaults standardUserDefaults]objectForKey:kUserMsg];
        _jiFenLab.text = [msg[@"points"] stringValue];
    }
    else
    {
        _tableView.tableHeaderView = nil;
    }
}

- (IBAction)tiXianBtn:(UIButton *)sender
{
    if (sender.tag==0) {
        //确认取现
        if([self isRightInput])
        {
            [self addWebView];
        }
    }
    else
    {
        //获取银行卡
        _bankCardTabView.hidden = NO;
    }
}

#pragma mark -数据输入是否有误
- (BOOL)isRightInput
{
    if ([_inputMoneyTF.text integerValue]<100) {
        [SVProgressHUD showErrorWithStatus:@"取现金额输入有误"];
        return NO;
    }
    //判断是否使用积分抵换
    if(_isDiJiFen)
    {
        if(_jieFenChangTF.text.length<1)
        {
            [SVProgressHUD showErrorWithStatus:@"积分输入有误"];
            return NO;
        }
        NSDictionary *msg = [[NSUserDefaults standardUserDefaults]objectForKey:kUserMsg];
        
        if ([_jieFenChangTF.text integerValue]>[msg[@"points"] integerValue]) {
            [SVProgressHUD showErrorWithStatus:@"抵换积分大于拥有积分"];
            return NO;
        }
    }
    if (_bankCardLab.text.length<10) {
        [SVProgressHUD showErrorWithStatus:@"请选择银行卡"];
        return NO;
    }

    return YES;
}

#pragma mark - 获取我的银行卡请求
- (void)getMyBankCardRequest
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
    [manager POST:kqueryCardUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self myBankCardsuccess:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        
    }];
}

#pragma mark - 请求返回数据
- (void)myBankCardsuccess:(id)response
{
    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        //        [SVProgressHUD showSuccessWithStatus:@"成功"];
        for(NSDictionary *dataDic in dic[@"data"])
        {
            [_tabViewMutArray addObject:[BankCardModel messageWithDict:dataDic]];
        }
        [_bankCardTabView reloadData];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}


- (void)textChange:(UITextField *)sender
{
    if (sender==_jieFenChangTF)
    {
        NSInteger money = [_jieFenChangTF.text integerValue]/10;
        _jiFenMoney.text = [NSString stringWithFormat:@"￥%ld元",money];
        NSDictionary *msg = [[NSUserDefaults standardUserDefaults]objectForKey:kUserMsg];
        if ([_jieFenChangTF.text integerValue]>[msg[@"points"] integerValue]) {
            [SVProgressHUD showErrorWithStatus:@"抵换积分不能大于拥有积分"];
        }
    }
    else
    {
        float money = [_inputMoneyTF.text floatValue]/1000*2;
        _shouXuFenLab.text = [NSString stringWithFormat:@"￥%.2f元",money];
        if ([_inputMoneyTF.text integerValue]>[_balDic[@"avlBal"] integerValue]) {
            [SVProgressHUD showErrorWithStatus:@"提取金额不能大于可取金额"];
        }
    }

}


@end
