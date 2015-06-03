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

@property (nonatomic, assign) NSInteger dataCount_ing;
@property (nonatomic, assign) NSInteger dataCount_did;
@property (nonatomic, assign) NSInteger dataCount_didcj;
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
    [_tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(refresData)];
}

- (void)refresData
{
    _transDidPageNo = 1;
    _transIngPageNo = 1;
    _chengJieDidPageNo = 1;
    [_transDidMutArray removeAllObjects];
    [_transIngMutArray removeAllObjects];
    [_chengJieDidMutArray removeAllObjects];
    [_tabViewMutArray removeAllObjects];
    [self getListRequestWithPageNo:1 andPageSize:@"20"];
    [_tableView.footer resetNoMoreData];
    [_tableView reloadData];
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
    [SVProgressHUD showImage:[UIImage imageNamed:@"logo_tu.png"] status:@"加载数据中..." maskType:SVProgressHUDMaskTypeGradient];
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
        //已承接
//        [parameter setObject:@"end" forKey:@"type"];
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
        [SVProgressHUD dismiss];
        [_tabViewMutArray removeAllObjects];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        [self.tableView reloadData];
    }];
}

#pragma mark - 请求返回数据
- (void)success:(id)response
{
    //把tableView 清空
    [_tabViewMutArray removeAllObjects];
    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@"logo_tu.png"] status:@"数据获取成功" maskType:SVProgressHUDMaskTypeGradient];
        if (_segementIndex==0) {
            for (NSDictionary *dataDic in dic[@"data"]) {
                [_transIngMutArray addObject:[MyZhaiQuanModel messageWithDict:dataDic]];
            }
            _dataCount_ing = [dic[@"total"] intValue];
            _tabViewMutArray = [NSMutableArray arrayWithArray:_transIngMutArray];
        }
        else if(_segementIndex == 1)
        {
            for (NSDictionary *dataDic in dic[@"data"]) {
                [_transDidMutArray addObject:[MyZhaiQuanModel messageWithDict:dataDic]];
            }
            _dataCount_did = [dic[@"total"] intValue];
            _tabViewMutArray = [NSMutableArray arrayWithArray:_transDidMutArray];;
        }
        else if(_segementIndex == 2)
        {
            for (NSDictionary *dataDic in dic[@"data"]) {
                [_chengJieDidMutArray addObject:[MyZhaiQuanModel messageWithDict:dataDic]];
            }
            _dataCount_didcj = [dic[@"total"] intValue];
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
    [self.tableView.footer resetNoMoreData];
    
    _segementIndex = sender.selectedSegmentIndex;
    if (sender.selectedSegmentIndex == 0)
    {
        //转让中债权
        if(_transIngMutArray.count)
        {
            _tabViewMutArray = [NSMutableArray arrayWithArray:_transIngMutArray];
            [self.tableView reloadData];
        }
        else
        {
            [self getListRequestWithPageNo:_transIngPageNo andPageSize:@"20"];
            [_tabViewMutArray removeAllObjects];
            [self.tableView reloadData];
        }
        
    }
    else if(sender.selectedSegmentIndex == 1)
    {
        //已转让债权
        if(_transDidMutArray.count)
        {
            _tabViewMutArray = [NSMutableArray arrayWithArray:_transDidMutArray];
            [self.tableView reloadData];
        }
        else
        {
            [self getListRequestWithPageNo:_transDidPageNo andPageSize:@"20"];
            [_tabViewMutArray removeAllObjects];
            [self.tableView reloadData];
        }
    }
    else
    {
        //已承接债权
        if(_chengJieDidMutArray.count)
        {
            _tabViewMutArray = [NSMutableArray arrayWithArray:_chengJieDidMutArray];
            [self.tableView reloadData];
        }
        else
        {
            [self getListRequestWithPageNo:_chengJieDidPageNo andPageSize:@"20"];
            [_tabViewMutArray removeAllObjects];
            [self.tableView reloadData];
        }
    }
//    [self.tabViewMutArray removeAllObjects];
//    [self.tableView reloadData];
    MyLog(@"%ld",sender.selectedSegmentIndex);
}

#pragma mark 列表数据代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MyLog(@"%ld",_tabViewMutArray.count);
    
    //判断是否还有数据可以加载
    //判断是否还有数据可以加载
    if (_segementIndex==0)
    {
        if (_dataCount_ing == _tabViewMutArray.count) {
            [self.tableView.footer noticeNoMoreData];
        }
        else
        {
            [self.tableView.footer resetNoMoreData];
        }
    }
    else if(_segementIndex==1)
    {
        if (_dataCount_did == _tabViewMutArray.count) {
            [self.tableView.footer noticeNoMoreData];
        }
        else
        {
            [self.tableView.footer resetNoMoreData];
        }
    }
    else
    {
        if (_dataCount_didcj == _tabViewMutArray.count) {
            [self.tableView.footer noticeNoMoreData];
        }
        else
        {
            [self.tableView.footer resetNoMoreData];
        }
    }
    MyLog(@"%ld--%ld--%ld--%ld",_tabViewMutArray.count,_transIngMutArray.count,_transDidMutArray.count,_chengJieDidMutArray.count);
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
            cell.chengjjLab.text = [NSString stringWithFormat:@"￥%ld",[dataModel.creditDealAmt integerValue]];
            cell.faBuTime.text = [dataModel.ordDate substringToIndex:10];
            cell.chengjieLabN.hidden = YES;
            cell.appCodeLab.text = dataModel.applyCode;
            cell.shengYTime.text = [NSString stringWithFormat:@"%ld个月",[dataModel.transStep integerValue]];
            cell.transBenLab.text = [NSString stringWithFormat:@"￥%ld",[dataModel.transAmt integerValue]];
            switch ([dataModel.transStatus integerValue]) {
                    // 0投标中 1等待放款2还款中3废标4已完成
                case 0:
                    cell.stateLab.text = @"可承接";
                    break;
                case 2:
                    cell.stateLab.text = @"转让成功";
                    break;
                default:
                    break;
            }
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
            MyZhaiQuanModel *dataModel = _tabViewMutArray[indexPath.row];
            cell.titleLab.text = dataModel.title;
            cell.chengjjLab.text = [NSString stringWithFormat:@"￥%ld",[dataModel.creditDealAmt integerValue]];
            cell.chengjieLabN.hidden = NO;
            cell.timeLab.text = [dataModel.buyDate substringToIndex:10];
            cell.faBuTime.text = [dataModel.ordDate substringToIndex:10];
            cell.appCodeLab.text = dataModel.applyCode;
            cell.shengYTime.text = [NSString stringWithFormat:@"%ld个月",[dataModel.transStep integerValue]];
            cell.transBenLab.text = [NSString stringWithFormat:@"￥%ld",[dataModel.transAmt integerValue]];
            switch ([dataModel.transStatus integerValue]) {
                    //
                case 0:
                    cell.stateLab.text = @"可承接";
                    break;
                case 2:
                    cell.stateLab.text = @"转让成功";
                    break;
                default:
                    break;
            }
            cell.backgroundColor = KLColor(246, 246, 246);
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
            //添加数据
            MyZhaiQuanModel *dataModel = _tabViewMutArray[indexPath.row];
            cell.titleLab.text = dataModel.title;
            cell.chengjjLab.text = [NSString stringWithFormat:@"￥%ld",[dataModel.creditDealAmt integerValue]];
            cell.timeLab.text = [dataModel.buyDate substringToIndex:10];
            cell.faBuTime.text = [dataModel.ordDate substringToIndex:10];
            cell.chengjieLabN.hidden = NO;
            cell.appCodeLab.text = dataModel.applyCode;
            cell.shengYTime.text = [NSString stringWithFormat:@"%ld个月",[dataModel.transStep integerValue]];
            cell.transBenLab.text = [NSString stringWithFormat:@"￥%ld",[dataModel.transAmt integerValue]];
            switch ([dataModel.transStatus integerValue]) {
                    // 0投标中 1等待放款2还款中3废标4已完成
                case 0:
                    cell.stateLab.text = @"可承接";
                    break;
                case 2:
                    cell.stateLab.text = @"转让成功";
                    break;
                default:
                    break;
            }
            cell.backgroundColor = KLColor(246, 246, 246);
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
