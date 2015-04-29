//
//  MyCardViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/20.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "MyCardViewController.h"
#import "DZNSegmentedControl.h"
#import "RedBagCZViewController.h"
#import "TransterJXQViewController.h"
#import "MJRefresh.h"
#import "JiaXiQuanCell.h"
#import "RedBagCell.h"
#import "WPAttributedStyleAction.h"
#import "NSString+WPAttributedMarkup.h"
#import "PayJiaXiQViewController.h"

#import "JiaXiQuanModel.h"
#import "RedBagModel.h"
@interface MyCardViewController ()<DZNSegmentedControlDelegate,UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, assign) NSInteger segementIndex;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tabViewMutArray;
@property (nonatomic, strong) NSMutableArray *jiaXiMutArray;
//@property (nonatomic, assign) int tenderPageNo;
@property (nonatomic, strong) NSMutableArray *redBagMutArray;
//@property (nonatomic, assign) int zaiQuanPageNo;

@property (nonatomic, assign) NSInteger dataCount;

@property (nonatomic, strong) NSString *ordId;//交易Id
@property (nonatomic, strong) NSString *kitId;//加息券Id
@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIAlertView *cancelTransAlertView;
@property (nonatomic, strong) UIAlertView *cancelPayAlertView;
@end
#define kSegmentedControlHeight 35
@implementation MyCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的卡券";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self initData];
    
    //添加子视图
    [self initSubview];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    //加载数据
    [super viewDidAppear:animated];
    [self getListRequest];
}

//init data
- (void)initData
{
    _menuItems = @[@"加息券",@"红包"];
//    _tenderPageNo = 1;
//    _zaiQuanPageNo = 1;
    _tabViewMutArray = [NSMutableArray array];
    _jiaXiMutArray = [NSMutableArray array];
    _redBagMutArray = [NSMutableArray array];
}

//添加子视图
- (void)initSubview
{
    //添加分段条
    [self addSegmentControl];
    
    //添加列表
    [self addTableView];
}

//ttps://www.xr58.com:8443/xr58/apprequest/request?code=queryTransfer&type=biddingList&pageNo=1&pageSize=100
#pragma mark - 卡券列表请求
- (void)getListRequest
{
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    NSString *url;
    if(_segementIndex==0)
    {
        //加息券
        url = kqueryKitUrl;
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:kUserMsg];
        [parameter setObject:dic[@"mobile"] forKey:@"mobile"];
    }
    else
    {
        //红包
        url = kqueryRedPaperUrl;
    }
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    [parameter setObject:custId forKey:kCustomerId];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        [_tabViewMutArray removeAllObjects];
        [self.tableView reloadData];
    }];
}

#pragma mark - 注册请求返回数据
- (void)success:(id)response
{
    //把tableView 清空
    [_tabViewMutArray removeAllObjects];
//    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    [self.tableView.footer endRefreshing];
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@"logo_tu.png"] status:@"数据获取成功" maskType:SVProgressHUDMaskTypeGradient];
        if (_segementIndex==0) {
            [_jiaXiMutArray removeAllObjects];
            for (NSDictionary *dataDic in dic[@"data"]) {
                [_jiaXiMutArray addObject:[JiaXiQuanModel messageWithDict:dataDic]];
            }
            _tabViewMutArray = [NSMutableArray arrayWithArray:_jiaXiMutArray];
        }
        else
        {
            [_redBagMutArray removeAllObjects];
            for (NSDictionary *dataDic in dic[@"data"]) {
                [_redBagMutArray addObject:[RedBagModel messageWithDict:dataDic]];
            }
            _tabViewMutArray = [NSMutableArray arrayWithArray:_redBagMutArray];;
        }
        [_tableView reloadData];
    }
    else
    {
        //        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

#pragma mark 添加分段条
- (void)addSegmentControl
{
    // 添加分段条
    DZNSegmentedControl *segmentedControl = [[DZNSegmentedControl alloc] initWithItems:self.menuItems];
    
    segmentedControl.height = kSegmentedControlHeight;
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.bouncySelectionIndicator = YES;
    segmentedControl.tintColor = kZhuTiColor;
    segmentedControl.showsCount = NO;
    [segmentedControl setFont:[UIFont systemFontOfSize:8]];
    
    // 添加点击方法
    [segmentedControl addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
}

#pragma mark 分段条目点击方法
- (void)selectedSegment:(DZNSegmentedControl *)control
{
    MyLog(@"选择了第%ld项",(long)control.selectedSegmentIndex);
    [self.tableView.footer resetNoMoreData];
    _segementIndex = control.selectedSegmentIndex;
    // 设置导航条标题
    self.navigationItem.title = self.menuItems[control.selectedSegmentIndex];
    
    switch (control.selectedSegmentIndex) {
        case 0: // 加息券
            if(_jiaXiMutArray.count>0)
            {
                _tabViewMutArray = [NSMutableArray arrayWithArray:_jiaXiMutArray];
                [self.tableView reloadData];
            }
            else
            {
                [self getListRequest];
            }
            break;
        case 1: // 红包
            if(_redBagMutArray.count>0)
            {
                _tabViewMutArray = [NSMutableArray arrayWithArray:_redBagMutArray];
                [self.tableView reloadData];
            }
            else
            {
                [self getListRequest];
            }
            break;
        default:
            break;
    }
}

#pragma mark -添加列表视图
- (void)addTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kSegmentedControlHeight+2, kWidth, kHeight-kSegmentedControlHeight-2-kNavigtBarH) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = KLColor(224, 224, 224);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
//    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

//- (void)loadMore
//{
//    if (_segementIndex==0) {
//        [self getListRequestWithPageNo:(++_tenderPageNo) andPageSize:@"20"];
//    }
//    else
//    {
//        [self getListRequestWithPageNo:(++_zaiQuanPageNo) andPageSize:@"20"];
//    }
//}

#pragma mark - tableView dataSource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //判断是否还有数据可以加载
    if (_dataCount == _tabViewMutArray.count) {
        [self.tableView.footer noticeNoMoreData];
    }
    _dataCount = _tabViewMutArray.count;
//    return 10;
    return _tabViewMutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //按情况加载不同的cell
    static NSString *identifier = @"tendCell1";
    static NSString *identifier2 = @"tendCell2";
    
    NSDictionary* style1 = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:14.0],
                             @"bold":[UIFont fontWithName:@"HelveticaNeue-Bold" size:32.0]
                             };
    if (_segementIndex == 0) {
        JiaXiQuanModel *dataModel = _tabViewMutArray[indexPath.row];
        JiaXiQuanCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"JiaXiQuanCell" owner:self options:nil][0];
        }
        //status 0/未使用, 1/转让中, 2/已使用,3/已转让, 4,无效 无效状态需要在页面上根据当前时间和有效期 edate去对比
        if ([dataModel.status integerValue]==1) {
            cell.title.text = [NSString stringWithFormat:@"%@  %@元",dataModel.name,[dataModel.transAmt stringValue]];
        }
        else
        {
            cell.title.text = dataModel.name;
        }
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
        if ([dataModel.status integerValue]!=2) {
            if([self isEndTimeWithEtime:dataModel.edate])
            {
                //过期
                cell.statusLab.text = @"";
                cell.stateBtn1.hidden = YES;
                cell.stateBtn2.hidden = NO;
                cell.stateBtn3.hidden = YES;
                [cell.stateBtn2 setTitle:@"已过期" forState:UIControlStateNormal];
                cell.stateBtn2.enabled = NO;
                //            [cell.stateBtn2 addTarget:self action:@selector(transJXQ:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                switch ([dataModel.status integerValue]) {
                    case 0:
                    {//未使用
                        cell.statusLab.text = @"未使用";
                        cell.stateBtn1.hidden = YES;
                        cell.stateBtn2.hidden = NO;
                        cell.stateBtn3.hidden = YES;
                        [cell.stateBtn2 setTitle:@"转让" forState:UIControlStateNormal];
                        cell.stateBtn2.tag = indexPath.row;
                        [cell.stateBtn2 addTarget:self action:@selector(transJXQ:) forControlEvents:UIControlEventTouchUpInside];
                        break;
                    }
                    case 1:
                    {//转让中
                        NSString *custStr = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
                        if([dataModel.customerId isEqualToString:custStr])
                        {
                            cell.statusLab.text = @"转让中";
                            cell.stateBtn1.hidden = YES;
                            cell.stateBtn2.hidden = NO;
                            cell.stateBtn3.hidden = YES;
                            [cell.stateBtn2 setTitle:@"撤销转让" forState:UIControlStateNormal];
                            cell.stateBtn2.tag = indexPath.row;
                            [cell.stateBtn2 addTarget:self action:@selector(quitTransJXQ:) forControlEvents:UIControlEventTouchUpInside];
                        }
                        else
                        {
                            cell.statusLab.text = @"转让中";
                            cell.stateBtn1.hidden = NO;
                            cell.stateBtn2.hidden = YES;
                            cell.stateBtn3.hidden = NO;
                            [cell.stateBtn1 setTitle:@"付款" forState:UIControlStateNormal];
                            cell.stateBtn1.tag = indexPath.row;
                            [cell.stateBtn1 addTarget:self action:@selector(payJXQ:) forControlEvents:UIControlEventTouchUpInside];
                            [cell.stateBtn3 setTitle:@"取消" forState:UIControlStateNormal];
                            cell.stateBtn3.tag = indexPath.row;
                            [cell.stateBtn3 addTarget:self action:@selector(cancalPayJXQ:) forControlEvents:UIControlEventTouchUpInside];
                        }
                        break;
                    }
                    case 3:
                    {//已转让
                        cell.statusLab.text = @"";
                        cell.stateBtn1.hidden = YES;
                        cell.stateBtn2.hidden = NO;
                        cell.stateBtn3.hidden = YES;
                        [cell.stateBtn2 setTitle:@"已转让" forState:UIControlStateDisabled];
                        cell.stateBtn2.tag = indexPath.row;
                        cell.stateBtn2.enabled = NO;
                        break;
                    }
                    default:
                        break;
                }
            }
        }
        else
        {
            //已使用
            cell.statusLab.text = @"";
            [cell.stateBtn2 setTitle:@"已使用" forState:UIControlStateDisabled];
            cell.stateBtn2.tag = indexPath.row;
            cell.stateBtn2.enabled = NO;
            cell.stateBtn1.hidden = YES;
            cell.stateBtn2.hidden = NO;
            cell.stateBtn3.hidden = YES;
        }
        return cell;
    }
    else
    {
        /*名称 name
      面额 value
      F码 code
      有效期 mdate
      状态 status
      使用条件 limitBal*/
        RedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"RedBagCell" owner:self options:nil][0];
        }
        RedBagModel *dataModel = _tabViewMutArray[indexPath.row];
        cell.nameLab.text = dataModel.name;
        cell.codeLab.text = dataModel.code;
        cell.youXiaoQiLab.text = [dataModel.mdate substringToIndex:10];
//        cell.limitLab.text = dataModel.limitBal;
        NSString *moneyString = [NSString stringWithFormat:@"<bold>%ld</bold> <body>元</body> ",[dataModel.value integerValue]];
        cell.moneyLab.attributedText = [moneyString attributedStringWithStyleBook:style1];
        //状态  status -1 未兑换/0 未激活/1已激活/2已使用
        switch([dataModel.status integerValue]) {
            case -1:
                //
                cell.nameLab.textColor = KLColor(242, 109, 109);
                cell.lineLab.backgroundColor = KLColor(242, 109, 109);
                cell.moneyLab.textColor = KLColor(242, 109, 109);
                cell.statusImgeView.image = [UIImage imageNamed:@"weidh.png"];
                break;
            case 0:
                cell.nameLab.textColor = KLColor(20, 160, 160);
                cell.lineLab.backgroundColor = KLColor(20, 160, 160);
                cell.moneyLab.textColor = KLColor(20, 160, 160);
                cell.statusImgeView.image = [UIImage imageNamed:@"weijh.png"];
                break;
            case 1:
                cell.nameLab.textColor = KLColor(90, 90, 90);
                cell.lineLab.backgroundColor = KLColor(90, 90, 90);
                cell.moneyLab.textColor = KLColor(90, 90, 90);
                cell.statusImgeView.image = [UIImage imageNamed:@"didsy.png"];
                break;
            case 2:
                cell.nameLab.textColor = KLColor(217, 118, 12);
                cell.lineLab.backgroundColor =  KLColor(217, 118, 12);
                cell.moneyLab.textColor = KLColor(217, 118, 12);
                cell.statusImgeView.image = [UIImage imageNamed:@"yijh.png"];
                break;
            default:
                break;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark 转让我的加息券
- (void)transJXQ:(UIButton *)sender
{
    MyLog(@"%ld",sender.tag);
    JiaXiQuanModel *dataModel = _tabViewMutArray[sender.tag];
    TransterJXQViewController *transJXQVC = [[TransterJXQViewController alloc]init];
    transJXQVC.dataModel = dataModel;
    [self.navigationController pushViewController:transJXQVC animated:YES];
}

#pragma mark 撤销转让
- (void)quitTransJXQ:(UIButton *)sender
{
    MyLog(@"%ld",sender.tag);
    JiaXiQuanModel *dataModel = _tabViewMutArray[sender.tag];
    _ordId = dataModel.ordId;
    _kitId = dataModel.kitId;
    _cancelTransAlertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定撤销转让" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [_cancelTransAlertView show];
}

#pragma mark 付款
- (void)payJXQ:(UIButton *)sender
{
    MyLog(@"%ld",sender.tag);
    JiaXiQuanModel *dataModel = _tabViewMutArray[sender.tag];
    _ordId = dataModel.ordId;
    _kitId = dataModel.kitId;
    PayJiaXiQViewController *payVC = [[PayJiaXiQViewController alloc]init];
    payVC.ordId = _ordId;
    [self.navigationController pushViewController:payVC animated:YES];
    //    [self addWebView];
}

#pragma mark 取消付款
- (void)cancalPayJXQ:(UIButton *)sender
{
    MyLog(@"%ld",sender.tag);
    JiaXiQuanModel *dataModel = _tabViewMutArray[sender.tag];
    _ordId = dataModel.ordId;
    _kitId = dataModel.kitId;
    _cancelPayAlertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定取消付款" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [_cancelPayAlertView show];
}

- (void)cancelTransReqest
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:_ordId forKey:@"ordId"];
    [parameter setObject:_kitId forKey:@"kitId"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    //    __weak typeof(self) weakSelf = self;
    [manager POST:kundoTransferKitUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"code"] isEqualToString:@"000"]) {
            [self getListRequest];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
    }];
}

- (void)cancelPayReqest
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:_ordId forKey:@"ordId"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    //    __weak typeof(self) weakSelf = self;
    [manager POST:kkitTransferCancelUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"code"] isEqualToString:@"000"]) {
            [self getListRequest];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
    }];
}

//#pragma mark 加息券付款
//- (void)addWebView
//{
//    [SVProgressHUD showWithStatus:@"努力加载中..."];
//    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
//    _webView.hidden=YES;
//    [self.view addSubview:_webView];
//    _webView.delegate = self;
//    /*用户ID customerId 必填
//     提现金额 transAmt 必填
//     卡号 openAcctId 必填
//     输入抵扣的积分 dikb  非必填
//     备注 remark 非必填
//     返回地址 wxUrl 必填
//     请求类别 reqType 必填
//     */
//    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
//    
//    NSString *url = [NSString stringWithFormat:@"%@&customerId=%@&ordId=%@&reqType=ios",kkitTransferPayUrl,custId,_ordId];
//    
//    //    string = @"http://baidu.com";
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    [_webView loadRequest:request];
//    _webView.hidden = NO;
//    _webView.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:_webView];
//}


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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *biddingId;
//    XiangMuDetailViewController *detialVC = [[XiangMuDetailViewController  alloc]init];
//    if (_segementIndex == 0)
//    {
//        TenderListModel *tenderModel = _tabViewMutArray[indexPath.row];
//        biddingId = tenderModel.biddingId;
//        detialVC.vcFlag = 0;
//    }
//    else
//    {
//        ZaiQuanModel *zaiQuanModel = _tabViewMutArray[indexPath.row];
//        biddingId = zaiQuanModel.ordId;
//        detialVC.vcFlag = 1;
//    }
//    detialVC.biddingId = biddingId;
//    [self.navigationController pushViewController:detialVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_segementIndex==0) {
        return 134;
    }
    else
    {
        return 119;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        if (alertView==_cancelPayAlertView) {
            [self cancelPayReqest];
        }
        if (alertView==_cancelTransAlertView) {
            [self cancelTransReqest];
        }
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

@end
