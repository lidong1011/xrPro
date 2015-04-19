//
//  MyTouZiViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/3.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "MyTouZiViewController.h"

#import "AllTouZiCell.h"
#import "MyTouZiCell.h"
#import "DidBackTouZiCell.h"
#import "MJRefresh.h"
#import "TransferViewController.h"
//data
#import "MyAllTender.h"
#import "MyIngTenderModel.h"
#import "MyEndTenderModel.h"
@interface MyTouZiViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) UISegmentedControl *topSegment;
@property (nonatomic, assign) NSInteger segementIndex;
@property (nonatomic, strong) NSMutableArray *tabViewMutArray;
@property (nonatomic, strong) NSMutableArray *allTenderMutArray;
@property (nonatomic, assign) int allTenderPageNo;
@property (nonatomic, strong) NSMutableArray *ingMutArray;
@property (nonatomic, assign) int ingTenderPageNo;
@property (nonatomic, strong) NSMutableArray *endMutArray;
@property (nonatomic, assign) int endTenderPageNo;

@property (nonatomic, assign) NSInteger dataCount;
@end

#define kTopSegemH 35

@implementation MyTouZiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KLColor(246, 246, 246);
    self.navigationItem.title = @"投资项目";
    
    [self initData];
    //初始化试图
    [self initSubview];
    
    [self getListRequestWithPageNo:1 andPageSize:@"20"];
}

//初始数据
- (void)initData
{
    _allTenderPageNo = 1;
    _ingTenderPageNo = 1;
    _endTenderPageNo = 1;
    _allTenderMutArray = [NSMutableArray array];
    _ingMutArray = [NSMutableArray array];
    _endMutArray = [NSMutableArray array];
}

//把视图初始化
- (void)initSubview
{
    _topSegment = [[UISegmentedControl alloc]initWithItems:@[@"全部投资",@"待回收的投资",@"已回收的投资"]];
    _topSegment.frame = CGRectMake(10, kNavigtBarH+10, kWidth-10*2, kTopSegemH);
    _topSegment.tintColor = KLColor(100, 189, 230);
    _topSegment.selectedSegmentIndex = 0;
    [_topSegment addTarget:self action:@selector(didTapSegment:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_topSegment];
    //列表
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _topSegment.bottom+10, kWidth, kHeight-_topSegment.bottom-10) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = KLColor(246, 246, 246);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

- (void)loadMore
{
    if (_segementIndex==0) {
        [self getListRequestWithPageNo:(++_allTenderPageNo) andPageSize:@"20"];
    }
    else if(_segementIndex == 1)
    {
        [self getListRequestWithPageNo:(++_ingTenderPageNo) andPageSize:@"20"];
    }
    else
    {
        [self getListRequestWithPageNo:(++_endTenderPageNo) andPageSize:@"20"];
    }
}

#pragma mark - 我的投资请求
- (void)getListRequestWithPageNo:(int)pageNo andPageSize:(NSString *)pageSize
{
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    if(_segementIndex==0)
    {
        //all投资
        [parameter setObject:@"all" forKey:@"type"];
    }
    else if(_segementIndex==1)
    {
        //待回收
        [parameter setObject:@"ing" forKey:@"type"];
    }
    else
    {
        //已回收
        [parameter setObject:@"end" forKey:@"type"];
    }
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    [parameter setObject:custId forKey:kCustomerId];
    [parameter setObject:[NSString stringWithFormat:@"%d",pageNo] forKey:@"pageNo"];
    [parameter setObject:pageSize forKey:@"pageSize"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    [manager POST:kqueryBiddingUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    [self.tableView.footer endRefreshing];
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        //        [SVProgressHUD showSuccessWithStatus:@"成功"];
        if (_segementIndex==0) {
            for (NSDictionary *dataDic in dic[@"data"]) {
                [_allTenderMutArray addObject:[MyAllTender messageWithDict:dataDic]];
            }
            _tabViewMutArray = [NSMutableArray arrayWithArray:_allTenderMutArray];
        }
        else if(_segementIndex == 1)
        {
            for (NSDictionary *dataDic in dic[@"data"]) {
                [_ingMutArray addObject:[MyIngTenderModel messageWithDict:dataDic]];
            }
            _tabViewMutArray = [NSMutableArray arrayWithArray:_ingMutArray];;
        }
        else if(_segementIndex == 1)
        {
            for (NSDictionary *dataDic in dic[@"data"]) {
                [_endMutArray addObject:[MyEndTenderModel messageWithDict:dataDic]];
            }
            _tabViewMutArray = [NSMutableArray arrayWithArray:_endMutArray];;
        }

        [_tableView reloadData];
    }
    else
    {
        //        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

- (void)didTapSegment:(UISegmentedControl *)sender
{
    _segementIndex = sender.selectedSegmentIndex;
    if (sender.selectedSegmentIndex == 0)
    {
        //全部投资
        [self getListRequestWithPageNo:_allTenderPageNo andPageSize:@"20"];
    }
    else if(sender.selectedSegmentIndex == 1)
    {
        [self getListRequestWithPageNo:_ingTenderPageNo andPageSize:@"20"];
    }
    else
    {
        [self getListRequestWithPageNo:_endTenderPageNo andPageSize:@"20"];
    }
    [self.tabViewMutArray removeAllObjects];
    [self.tableView reloadData];
    MyLog(@"%ld",sender.selectedSegmentIndex);
}

#pragma mark 列表数据代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MyLog(@"%ld",_tabViewMutArray.count);
    
    //判断是否还有数据可以加载
    if (_dataCount == _tabViewMutArray.count) {
        [self.tableView.footer noticeNoMoreData];
    }
    _dataCount = _tabViewMutArray.count;
    
    return _tabViewMutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *all_identifier = @"all_cell";
    static NSString *will_identifier = @"will_cell";
    static NSString *did_identifier = @"did_cell";
    switch (_topSegment.selectedSegmentIndex) {
        case 0:
        {
            //全部投资的cell
            AllTouZiCell *cell = [tableView dequeueReusableCellWithIdentifier:all_identifier];
            if (cell==nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"AllTouZiCell" owner:self options:nil][0];
            }
            //添加数据
            MyAllTender *dataModel = _tabViewMutArray[indexPath.row];
            cell.info.text = dataModel.info;
            cell.tenderMoneyLab.text = [NSString stringWithFormat:@"%ld元",[dataModel.tenderMoney integerValue]];
            cell.willProfitLab.text = [NSString stringWithFormat:@"%ld元",[dataModel.income integerValue]];
            cell.didTransMoneyLab.text = [NSString stringWithFormat:@"%@元",dataModel.restCap];
            switch ([dataModel.status integerValue]) {
                    // 0投标中 1等待放款2还款中3废标4已完成
                case 0:
                    cell.statusLab.text = @"投标中";
                    break;
                case 1:
                    cell.statusLab.text = @"等待放款";
                    break;
                case 2:
                    cell.statusLab.text = @"还款中";
                    break;
                case 3:
                    cell.statusLab.text = @"废标";
                    break;
                case 4:
                    cell.statusLab.text = @"已完成";
                    break;
                default:
                    break;
            }
            if ([dataModel.tranferAble isEqualToString:@"1"]) {
                [cell.transBtn setTitle:@"转让" forState:UIControlStateNormal];
                [cell.transBtn addTarget:self action:@selector(transBtnAct:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                [cell.transBtn setTitle:@"不可转让" forState:UIControlStateNormal];
                [cell.transBtn addTarget:self action:@selector(transBtnAct:) forControlEvents:UIControlEventTouchUpInside];
            }
            cell.backgroundColor = KLColor(246, 246, 246);
            return cell;
            break;
        }
        case 1:
        {
            //待回收投资的cell
            MyTouZiCell *cell = [tableView dequeueReusableCellWithIdentifier:will_identifier];
            if (cell==nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"MyTouZiCell" owner:self options:nil][0];
            }
            
            //添加数据
            /*还款日期 payDate
            项目名称 | 周期 '第'+data.child+'标 | 第 '+data.repayment.step+'期'
            借款人 outCustAccount
            逾期天数 late
            待收利息 interest
            待收本金 capital
            罚息 lateInt
            */
            MyIngTenderModel *dataModel = _tabViewMutArray[indexPath.row];
            cell.infoLab.text = [NSString stringWithFormat:@"%@ 第%@期(第%@标)",dataModel.title,[dataModel.child stringValue],[dataModel.step stringValue]];
            cell.jieKNameLab.text = dataModel.outCustAccount;
            NSString *dateString = [dataModel.payDate substringToIndex:10];
            cell.dateLab.text = dateString;
            cell.daiSJLba.text = [NSString stringWithFormat:@"%@元",[dataModel.capital stringValue]];
            cell.daiSLXLab.text = [NSString stringWithFormat:@"%@元",[dataModel.interest stringValue]];
            return cell;
            break;
        }
        case 2:
        {
            //已回收投资的cell
            DidBackTouZiCell *cell = [tableView dequeueReusableCellWithIdentifier:did_identifier];
            if (cell==nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"DidBackTouZiCell" owner:self options:nil][0];
            }
            
            MyEndTenderModel *dataModel = _tabViewMutArray[indexPath.row];
            cell.infoLab.text = [NSString stringWithFormat:@"%@ 第%@期(第%@标)",dataModel.title,[dataModel.child stringValue],[dataModel.step stringValue]];
            cell.jieKNameLab.text = dataModel.outCustAccount;
            NSString *dateString = [dataModel.payDate substringToIndex:10];
            cell.dateLab.text = dateString;
            cell.didFJLab.text = [NSString stringWithFormat:@"%@元",[dataModel.capital stringValue]];
            cell.didGetLX.text = [NSString stringWithFormat:@"%@元",[dataModel.interest stringValue]];
            cell.geRenFeiLab.text = [NSString stringWithFormat:@"%@元",[dataModel.fee stringValue]];
            return cell;
            break;
        }
        default:
        {
            MyTouZiCell *cell = [tableView dequeueReusableCellWithIdentifier:all_identifier];
            if (cell==nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"MyTouZiCell" owner:self options:nil][0];
            }
            return cell;
            break;
        }
    }
}

#pragma mark - 转让操作
- (void)transBtnAct:(UIButton *)sender
{
    //
    TransferViewController *transVC = [[TransferViewController alloc]init];
    [self.navigationController pushViewController:transVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_topSegment.selectedSegmentIndex == 2)
    {
        return 110;
    }
    return 91;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
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
