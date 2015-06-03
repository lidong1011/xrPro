//
//  TransferViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/5/8.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "TransferListViewController.h"

#import "XiangMuDetailViewController.h"
#import "ZhaiQuanTransViewController.h"
#import "LoginViewController.h"

#import "MJRefresh.h"
#import "ZaiQuanCell.h"

//data
#import "ZaiQuanModel.h"
@interface TransferListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tabViewMutArray;
@property (nonatomic, strong) NSMutableArray *zaiQuanMutArray;
@property (nonatomic, assign) int zaiQuanPageNo;

@property (nonatomic, assign) NSInteger dataCount;
@end

@implementation TransferListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"债权转让";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initData];
    
    //添加子视图
    [self initSubview];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //加载数据
    _zaiQuanPageNo = 1;
    [self.tableView.footer resetNoMoreData];
    [_zaiQuanMutArray removeAllObjects];
    [_tabViewMutArray removeAllObjects];
    [self getListRequestWithPageNo:1 andPageSize:@"20"];
}

//init data
- (void)initData
{
    _zaiQuanPageNo = 1;
    _tabViewMutArray = [NSMutableArray array];
    _zaiQuanMutArray = [NSMutableArray array];
}

//添加子视图
- (void)initSubview
{
    //添加列表
    [self addTableView];
}

//ttps://www.xr58.com:8443/xr58/apprequest/request?code=queryTransfer&type=biddingList&pageNo=1&pageSize=100
#pragma mark - 项目列表请求
- (void)getListRequestWithPageNo:(int)pageNo andPageSize:(NSString *)pageSize
{
    //    [SVProgressHUD showImage:[UIImage imageNamed:@"loadData.png"] status:@"加载数据中..."];
    [SVProgressHUD showWithStatus:@"加载数据中..." maskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    //债权
    [parameter setObject:@"transferList" forKey:@"type"];
    
    [parameter setObject:[NSString stringWithFormat:@"%d",pageNo] forKey:@"pageNo"];
    [parameter setObject:pageSize forKey:@"pageSize"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    [manager POST:kqueryTransferUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        [SVProgressHUD showImage:[UIImage imageNamed:@"logo_tu.png"] status:@"加载失败"];
        [_tabViewMutArray removeAllObjects];
        [self.tableView reloadData];
    }];
}

#pragma mark - 请求返回数据
- (void)success:(id)response
{
    //把tableView 清空
    [_tabViewMutArray removeAllObjects];
    //    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    _dataCount = [dic[@"total"] intValue];
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        //        [SVProgressHUD showSuccessWithStatus:@"获取数据成功" ];
        //        [SVProgressHUD showInfoWithStatus:@"" maskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD showImage:[UIImage imageNamed:@"logo_tu.png"] status:@"获取数据成功" maskType:SVProgressHUDMaskTypeGradient];
        for (NSDictionary *dataDic in dic[@"data"]) {
            [_zaiQuanMutArray addObject:[ZaiQuanModel messageWithDict:dataDic]];
        }
        _tabViewMutArray = [NSMutableArray arrayWithArray:_zaiQuanMutArray];;
        [_tableView reloadData];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

#pragma mark -添加列表视图
- (void)addTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-kNavigtBarH) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = KLColor(246, 246, 246);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    [_tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

- (void)refreshData
{
    //加载数据
    _zaiQuanPageNo = 1;
    [self.tableView.footer resetNoMoreData];
    [_zaiQuanMutArray removeAllObjects];
    [_tabViewMutArray removeAllObjects];
    [self getListRequestWithPageNo:1 andPageSize:@"20"];
    [self.tableView reloadData];
}

- (void)loadMore
{
    [self getListRequestWithPageNo:(++_zaiQuanPageNo) andPageSize:@"20"];
}

#pragma mark - tableView dataSource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //判断是否还有数据可以加载
    if (_dataCount == _tabViewMutArray.count) {
        [self.tableView.footer noticeNoMoreData];
    }
    MyLog(@"%ld--%ld",_tabViewMutArray.count,_zaiQuanMutArray.count);
//    _dataCount = _tabViewMutArray.count;
    return _tabViewMutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //按情况加载不同的cell
    static NSString *identifier2 = @"tendCell2";
    /*
      type=transferList
      推荐公司compName
      项目编码applyCode
      项目ID biddingId
      募集金额biddingMoney
      转让本金transAmt
      年化率interestRate
      承接价格creditDealAmt
      还款方式repaymentSort
      剩余周期surplusDays
      转让标的状态transStatus
      
      */
        
    ZaiQuanCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZaiQuanCell" owner:self options:nil][0];
    }
    ZaiQuanModel *dataModel = _tabViewMutArray[indexPath.row];
    cell.statusBtn.tag = indexPath.row;
    [cell.statusBtn addTarget:self action:@selector(zhaiQuanBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    cell.biaoName.text = dataModel.title;
    cell.biaoNumLab.text = dataModel.applyCode;
    cell.shengYuTimeLab.text = [NSString stringWithFormat:@"%d个月",[dataModel.surplusDays intValue]];
    cell.nianRateLab.text = [NSString stringWithFormat:@"%.1f%%",([dataModel.interestRate floatValue]*100)];
    cell.monyeLab.text = [NSString stringWithFormat:@"￥%@",dataModel.dataDic[@"bidding"][@"biddingMoney"]];
    if ([dataModel.repaymentSort isEqualToString:@"0"]) {
        cell.huanKFSLab.text = @"按月等额本息";
    }
    else
    {
        cell.huanKFSLab.text = @"按月付息，到期还本";
    }
    cell.chengJieJiaLab.text = [NSString stringWithFormat:@"%d元",([dataModel.creditDealAmt intValue])];
    cell.zhuangRangJinLab.text = [NSString stringWithFormat:@"%d元",([dataModel.transAmt intValue])];
    //状态
    switch([dataModel.transStatus integerValue]) {
        case 0:
            [cell.statusBtn setTitle:@"可承接" forState:UIControlStateNormal];
            break;
        case 1:
            [cell.statusBtn setTitle:@"等待放款" forState:UIControlStateNormal];
            break;
        case 2:
            [cell.statusBtn setTitle:@"转让成功" forState:UIControlStateNormal];
            cell.statusBtn.enabled = NO;
            cell.statusBtn.enabled = NO;
            break;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - 去转让
- (void)zhaiQuanBtnAct:(UIButton *)sender
{
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    if (custId==nil) {
        [SVProgressHUD showInfoWithStatus:@"还未登录，请先登录"];
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    else
    {
        MyLog(@"%ld",sender.tag);
        ZaiQuanModel *model = _tabViewMutArray[sender.tag];
        ZhaiQuanTransViewController *zhaiQuanVC = [[ZhaiQuanTransViewController alloc]init];
        zhaiQuanVC.ordId = model.ordId;
        zhaiQuanVC.transMoney = model.transAmt;
        zhaiQuanVC.chengJieJin = model.creditDealAmt;
        [self.navigationController pushViewController:zhaiQuanVC animated:YES];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *biddingId;
    XiangMuDetailViewController *detialVC = [[XiangMuDetailViewController  alloc]init];
    ZaiQuanModel *zaiQuanModel = _tabViewMutArray[indexPath.row];
    biddingId = zaiQuanModel.ordId;
    detialVC.vcFlag = 1;

    detialVC.biddingId = biddingId;
    [self.navigationController pushViewController:detialVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 154;
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
