//
//  HuiKuanJHViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/21.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "HuiKuanJHViewController.h"
#import "MJRefresh.h"
#import "HuiKuanJHModel.h"

#import "HuiKuanJHCell.h"
@interface HuiKuanJHViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tabViewMutArray;
@property (nonatomic, assign) int huiKuangPageNo;

@property (nonatomic, assign) NSInteger dataCount;
@end

@implementation HuiKuanJHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"回款计划";
    
    [self initData];
    
    [self initSubview];
    
    [self getListRequest];
}

- (void)initData
{
    _tabViewMutArray = [NSMutableArray array];
}

#pragma mark - 回款列表请求
- (void)getListRequest
{
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    [parameter setObject:custId forKey:kCustomerId];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    [manager POST:kqueryPlanHistoryUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:responseObject];
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
//    [self.tableView.footer endRefreshing];
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [SVProgressHUD showSuccessWithStatus:@"成功"];
        for (NSDictionary *dataDic in dic[@"data"]) {
            [_tabViewMutArray addObject:[HuiKuanJHModel messageWithDict:dataDic]];
        }
        [_tableView reloadData];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

#pragma mark -添加列表视图
- (void)initSubview
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 2, kWidth, kHeight-2) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = KLColor(246, 246, 246);
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
//        [self.tableView.footer noticeNoMoreData];
    }
    _dataCount = _tabViewMutArray.count;
    return _tabViewMutArray.count;
//    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
    /*标题 title
    第几标 child
    投资金额 tenderMoney
    本期应收本金 capital
    回款周期 step
    应收利息 interest+additionalInterest
    日期 payDate*/
    static NSString *identifier = @"tendCell1";
    HuiKuanJHCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"HuiKuanJHCell" owner:self options:nil][0];
    }
    HuiKuanJHModel *dataModel = _tabViewMutArray[indexPath.row];
    cell.titleLab.text = [NSString stringWithFormat:@"%@(第%@标)",dataModel.title,[dataModel.child stringValue]];
    cell.tenderMoneyLab.text = [NSString stringWithFormat:@"%@元",[dataModel.tenderMoney stringValue]];
    cell.timeLab.text = [dataModel.payDate substringToIndex:10];
    cell.huiKZQlab.text = [NSString stringWithFormat:@"%@个月",[dataModel.step stringValue]];
    cell.yinShouInvestLab.text = [NSString stringWithFormat:@"%.1f元",[dataModel.additionalInterest floatValue]+[dataModel.interest floatValue]];
    cell.benQiBenJinLab.text = [NSString stringWithFormat:@"%@元",[dataModel.capital stringValue]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *biddingId;
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
    return 91;
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
