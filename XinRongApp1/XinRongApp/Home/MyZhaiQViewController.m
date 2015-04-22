//
//  MyZhaiQViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/18.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "MyZhaiQViewController.h"
#import "MJRefresh.h"

#import "MyZhaiQuanCell.h"

#import "MyZhaiQuanModel.h"
@interface MyZhaiQViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) UISegmentedControl *topSegment;
@property (nonatomic, assign) NSInteger segementIndex;
@property (nonatomic, strong) NSMutableArray *tabViewMutArray;
@property (nonatomic, strong) NSMutableArray *transIngMutArray;
@property (nonatomic, assign) int transIngPageNo;
@property (nonatomic, strong) NSMutableArray *transDidMutArray;
@property (nonatomic, assign) int transDidPageNo;
@property (nonatomic, strong) NSMutableArray *chengJieDidMutArray;
@property (nonatomic, assign) int chengJieDidPageNo;

@property (nonatomic, assign) NSInteger dataCount;
@end

#define kTopSegemH 35

@implementation MyZhaiQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KLColor(246, 246, 246);
    self.navigationItem.title = @"债权转让";
    
    [self initData];
    //初始化试图
    [self initSubview];
    
    [self getListRequestWithPageNo:1 andPageSize:@"20"];
}

//初始数据
- (void)initData
{
    _transDidPageNo = 1;
    _transIngPageNo = 1;
    _chengJieDidPageNo = 1;
    _transIngMutArray = [NSMutableArray array];
    _transDidMutArray = [NSMutableArray array];
    _chengJieDidMutArray = [NSMutableArray array];
}

//把视图初始化
- (void)initSubview
{
    _topSegment = [[UISegmentedControl alloc]initWithItems:@[@"转让中债权",@"已转让债权",@"已承接债权"]];
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
        [self getListRequestWithPageNo:(++_transIngPageNo) andPageSize:@"20"];
    }
    else if(_segementIndex == 1)
    {
        [self getListRequestWithPageNo:(++_transDidPageNo) andPageSize:@"20"];
    }
    else
    {
        [self getListRequestWithPageNo:(++_chengJieDidPageNo) andPageSize:@"20"];
    }
}

#pragma mark - 我的投资请求
- (void)getListRequestWithPageNo:(int)pageNo andPageSize:(NSString *)pageSize
{
    
    /*转让中 customerId必填 statusType=0
     已转让 customerId必填 statusType=2
     已承接 acceptorId必填
     customerId和acceptorId为用户ID*/
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    
    if(_segementIndex==0)
    {
        //all投资
        [parameter setObject:@"0" forKey:@"statusType"];
        [parameter setObject:custId forKey:kCustomerId];
    }
    else if(_segementIndex==1)
    {
        //待回收
        [parameter setObject:@"2" forKey:@"statusType"];
        [parameter setObject:custId forKey:kCustomerId];
    }
    else
    {
        //已回收
        [parameter setObject:@"end" forKey:@"type"];
        [parameter setObject:custId forKey:@"acceptorId"];
    }
    [parameter setObject:@"personalTransfer" forKey:@"type"];
    
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
                [_transIngMutArray addObject:[MyZhaiQuanModel messageWithDict:dataDic]];
            }
            _tabViewMutArray = [NSMutableArray arrayWithArray:_transIngMutArray];
        }
        else if(_segementIndex == 1)
        {
            for (NSDictionary *dataDic in dic[@"data"]) {
                [_transIngMutArray addObject:[MyZhaiQuanModel messageWithDict:dataDic]];
            }
            _tabViewMutArray = [NSMutableArray arrayWithArray:_transIngMutArray];;
        }
        else if(_segementIndex == 1)
        {
            for (NSDictionary *dataDic in dic[@"data"]) {
                [_chengJieDidMutArray addObject:[MyZhaiQuanModel messageWithDict:dataDic]];
            }
            _tabViewMutArray = [NSMutableArray arrayWithArray:_chengJieDidMutArray];;
        }
        
        [_tableView reloadData];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

- (void)didTapSegment:(UISegmentedControl *)sender
{
    _segementIndex = sender.selectedSegmentIndex;
    if (sender.selectedSegmentIndex == 0)
    {
        //全部投资
        [self getListRequestWithPageNo:_transIngPageNo andPageSize:@"20"];
    }
    else if(sender.selectedSegmentIndex == 1)
    {
        [self getListRequestWithPageNo:_transDidPageNo andPageSize:@"20"];
    }
    else
    {
        [self getListRequestWithPageNo:_chengJieDidPageNo andPageSize:@"20"];
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
            MyZhaiQuanCell *cell = [tableView dequeueReusableCellWithIdentifier:all_identifier];
            if (cell==nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"MyZhaiQuanCell" owner:self options:nil][0];
            }
            //添加数据
            MyZhaiQuanModel *dataModel = _tabViewMutArray[indexPath.row];
            cell.titleLab.text = dataModel.title;
            cell.chengjjLab.text = [NSString stringWithFormat:@"%ld元",[dataModel.creditDealAmt integerValue]];
            cell.timeLab.text = [NSString stringWithFormat:@"%@",dataModel.time];
            cell.appCodeLab.text = dataModel.applyCode;
            cell.transBenLab.text = [NSString stringWithFormat:@"%ld元",[dataModel.transAmt integerValue]];
            switch ([dataModel.transStatus integerValue]) {
                    // 0投标中 1等待放款2还款中3废标4已完成
                case 0:
                    cell.stateLab.text = @"可承接";
                    break;
                case 1:
                    cell.stateLab.text = @"转让成功";
                    break;
                default:
                    break;
            }
//            if ([dataModel.tranferAble isEqualToString:@"1"]) {
//                [cell.transBtn setTitle:@"转让" forState:UIControlStateNormal];
//                [cell.transBtn addTarget:self action:@selector(transBtnAct:) forControlEvents:UIControlEventTouchUpInside];
//            }
//            else
//            {
//                [cell.transBtn setTitle:@"不可转让" forState:UIControlStateNormal];
//                [cell.transBtn addTarget:self action:@selector(transBtnAct:) forControlEvents:UIControlEventTouchUpInside];
//            }
            cell.backgroundColor = KLColor(246, 246, 246);
            return cell;
            break;
        }
        case 1:
        {
            //待回收投资的cell
            MyZhaiQuanCell *cell = [tableView dequeueReusableCellWithIdentifier:will_identifier];
            if (cell==nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"MyZhaiQuanCell" owner:self options:nil][0];
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
//            MyIngTenderModel *dataModel = _tabViewMutArray[indexPath.row];
//            cell.infoLab.text = [NSString stringWithFormat:@"%@ 第%@期(第%@标)",dataModel.title,[dataModel.child stringValue],[dataModel.step stringValue]];
//            cell.jieKNameLab.text = dataModel.outCustAccount;
//            NSString *dateString = [dataModel.payDate substringToIndex:10];
//            cell.dateLab.text = dateString;
//            cell.daiSJLba.text = [NSString stringWithFormat:@"%@元",[dataModel.capital stringValue]];
//            cell.daiSLXLab.text = [NSString stringWithFormat:@"%@元",[dataModel.interest stringValue]];
            return cell;
            break;
        }
        case 2:
        {
            //已回收投资的cell
            MyZhaiQuanCell *cell = [tableView dequeueReusableCellWithIdentifier:did_identifier];
            if (cell==nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"MyZhaiQuanCell" owner:self options:nil][0];
            }
            
//            MyEndTenderModel *dataModel = _tabViewMutArray[indexPath.row];
//            cell.infoLab.text = [NSString stringWithFormat:@"%@ 第%@期(第%@标)",dataModel.title,[dataModel.child stringValue],[dataModel.step stringValue]];
//            cell.jieKNameLab.text = dataModel.outCustAccount;
//            NSString *dateString = [dataModel.payDate substringToIndex:10];
//            cell.dateLab.text = dateString;
//            cell.didFJLab.text = [NSString stringWithFormat:@"%@元",[dataModel.capital stringValue]];
//            cell.didGetLX.text = [NSString stringWithFormat:@"%@元",[dataModel.interest stringValue]];
//            cell.geRenFeiLab.text = [NSString stringWithFormat:@"%@元",[dataModel.fee stringValue]];
            return cell;
            break;
        }
        default:
        {
            MyZhaiQuanCell *cell = [tableView dequeueReusableCellWithIdentifier:all_identifier];
            if (cell==nil) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"MyZhaiQuanCell" owner:self options:nil][0];
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
//    TransferViewController *transVC = [[TransferViewController alloc]init];
//    [self.navigationController pushViewController:transVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_topSegment.selectedSegmentIndex == 2)
    {
        return 113;
    }
    return 113;
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
