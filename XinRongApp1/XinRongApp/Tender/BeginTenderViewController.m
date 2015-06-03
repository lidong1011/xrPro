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
#import "JiaXiQuanModel.h"
#import "JiaXiQuanCell.h"
@interface BeginTenderViewController ()<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) int btnSelectFlag;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSDictionary *balaceDic;
//加息券
@property (nonatomic, strong) UITableView *jiaxqTableView;
@property (nonatomic, strong) NSMutableArray *tabViewMutArray;
@end

@implementation BeginTenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"投标";
    //充值
    //UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //rightBtn.frame = CGRectMake(0, 100, 60, 31);
//    [rightBtn setBackgroundImage:[UIImage imageNamed:@"person.png"] forState:UIControlStateNormal];
    //[rightBtn setTitle:@"充值" forState:UIControlStateNormal];
    //[rightBtn addTarget:self action:@selector(chongZhi) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"充值" style:UIBarButtonItemStylePlain target:self action:@selector(chongZhi)];
    self.navigationItem.rightBarButtonItem = right;
    
    _keTouLab.text = [NSString stringWithFormat:@"￥%ld",_keTouMoney];
    
    NSDictionary *msg = [[NSUserDefaults standardUserDefaults]objectForKey:kUserMsg];
    _jiFenLab.text = [NSString stringWithFormat:@"%@分",[msg[@"points"] stringValue]];
    _jjJiFenLab.text = [NSString stringWithFormat:@"%@分",[msg[@"points"] stringValue]];
    [_changJFTF addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [_jjChangJFTF addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [_yanZCode addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self initData];
    
    [self addSubview];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //获取可用余额
    [self getMyBalanceRequest];
}


- (void)initData
{
    _tabViewMutArray = [NSMutableArray array];
    _balaceDic = [NSDictionary dictionary];
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
        self.keYongLab.text = [NSString stringWithFormat:@"￥%@",[dic[@"avlBal"] stringValue]];
        _balaceDic = dic;
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
     请求类别 reqType 必填
     投标方式 tenderWay  必填
     抵扣类型 offWay  非必填
     加息券ID kitId 非必填*/
    [SVProgressHUD showWithStatus:@"努力加载中..."];
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, kNavigtBarH, kWidth, kHeight-kNavigtBarH)];
    _webView.hidden=YES;
    [self.view addSubview:_webView];
    _webView.delegate = self;
    
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    NSString *tenderMoney = _inputMoneyTF.text;
    NSString *url;
    if (_btnSelectFlag==1) {
        url = [NSString stringWithFormat:@"%@&customerId=%@&tenderMoney=%@&biddingId=%@&reqType=ios&tenderWay=5&offWay=1&depositNo=%@",kinitiativeTenderUrl,custId,tenderMoney,_biddingId,_FCodeTF.text];
    }
    else if(_btnSelectFlag==2)
    {
        url = [NSString stringWithFormat:@"%@&customerId=%@&tenderMoney=%@&biddingId=%@&reqType=ios&tenderWay=5&offWay=2&dikb=%@",kinitiativeTenderUrl,custId,tenderMoney,_biddingId,_changJFTF.text];
    }
    else if(_btnSelectFlag==3)
    {
        url = [NSString stringWithFormat:@"%@&customerId=%@&tenderMoney=%@&biddingId=%@&reqType=ios&tenderWay=5&kitId=%@",kinitiativeTenderUrl,custId,tenderMoney,_biddingId,_jiaXiQNumTF.text];
    }
    else if(_btnSelectFlag==4)
    {
        url = [NSString stringWithFormat:@"%@&customerId=%@&tenderMoney=%@&biddingId=%@&reqType=ios&tenderWay=5&offWay=2&kitId=%@&depositNo=%@",kinitiativeTenderUrl,custId,tenderMoney,_biddingId,_rjJiaXiQTF.text,_rjFCodeTF.text];
    }
    else if(_btnSelectFlag==5)
    {
        url = [NSString stringWithFormat:@"%@&customerId=%@&tenderMoney=%@&biddingId=%@&reqType=ios&tenderWay=5&kitId=%@&dikb=%@",kinitiativeTenderUrl,custId,tenderMoney,_biddingId,_jjChangJFTF.text,_jjJiaXiQTF];
    }
    else
    {
        url = [NSString stringWithFormat:@"%@&customerId=%@&tenderMoney=%@&biddingId=%@&reqType=ios&tenderWay=5",kinitiativeTenderUrl,custId,tenderMoney,_biddingId];
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
        self.keYongLab.text = [NSString stringWithFormat:@"￥%@",dic[@"avlBal"]];
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
    _keTouLab.text = [NSString stringWithFormat:@"￥%ld",_keTouMoney];
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

- (IBAction)selectJXQ:(UIButton *)sender
{
    if (_tabViewMutArray.count) {
        [self JiaXiQuanTableView];
    }
    else
    {
        [SVProgressHUD showImage:[UIImage imageNamed:kLogo] status:@"没有可以用的加息券"];
    }
}

- (IBAction)changeBtnAct:(UIButton *)sender
{
    sender.selected = !(sender.selected);
//    if (sender.tag == 0)
//    {
//        _jiFenBtn.selected = NO;
//        _jiaXiBtn.selected = NO;
//        //判断是否选中
//        if(_redBagFBtn.selected)
//        {
//            _btnSelectFlag = 1;
//            _tableView.tableHeaderView = _redBagView;
//        }
//        else
//        {
//            _btnSelectFlag = 0;
//            _tableView.tableHeaderView = nil;
//        }
//    }
//    else if(sender.tag==1)
//    {
//        _redBagFBtn.selected = NO;
//        _jiaXiBtn.selected = NO;
//        if(_jiFenBtn.selected)
//        {
//            _btnSelectFlag = 2;
//            _tableView.tableHeaderView = _jiFenView;
//        }
//        else
//        {
//            _btnSelectFlag = 0;
//            _tableView.tableHeaderView = nil;
//        }
//    }
//    else
//    {
//        _jiFenBtn.selected = NO;
//        _redBagFBtn.selected = NO;
//        if(_jiaXiBtn.selected)
//        {
//            _btnSelectFlag = 3;
//            _tableView.tableHeaderView = _jiaXiQView;
//            //获取加息券
//            [self getJiaXiQuan];
//            
//        }
//        else
//        {
//            _btnSelectFlag = 0;
//            _tableView.tableHeaderView = nil;
//        }
//    }
    
    //红包和积分不能同时用
    if (sender.tag==0) {
        _jiFenBtn.selected = NO;
    }
    else if(sender.tag==1)
    {
        _redBagFBtn.selected = NO;
    }
    
    //判断是那种方式
    if (_redBagFBtn.selected==1&&_jiFenBtn.selected==0&&_jiaXiBtn.selected==0)
    {
        _btnSelectFlag = 1;
    }
    else if (_redBagFBtn.selected==0&&_jiFenBtn.selected==1&&_jiaXiBtn.selected==0)
    {
        _btnSelectFlag = 2;
    }
    else if (_redBagFBtn.selected==0&&_jiFenBtn.selected==0&&_jiaXiBtn.selected==1)
    {
        _btnSelectFlag = 3;
    }
    else if (_redBagFBtn.selected==1&&_jiFenBtn.selected==0&&_jiaXiBtn.selected==1)
    {
        _btnSelectFlag = 4;
    }
    else if (_redBagFBtn.selected==0&&_jiFenBtn.selected==1&&_jiaXiBtn.selected==1)
    {
        _btnSelectFlag = 5;
    }
    else
    {
        _btnSelectFlag = 0;
    }
    [self viewOfWay];
}

//是那种方式投资，对应有不同的界面(0为默认，1使用红包，2使用积分，3使用加息，4红包和加息，5积分和加息)
- (void)viewOfWay
{
    switch (_btnSelectFlag) {
        case 0:
            _tableView.tableHeaderView = nil;
            break;
        case 1:
            _tableView.tableHeaderView = _redBagView;
            break;
        case 2:
            _tableView.tableHeaderView = _jiFenView;
            break;
        case 3:
            _tableView.tableHeaderView = _jiaXiQView;
            break;
        case 4:
            _tableView.tableHeaderView = _redBagAndJXQView;
            break;
        case 5:
            _tableView.tableHeaderView = _jiFenAndJXQView;
            break;

        default:
            _tableView.tableHeaderView = nil;
            break;
    }
}

- (void)JiaXiQuanTableView
{
    _jiaxqTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigtBarH, kWidth, kHeight-kNavigtBarH)];
//    _jiaxqTableView.center = self.view.center;
    _jiaxqTableView.delegate = self;
    _jiaxqTableView.dataSource = self;
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth, 30)];
    titleLab.text = @"选择加息券";
    titleLab.textColor = [UIColor grayColor];
//    titleLab.backgroundColor = [UIColor greenColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    _jiaxqTableView.tableHeaderView = titleLab;
    _jiaxqTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_jiaxqTableView];
}

- (void)getJiaXiQuan
{
    [SVProgressHUD showWithStatus:@"获取可用..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        //加息券
    NSString *url = kqueryKitUrl;
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:kUserMsg];
    [parameter setObject:dic[@"mobile"] forKey:@"mobile"];
    
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    [parameter setObject:custId forKey:kCustomerId];
    [parameter setObject:@"0" forKey:@"status"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self getJiaXiQuan:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        [_tabViewMutArray removeAllObjects];
        [self.tableView reloadData];
    }];
}

#pragma mark - 注册请求返回数据
- (void)getJiaXiQuan:(id)response
{
    //把tableView 清空
    [_tabViewMutArray removeAllObjects];
    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
//        [SVProgressHUD showImage:[UIImage imageNamed:@"logo_tu.png"] status:@"数据获取成功" maskType:SVProgressHUDMaskTypeGradient];
        [_tabViewMutArray removeAllObjects];
        for (NSDictionary *dataDic in dic[@"data"]) {
            [_tabViewMutArray addObject:[JiaXiQuanModel messageWithDict:dataDic]];
        }
        [_jiaxqTableView reloadData];
        if (_tabViewMutArray.count) {
        }
        else
        {
            [SVProgressHUD showImage:[UIImage imageNamed:kLogo] status:@"没有可以用的加息券"];
        }
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

#pragma mark - tableView dataSource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tabViewMutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //按情况加载不同的cell
    static NSString *identifier = @"cell";
    
    NSDictionary* style1 = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:14.0],
                             @"bold":[UIFont fontWithName:@"HelveticaNeue-Bold" size:32.0]
                             };

    JiaXiQuanModel *dataModel = _tabViewMutArray[indexPath.row];
    JiaXiQuanCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"JiaXiQuanCell" owner:self options:nil][0];
    }
//        //status 0/未使用, 1/转让中, 2/已使用,3/已转让, 4,无效 无效状态需要在页面上根据当前时间和有效期 edate去对比
    cell.title.text = dataModel.name;

    cell.intRateLab.text = [NSString stringWithFormat:@"%.1f%%",[dataModel.intRate floatValue]*100];
    cell.youXiaoQiLab.text = [dataModel.edate substringToIndex:10];
    /*加息券名称name
     有效期 edate
     利率 intRate
     状态 status
     加息券ID kitId
     购买人ID targetId
     卖家ID userId
     加息券转让ID ordId*/

    if([self isEndTimeWithEtime:dataModel.edate])
    {
        //过期
        cell.statusLab.text = @"";
        cell.stateBtn1.hidden = YES;
        cell.stateBtn2.hidden = NO;
        cell.stateBtn3.hidden = YES;
        [cell.stateBtn2 setTitle:@"已过期" forState:UIControlStateNormal];
        cell.stateBtn2.enabled = NO;
    }
    else
    {
        cell.statusLab.text = @"";
        cell.stateBtn1.hidden = YES;
        cell.stateBtn2.hidden = NO;
        cell.stateBtn3.hidden = YES;
        [cell.stateBtn2 setTitle:@"可使用" forState:UIControlStateNormal];
//        cell.stateBtn2.enabled = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JiaXiQuanModel *model = _tabViewMutArray[indexPath.row];
    _jiaXiQNumTF.text = [model.kitId stringValue];
    [_jiaxqTableView removeFromSuperview];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 134;
}

#pragma mark 是否过期-加息券
- (BOOL)isEndTimeWithEtime:(NSString *)endTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *endDate= [dateFormatter dateFromString:endTime];
    NSTimeInterval nowTimeInter = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval endTimeInter = [endDate timeIntervalSince1970];
    if(endTimeInter>nowTimeInter)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (IBAction)comfireTuoZi:(UIButton *)sender {
    if ([self isRightInput]) {
        [self.codeView changeCode];
        _isRightImg.hidden = YES;
        [self touBiaoRequest];
    }
}

- (BOOL)isRightInput
{
    if ([_inputMoneyTF.text integerValue]<100||[_inputMoneyTF.text integerValue]%100!=0) {
        [SVProgressHUD showErrorWithStatus:@"投资金额必须是100的整数倍！" maskType:SVProgressHUDMaskTypeGradient];
        return NO;
    }
    if ([_inputMoneyTF.text integerValue]>= _keTouMoney) {
        [SVProgressHUD showErrorWithStatus:@"投资金额不能大于可投余额！" maskType:SVProgressHUDMaskTypeGradient];
        return NO;
    }
    if ([_inputMoneyTF.text integerValue]>= [_balaceDic[@"avlBal"] integerValue]) {
        [SVProgressHUD showErrorWithStatus:@"投资金额不能大于可用余额！" maskType:SVProgressHUDMaskTypeGradient];
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
    else if(_btnSelectFlag==3)
    {
        if (_jiaXiQNumTF.text.length<1) {
            [SVProgressHUD showErrorWithStatus:@"还未选择加息券" maskType:SVProgressHUDMaskTypeGradient];
            return NO;
        }
    }
    else if(_btnSelectFlag==4)
    {
        if (_rjFCodeTF.text.length<10) {
            [SVProgressHUD showErrorWithStatus:@"F码输入有误" maskType:SVProgressHUDMaskTypeGradient];
            return NO;
        }
        if (_rjJiaXiQTF.text.length<1) {
            [SVProgressHUD showErrorWithStatus:@"还未选择加息券" maskType:SVProgressHUDMaskTypeGradient];
            return NO;
        }
    }
    else if(_btnSelectFlag==5)
    {
        if (_jjChangJFTF.text.length<1) {
            [SVProgressHUD showErrorWithStatus:@"积分输入有误" maskType:SVProgressHUDMaskTypeGradient];
            return NO;
        }
        if (_jjJiaXiQTF.text.length<1) {
            [SVProgressHUD showErrorWithStatus:@"还未选择加息券" maskType:SVProgressHUDMaskTypeGradient];
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
    _isRightImg.hidden = YES;
}

- (void)textChange:(UITextField *)sender
{
    if (sender==_yanZCode)
    {
        if ([[_yanZCode.text uppercaseString] isEqualToString:[_codeView.changeString uppercaseString]]==NO)
        {
//                [SVProgressHUD showErrorWithStatus:@"验证码输入有误" maskType:SVProgressHUDMaskTypeGradient];
                _isRightImg.hidden = YES;
            }
            else
            {
                _isRightImg.hidden = NO;
            }
        }
    else
    {
        NSInteger money;
        if (sender==_changJFTF)
        {
            money = [_changJFTF.text integerValue]*10;
            _diKeJiFenLab.text = [NSString stringWithFormat:@"%ld分",money];
        }
        else
        {
            money = [_jjChangJFTF.text integerValue]*10;
            _jjDiKeJiFenLab.text = [NSString stringWithFormat:@"%ld分",money];
        }
        
        NSDictionary *msg = [[NSUserDefaults standardUserDefaults]objectForKey:kUserMsg];
        if (money>[msg[@"points"] integerValue]) {
            [SVProgressHUD showErrorWithStatus:@"抵换积分不能大于拥有积分"];
        }
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
            else if([[components objectAtIndex:1] isEqualToString:@"112"])
            {
                [SVProgressHUD showInfoWithStatus:@"投标失败：该红包F码已过期"];
                self.webView.hidden = YES;
            }
            else if([[components objectAtIndex:1] isEqualToString:@"116"])
            {
                [SVProgressHUD showInfoWithStatus:@"投标失败：红包F码不存在"];
                self.webView.hidden = YES;
            }
            else if([[components objectAtIndex:1] isEqualToString:@"113"])
            {
                [SVProgressHUD showInfoWithStatus:@"该类型的红包F码只能兑换1次"];
                self.webView.hidden = YES;
            }
            else if([[components objectAtIndex:1] isEqualToString:@"117"])
            {
                [SVProgressHUD showInfoWithStatus:@"投标失败：非推广员用户不能使用积分抵扣"];
                self.webView.hidden = YES;
            }
            else if([[components objectAtIndex:1] isEqualToString:@"118"])
            {
                [SVProgressHUD showInfoWithStatus:@"投标失败：理财师投资总额低于3万元时不能使用积分抵扣"];
                self.webView.hidden = YES;
            }
            else if([[components objectAtIndex:1] isEqualToString:@"119"])
            {
                [SVProgressHUD showInfoWithStatus:@"投标失败：抵扣金额输入非法"];
                self.webView.hidden = YES;
            }
            else if([[components objectAtIndex:1] isEqualToString:@"120"])
            {
                [SVProgressHUD showInfoWithStatus:@"投标失败：抵扣金额超出投资金额"];
                self.webView.hidden = YES;
            }
            else if([[components objectAtIndex:1] isEqualToString:@"117"])
            {
                [SVProgressHUD showInfoWithStatus:@"投标失败：非推广员用户不能使用积分抵扣"];
                self.webView.hidden = YES;
            }
            else
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
