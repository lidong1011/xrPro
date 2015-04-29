//
//  JiaoYiMXViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/2.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "JiaoYiMXViewController.h"
#import "DZNSegmentedControl.h"
#import "JiaoYiMXCell.h"
#import "ChongZRecordCell.h"
#import "TiXianRecordCell.h"
#import "MJRefresh.h"

#import "TenderBill.h"
#import "ChongZhiRecordMod.h"
#import "QuXianRecord.h"
@interface JiaoYiMXViewController ()<DZNSegmentedControlDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) JiaoYiMXCell *tableViewHeader;
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, assign) NSInteger segementIndex;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tabViewMutArray;
@property (nonatomic, strong) NSMutableArray *tenderMutArray;
@property (nonatomic, assign) int tenderPageNo;
@property (nonatomic, strong) NSMutableArray *chongZMutArray;
@property (nonatomic, assign) int chongZPageNo;
@property (nonatomic, strong) NSMutableArray *quXianMutArray;
@property (nonatomic, assign) int quXianPageNo;

@property (nonatomic, assign) NSInteger dataCount;
@end

#define kSegmentedControlHeight 35
@implementation JiaoYiMXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"交易明细";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initData];
    //初始化试图
    [self initSubview];
    
    //获取数据
    [self getListRequestWithPageNo:1 andPageSize:@"20"];
}

- (void)initData
{
    self.menuItems = @[@"投资记录",@"充值记录",@"提现记录"];
    _tabViewMutArray = [NSMutableArray array];
    _tenderMutArray = [NSMutableArray array];
    _chongZMutArray = [NSMutableArray array];
    _quXianMutArray = [NSMutableArray array];
    _tenderPageNo = 1;
    _chongZPageNo = 1;
    _quXianPageNo = 1;
}

//把视图初始化
- (void)initSubview
{
    [self addSegmentControl];
    
    _tableViewHeader = [[NSBundle mainBundle]loadNibNamed:@"JiaoYiMXCell" owner:self options:nil][0];
    _tableViewHeader.lab1.text = @"交易时间";
    _tableViewHeader.lab2.text = @"金额";
    _tableViewHeader.lab3.text = @"类型";
    _tableViewHeader.lab4.text = @"余额";
    _tableViewHeader.backgroundColor = KLColor(230, 230, 230);
    _tableViewHeader.frame = CGRectMake(0, kWScare(kSegmentedControlHeight)+2, kWidth, kHScare(30));
    [self.view addSubview:_tableViewHeader];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _tableViewHeader.bottom, kWidth, kHeight-_tableViewHeader.bottom-kNavigtBarH-2) style:UITableViewStylePlain];
//    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kWScare(kSegmentedControlHeight)+2, kWidth, kHeight-kWScare(kSegmentedControlHeight)-kNavigtBarH-2) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.tableHeaderView = _tableViewHeader;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
   
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

- (void)loadMore
{
    if (_segementIndex==0) {
        [self getListRequestWithPageNo:(++_tenderPageNo) andPageSize:@"20"];
    }
    else if(_segementIndex == 1)
    {
        [self getListRequestWithPageNo:(++_chongZPageNo) andPageSize:@"20"];
    }
    else
    {
        [self getListRequestWithPageNo:(++_quXianPageNo) andPageSize:@"20"];
    }
}

#pragma mark 添加分段条
- (void)addSegmentControl
{
    // 添加分段条
    DZNSegmentedControl *segmentedControl = [[DZNSegmentedControl alloc] initWithItems:self.menuItems];
    
    segmentedControl.height = kWScare(kSegmentedControlHeight);
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
    //重新设置可以加载更多
    [self.tableView.footer resetNoMoreData];
    MyLog(@"选择了第%ld项",(long)control.selectedSegmentIndex);
    _segementIndex = control.selectedSegmentIndex;
    [_tabViewMutArray removeAllObjects];
    switch (control.selectedSegmentIndex) {
        case 0: // 投资记录
        {
            if (_tenderMutArray.count) {
                _tabViewMutArray = [NSMutableArray arrayWithArray:_tenderMutArray];
            }
            else
            {
                [self getListRequestWithPageNo:_tenderPageNo andPageSize:@"20"];
                [self.tabViewMutArray removeAllObjects];
            }
            break;
        }
        case 1: // 充值记录
        {
            if (_chongZMutArray.count) {
                _tabViewMutArray = [NSMutableArray arrayWithArray:_chongZMutArray];
            }
            else
            {
                [self getListRequestWithPageNo:_chongZPageNo andPageSize:@"20"];
                [self.tabViewMutArray removeAllObjects];
            }
            break;
        }
        case 2: // 取现记录
        {
            if (_quXianMutArray.count) {
                _tabViewMutArray = [NSMutableArray arrayWithArray:_quXianMutArray];
            }
            else
            {
                [self getListRequestWithPageNo:_quXianPageNo andPageSize:@"20"];
                [self.tabViewMutArray removeAllObjects];
            }
            break;
        }
        default:
            break;
    }
    [self.tableView reloadData];
}

#pragma mark - 明细列表请求
- (void)getListRequestWithPageNo:(int)pageNo andPageSize:(NSString *)pageSize
{
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    if(_segementIndex==0)
    {
        //投资记录
        [parameter setObject:@"deal" forKey:@"type"];
    }
    else if(_segementIndex==1)
    {
        //充值记录
        [parameter setObject:@"recharge" forKey:@"type"];
    }
    else
    {
        //取现记录
        [parameter setObject:@"withdraw" forKey:@"type"];
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
    [manager POST:kqueryFundsUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
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
    [self.tableView.footer endRefreshing];
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@"logo_tu.png"] status:@"数据获取成功" maskType:nil];
        if (_segementIndex==0) {
            for (NSDictionary *dataDic in dic[@"data"]) {
                [_tenderMutArray addObject:[TenderBill messageWithDict:dataDic]];
            }
            _tabViewMutArray = [NSMutableArray arrayWithArray:_tenderMutArray];
            MyLog(@"%ld",_tabViewMutArray.count);
        }
        else if(_segementIndex==1)
        {
            for (NSDictionary *dataDic in dic[@"data"]) {
                [_chongZMutArray addObject:[ChongZhiRecordMod messageWithDict:dataDic]];
            }
            _tabViewMutArray = [NSMutableArray arrayWithArray:_chongZMutArray];
             MyLog(@"%ld",_tabViewMutArray.count);
        }
        else
        {
            for (NSDictionary *dataDic in dic[@"data"]) {
                [_quXianMutArray addObject:[QuXianRecord messageWithDict:dataDic]];
            }
            _tabViewMutArray = [NSMutableArray arrayWithArray:_quXianMutArray];
             MyLog(@"%ld",_tabViewMutArray.count);
        }
        [_tableView reloadData];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

#pragma mark - tableView dataSource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_segementIndex == 0) {
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.frame = CGRectMake(0, _tableViewHeader.bottom, kWidth, kHeight-_tableViewHeader.bottom-kNavigtBarH-2);
    }
    else
    {
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.frame = CGRectMake(0, kHScare(kSegmentedControlHeight)+2, kWidth, kHeight-kNavigtBarH-2);
    }
    //判断是否还有数据可以加载
    if (_dataCount == _tabViewMutArray.count) {
        [self.tableView.footer noticeNoMoreData];
    }
    _dataCount = _tabViewMutArray.count;
    MyLog(@"%ld--%ld-%ld-%ld",_dataCount,_tenderMutArray.count,_chongZMutArray.count,_quXianMutArray.count);
    return _tabViewMutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *jYRIdentifier = @"jymxcell";
    static NSString *cZRIdentifier = @"cZEcell";
    static NSString *tXRIdentifier = @"tXRcell";
    if(_segementIndex == 0)
    {
        /*type=deal
         交易时间 ordDate
         交易金额  transAmt
         手续费 fee
         交易类型 settlCode
         可用余额 aftAvlBal
         冻结结算aftFrzBal
         备注 remark
         */
        JiaoYiMXCell *cell = [tableView dequeueReusableCellWithIdentifier:jYRIdentifier];
        if (cell==nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"JiaoYiMXCell" owner:self options:nil][0];
        }
        TenderBill *dataModel = _tabViewMutArray[indexPath.row];
        cell.lab1.text = [dataModel.ordDate substringToIndex:10];
        cell.lab2.text = [dataModel.transAmt stringValue];
        //交易类型 settlCode O支出，A购买本息保障，I收入，F冻结，OW物业费缴纳， IW物业费收取，U解冻
        if ([dataModel.settlCode isEqualToString:@"0"])
        {
            cell.lab3.text = @"支出";
        }
        else if ([dataModel.settlCode isEqualToString:@"A"])
        {
            cell.lab3.text = @"购买本息保障";
        }
        else if ([dataModel.settlCode isEqualToString:@"I"])
        {
            cell.lab3.text = @"收入";
        }
        else if ([dataModel.settlCode isEqualToString:@"F"])
        {
            cell.lab3.text = @"冻结";
        }
        else if ([dataModel.settlCode isEqualToString:@"0W"])
        {
            cell.lab3.text = @"物业费缴纳";
        }
        else if ([dataModel.settlCode isEqualToString:@"Iw"])
        {
            cell.lab3.text = @"物业费收取";
        }
        else
        {
            cell.lab3.text = @"解冻";
        }
        cell.lab4.text = [dataModel.aftAvlBal stringValue];
        return cell;
    }
    else if(_segementIndex == 1)
    {
        ChongZRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cZRIdentifier];
        if (cell==nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"ChongZRecordCell" owner:self options:nil][0];
        }
        /*流水号trxId
         充值时间 ordDate
         充值金额 transAmt
         充值银行 openBankId
         状态 status 1交易成功 2 处理中 其它就是处理失败*/
        ChongZhiRecordMod *dataModel = _tabViewMutArray[indexPath.row];
        cell.liuNumLab.text = dataModel.trxId;
        cell.moneyLab.text = [dataModel.transAmt stringValue];
        cell.czBankLab.text = dataModel.openBankId;
        cell.czTimeLab.text = dataModel.ordDate;
        if ([[dataModel.status stringValue] isEqualToString:@"1"]) {
            cell.stateLab.text = @"交易成功";
        }
        else if([[dataModel.status stringValue] isEqualToString:@"2"])
        {
            cell.stateLab.text = @"处理中";
        }
        else
        {
            cell.stateLab.text = @"处理失败";
        }
        return cell;
        
    }
    else
    {
        TiXianRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:tXRIdentifier];
        if (cell==nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"TiXianRecordCell" owner:self options:nil][0];
        }
        /* 取现时间 ordDate
         取现银行 openBankId
         银行卡号 openAcctId
         到账金额 transAmt
         手续费 servFee
         积分抵扣 dikb
         状态 status 1交易成功 2 处理中 其它就是处理失败
         备注 remark
*/
        QuXianRecord *dataModel = _tabViewMutArray[indexPath.row];
        cell.bankNumLab.text = dataModel.openAcctId;
        cell.moneyLab.text = [dataModel.transAmt stringValue];
        cell.bankNameLab.text = dataModel.openBankId;
        cell.txTimeLab.text = dataModel.ordDate;
        cell.feeLab.text = [dataModel.servFee stringValue];
        cell.jiFenDKLab.text =[NSString stringWithFormat:@"%.2f",[dataModel.dikb floatValue]*10];
        if ([[dataModel.status stringValue] isEqualToString:@"1"]) {
            cell.stateLab.text = @"交易成功";
        }
        else if([[dataModel.status stringValue] isEqualToString:@"2"])
        {
            cell.stateLab.text = @"处理中";
        }
        else
        {
            cell.stateLab.text = @"处理失败";
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_segementIndex == 1) {
        return 100;
    }
    else if(_segementIndex == 2)
    {
        return 112;
    }
    else
    {
        return 44;
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
