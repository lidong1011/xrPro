//
//  TenderViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/3/19.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "TenderViewController.h"

#import "XiangMuDetailViewController.h"
#import "ActivityViewController.h"
#import "WuYeBiaoViewController.h"
#import "MyAccoutViewController.h"
#import "BeginTenderViewController.h"
#import "ZhaiQuanTransViewController.h"
#import "LoginViewController.h"

#import "MJRefresh.h"
#import "menuView.h"
#import "KLCoverView.h"
#import "DZNSegmentedControl.h"
#import "TenderCell.h"
#import "ZaiQuanCell.h"

//data
#import "TenderListModel.h"
#import "ZaiQuanModel.h"
@interface TenderViewController ()<DZNSegmentedControlDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, assign) NSInteger segementIndex;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tabViewMutArray;
@property (nonatomic, strong) NSMutableArray *tenderMutArray;
@property (nonatomic, assign) int tenderPageNo;
@property (nonatomic, strong) NSMutableArray *zaiQuanMutArray;
@property (nonatomic, assign) int zaiQuanPageNo;
//菜单
@property (nonatomic, strong) KLCoverView *coverView;
@property (nonatomic, strong) MenuView *menuView;
@property (nonatomic, assign) BOOL menuShowFlag;  //记录菜单的是处在的状态

@property (nonatomic, assign) NSInteger dataCount;
@end

#define kSegmentedControlHeight 40

@implementation TenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"投标";
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
    _zaiQuanPageNo = 1;
    [self.tableView.footer resetNoMoreData];
    [_zaiQuanMutArray removeAllObjects];
    [_tenderMutArray removeAllObjects];
    [_tabViewMutArray removeAllObjects];
    [self getListRequestWithPageNo:1 andPageSize:@"20"];
}

//init data
- (void)initData
{
    _menuItems = @[@"投标项目",@"债权转让"];
    _tenderPageNo = 1;
    _zaiQuanPageNo = 1;
    _tabViewMutArray = [NSMutableArray array];
    _tenderMutArray = [NSMutableArray array];
    _zaiQuanMutArray = [NSMutableArray array];
}

//添加子视图
- (void)initSubview
{
    //菜单按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 100, 31, 31);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    //    [leftBtn setTitle:@"菜单" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(menuList:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 100, 31, 31);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"person.png"] forState:UIControlStateNormal];
    //    [rightBtn setTitle:@"个人" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(person) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    

    //添加分段条
    [self addSegmentControl];
    
    //添加列表
    [self addTableView];
}

//ttps://www.xr58.com:8443/xr58/apprequest/request?code=queryTransfer&type=biddingList&pageNo=1&pageSize=100
#pragma mark - 项目列表请求
- (void)getListRequestWithPageNo:(int)pageNo andPageSize:(NSString *)pageSize
{
//    [SVProgressHUD showImage:[UIImage imageNamed:@"loadData.png"] status:@"加载数据中..."];
    [SVProgressHUD showWithStatus:@"加载数据中..."];
//    [SVProgressHUD showImage:[UIImage imageWithName:@"1.png"] status:@"fdfdsffs"];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    if(_segementIndex==0)
    {
        //投资
        [parameter setObject:@"biddingList" forKey:@"type"];
    }
    else
    {
        //债权
        [parameter setObject:@"transferList" forKey:@"type"];
    }
    
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
    [self.tableView.footer endRefreshing];
    if ([dic[@"code"] isEqualToString:@"000"])
    {
//        [SVProgressHUD showSuccessWithStatus:@"获取数据成功" ];
//        [SVProgressHUD showInfoWithStatus:@"" maskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD showImage:[UIImage imageNamed:@"logo_tu.png"] status:@"获取数据成功" maskType:SVProgressHUDMaskTypeGradient];
        if (_segementIndex==0) {
            for (NSDictionary *dataDic in dic[@"data"]) {
                [_tenderMutArray addObject:[TenderListModel messageWithDict:dataDic]];
            }
            _tabViewMutArray = [NSMutableArray arrayWithArray:_tenderMutArray];
        }
        else
        {
            for (NSDictionary *dataDic in dic[@"data"]) {
                [_zaiQuanMutArray addObject:[ZaiQuanModel messageWithDict:dataDic]];
            }
            _tabViewMutArray = [NSMutableArray arrayWithArray:_zaiQuanMutArray];;
        }
        [_tableView reloadData];
    }
    else
    {
//        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

//显示菜单栏
- (void)menuList:(UIButton *)sender
{
    _menuShowFlag = !_menuShowFlag;
    if (_menuShowFlag) {
        [self addMenuView];
    }
    else
    {
        [self hideMenuView];
    }
}

//显示菜单栏
- (void)addMenuView
{
    //遮盖层
    _coverView = [KLCoverView coverWithTarget:self action:@selector(hideMenuView)];
    _coverView.frame = CGRectMake(0, 0, kWidth, kHeight-kNavigtBarH);
    [self.view addSubview:_coverView];
    _menuView = [MenuView createView];
    _menuView.frame = CGRectMake(0, -kWidth/2*3/4, kWidth, kWidth/2*3/4);
    _menuView.alpha = 0.5;
    __block MenuView *blockMenu = _menuView;
    [UIView animateWithDuration:0.35 animations:^{
        blockMenu.frame = CGRectMake(0, 0, kWidth, kWidth/2*3/4);
        blockMenu.alpha = 1;
    } completion:nil];
    
    [_menuView.activityBtn addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_menuView.wuYeBtn addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_menuView];
}

- (void)menuBtnAction:(UIButton *)sender
{
    [self hideMenuView];
    
    if (sender.tag == 0)
    {
        //进入活动页
        ActivityViewController *activityVC = [[ActivityViewController alloc]init];
        [self.navigationController pushViewController:activityVC animated:YES];
    }
    else
    {
        //物业宝
        WuYeBiaoViewController *wuYeBiaoVC = [[WuYeBiaoViewController alloc]init];
        [self.navigationController pushViewController:wuYeBiaoVC animated:YES];
    }
}

- (void)hideMenuView
{
    _menuShowFlag = NO;
    [_coverView removeFromSuperview];
    [_menuView removeFromSuperview];
}

//进入个人账号
- (void)person
{
    MyAccoutViewController *myAccoutVC = [[MyAccoutViewController alloc]init];
    [self.navigationController pushViewController:myAccoutVC animated:YES];
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
    MyLog(@"选择了第%ld项",(long)control.selectedSegmentIndex);
    
    _segementIndex = control.selectedSegmentIndex;
    [_tabViewMutArray removeAllObjects];
    // 设置导航条标题
//    self.navigationItem.title = self.menuItems[control.selectedSegmentIndex];
    
    switch (control.selectedSegmentIndex) {
        case 0: // 投资项目
            if (_tenderMutArray.count==0) {
                [self getListRequestWithPageNo:_tenderPageNo andPageSize:@"20"];
            }
            else
            {
                _tabViewMutArray = [NSMutableArray arrayWithArray:_tenderMutArray];
            }
            break;
        case 1: // 债权转让
            if (_zaiQuanMutArray.count==0) {
                [self getListRequestWithPageNo:_zaiQuanPageNo andPageSize:@"20"];
            }
            else
            {
                _tabViewMutArray = [NSMutableArray arrayWithArray:_zaiQuanMutArray];
            }
            break;
        default:
            break;
    }
    [self.tableView reloadData];
    MyLog(@"%ld--%ld--%ld",_tabViewMutArray.count,_tenderMutArray.count,_zaiQuanMutArray.count);
}

#pragma mark -添加列表视图
- (void)addTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kWScare(kSegmentedControlHeight)+2, kWidth, kHeight-kWScare(kSegmentedControlHeight)-2-kNavigtBarH-49) style:UITableViewStylePlain];
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
        [self getListRequestWithPageNo:(++_tenderPageNo) andPageSize:@"20"];
    }
    else
    {
        [self getListRequestWithPageNo:(++_zaiQuanPageNo) andPageSize:@"20"];
    }
}

#pragma mark - tableView dataSource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //判断是否还有数据可以加载
    if (_dataCount == _tabViewMutArray.count) {
        [self.tableView.footer noticeNoMoreData];
    }
    MyLog(@"%ld--%ld--%ld",_tabViewMutArray.count,_tenderMutArray.count,_zaiQuanMutArray.count);
    _dataCount = _tabViewMutArray.count;
    return _tabViewMutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //按情况加载不同的cell
    static NSString *identifier = @"tendCell1";
    static NSString *identifier2 = @"tendCell2";
    if (_segementIndex == 0) {
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
        cell.monyeLab.text = [NSString stringWithFormat:@"%@元",[dataModel.biddingMoney stringValue]];
//        cell.progress.progress = [dataModel.process floatValue]/100;
        
        cell.myProcess.color = kZhuTiColor;
        cell.myProcess.progress = [dataModel.process floatValue]/100;
        cell.myProcess.showText = @NO;
        cell.myProcess.borderRadius = @5;
        cell.myProcess.animate = @NO;
//        cell.myProcess.type = LDProgressSolid;
        cell.progressNum.text = [NSString stringWithFormat:@"%d%%",(int)([dataModel.process intValue])];
        //状态
        switch([dataModel.biddingStatus integerValue]) {
            case 0:
                [cell.rightStatusImgView setImage:[UIImage imageNamed:@"tuoBiaoZ.png"]];
                [cell.touBiaoBtn setTitle:@"立即投标" forState:UIControlStateNormal];
                break;
            case 1:
                [cell.rightStatusImgView setImage:[UIImage imageNamed:@"manBiao.png"]];
                [cell.touBiaoBtn setTitle:@"回款中" forState:UIControlStateNormal];
//                [cell.touBiaoBtn setEnabled:NO];
                cell.touBiaoBtn.enabled = NO;
                break;
            case 2:
                [cell.rightStatusImgView setImage:[UIImage imageNamed:@"huiKZ.png"]];
                [cell.touBiaoBtn setTitle:@"回款中" forState:UIControlStateNormal];
                [cell.touBiaoBtn setEnabled:NO];
                break;
            case 3:
                [cell.rightStatusImgView setImage:[UIImage imageNamed:@"huiKCG.png"]];
                [cell.touBiaoBtn setTitle:@"回款成功" forState:UIControlStateNormal];
                [cell.touBiaoBtn setEnabled:NO];
                break;

            default:
                break;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {/*
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
        cell.monyeLab.text = [NSString stringWithFormat:@"%@元",dataModel.dataDic[@"bidding"][@"biddingMoney"]];
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
        touBiaoVC.keTouMoney = [model.biddingMoney intValue]-[model.totalTenders intValue];
        touBiaoVC.keTouMoney = [model.biddingMoney integerValue]-[model.totalTenders integerValue];
        [self.navigationController pushViewController:touBiaoVC animated:YES];
    }

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
    if (_segementIndex == 0)
    {
        TenderListModel *tenderModel = _tabViewMutArray[indexPath.row];
        biddingId = tenderModel.biddingId;
        detialVC.vcFlag = 0;
    }
    else
    {
        ZaiQuanModel *zaiQuanModel = _tabViewMutArray[indexPath.row];
        biddingId = zaiQuanModel.ordId;
        detialVC.vcFlag = 1;
    }
    detialVC.biddingId = biddingId;
    [self.navigationController pushViewController:detialVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_segementIndex==0) {
        return 146;
    }
    else
    {
        return 154;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)dealloc
{
    
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
