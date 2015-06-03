//
//  TenderViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/3/19.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "TenderViewController.h"

#import "XiangMuDetailViewController.h"
#import "BeginTenderViewController.h"
#import "LoginViewController.h"

#import "MJRefresh.h"
#import "TenderCell.h"
//#import "ZaiQuanCell.h"

//data
#import "TenderListModel.h"
//#import "ZaiQuanModel.h"
@interface TenderViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tabViewMutArray;
@property (nonatomic, strong) NSMutableArray *tenderMutArray;
@property (nonatomic, assign) int tenderPageNo;

@property (nonatomic, assign) NSInteger dataCount;
@end

@implementation TenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"投资项目";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initData];
    
    //添加子视图
    [self initSubview];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //加载数据
    _tenderPageNo = 1;
    [self.tableView.footer resetNoMoreData];
    [_tenderMutArray removeAllObjects];
    [_tabViewMutArray removeAllObjects];
    [_tableView reloadData];
    [self getListRequestWithPageNo:1 andPageSize:@"20"];
}

//init data
- (void)initData
{
    _tenderPageNo = 1;
    _tabViewMutArray = [NSMutableArray array];
    _tenderMutArray = [NSMutableArray array];
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
    //投资
    [parameter setObject:@"biddingList" forKey:@"type"];
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
    //总共的数据条数
    _dataCount = [dic[@"total"] intValue];
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
    if ([dic[@"code"] isEqualToString:@"000"])
    {
//        [SVProgressHUD showSuccessWithStatus:@"获取数据成功" ];
//        [SVProgressHUD showInfoWithStatus:@"" maskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD showImage:[UIImage imageNamed:@"logo_tu.png"] status:@"获取数据成功" maskType:SVProgressHUDMaskTypeGradient];
        for (NSDictionary *dataDic in dic[@"data"])
        {
                [_tenderMutArray addObject:[TenderListModel messageWithDict:dataDic]];
        }
        _tabViewMutArray = [NSMutableArray arrayWithArray:_tenderMutArray];
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
    _tenderPageNo = 1;
    [self.tableView.footer resetNoMoreData];
    [_tenderMutArray removeAllObjects];
    [_tabViewMutArray removeAllObjects];
    [self getListRequestWithPageNo:1 andPageSize:@"20"];
    [self.tableView reloadData];
}

- (void)loadMore
{
    [self getListRequestWithPageNo:(++_tenderPageNo) andPageSize:@"20"];
}

#pragma mark - tableView dataSource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //判断是否还有数据可以加载
    if (_dataCount == _tabViewMutArray.count) {
        [self.tableView.footer noticeNoMoreData];
    }
//    _dataCount = _tabViewMutArray.count;
    return _tabViewMutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //按情况加载不同的cell
    static NSString *identifier = @"tendCell1";
    TenderListModel *dataModel = _tabViewMutArray[indexPath.row];
    TenderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TenderCell" owner:self options:nil][0];
    }
    cell.touBiaoBtn.tag = indexPath.row;
    [cell.touBiaoBtn addTarget:self action:@selector(touBiaoBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.biaoName.text = dataModel.title;
    cell.bianNum.text = dataModel.applyCode;
    cell.huiKuangQiLab.text = [NSString stringWithFormat:@"%@个月",[dataModel.timeLimit stringValue]];
    cell.nianRateLab.text = [NSString stringWithFormat:@"%.1f%%",([dataModel.interestRate floatValue]*100)];
    cell.monyeLab.text = [NSString stringWithFormat:@"￥%@",[dataModel.biddingMoney stringValue]];
//        cell.progress.progress = [dataModel.process floatValue]/100;
    
    cell.myProcess.color = kZhuTiColor;
    cell.myProcess.showText = @NO;
    cell.myProcess.animate = @0;
    cell.myProcess.progress = [dataModel.process floatValue]/100;
    cell.myProcess.borderRadius = @5;
//        cell.myProcess.type = LDProgressSolid;
    cell.progressNum.text = [NSString stringWithFormat:@"%d%%",(int)([dataModel.process intValue])];
    //状态
    switch([dataModel.biddingStatus integerValue]) {
        case 0:
            [cell.rightStatusImgView setImage:[UIImage imageNamed:@"tuoBiaoZ.png"]];
            [cell.touBiaoBtn setTitle:@"立即投标" forState:UIControlStateNormal];
            [cell.leftBianImgView setImage:[UIImage imageWithName:@"lan_left_bian.png"]];
            break;
        case 1:
            [cell.rightStatusImgView setImage:[UIImage imageNamed:@"manBiao.png"]];
            [cell.touBiaoBtn setTitle:@"回款中" forState:UIControlStateNormal];
            [cell.leftBianImgView setImage:[UIImage imageWithName:@"hui_left.9.png"]];
//                [cell.touBiaoBtn setEnabled:NO];
            cell.touBiaoBtn.enabled = NO;
            break;
        case 2:
            [cell.rightStatusImgView setImage:[UIImage imageNamed:@"huiKZ.png"]];
            [cell.touBiaoBtn setTitle:@"回款中" forState:UIControlStateNormal];
            [cell.leftBianImgView setImage:[UIImage imageWithName:@"hui_left.9.png"]];
            [cell.touBiaoBtn setEnabled:NO];
            break;
        case 4:
            [cell.rightStatusImgView setImage:[UIImage imageNamed:@"huiKCG.png"]];
            [cell.touBiaoBtn setTitle:@"回款成功" forState:UIControlStateNormal];
            [cell.leftBianImgView setImage:[UIImage imageWithName:@"hui_left.9.png"]];
            [cell.touBiaoBtn setEnabled:NO];
            break;
        default:
            [cell.rightStatusImgView setImage:[UIImage imageNamed:@"tuoBiaoZ.png"]];
            [cell.touBiaoBtn setTitle:@"立即投标" forState:UIControlStateNormal];
            [cell.leftBianImgView setImage:[UIImage imageWithName:@"lan_left_bian.png"]];
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - 去投标
- (void)touBiaoBtnAct:(UIButton *)sender
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
        TenderListModel *model = _tabViewMutArray[sender.tag];
        BeginTenderViewController *touBiaoVC = [[BeginTenderViewController alloc]init];
        touBiaoVC.biddingId = model.biddingId;
        touBiaoVC.keTouMoney = [model.biddingMoney intValue]-[model.totalTender intValue];
//        touBiaoVC.keTouMoney = [model.biddingMoney integerValue]-[model.totalTenders integerValue];
        [self.navigationController pushViewController:touBiaoVC animated:YES];
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *biddingId;
    XiangMuDetailViewController *detialVC = [[XiangMuDetailViewController  alloc]init];
    detialVC.vcFlag = 0;
    TenderListModel *tenderModel = _tabViewMutArray[indexPath.row];
    biddingId = tenderModel.biddingId;
    detialVC.biddingId = biddingId;
    [self.navigationController pushViewController:detialVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 146;
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
