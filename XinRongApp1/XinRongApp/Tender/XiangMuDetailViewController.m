//
//  XiangMuDetailViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/9.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "XiangMuDetailViewController.h"
#import "DanBaoJGViewController.h"
#import "FaLvYJViewController.h"
#import "DiYanQDViewController.h"
#import "TouZiDetailTopView.h"
#import "BeginTenderViewController.h"
#import "CalculatorViewController.h"

#import "WPAttributedStyleAction.h"
#import "NSString+WPAttributedMarkup.h"

#import "TenderDetailModel.h"
#import "ZaiDetailModel.h"
@interface XiangMuDetailViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TouZiDetailTopView *topView;
//@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) TenderDetailModel *tenderDetModel;
@property (nonatomic, strong) ZaiDetailModel *zhaiQuanDetModel;
@end

@implementation XiangMuDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"项目详情";
    
    [self addTableView];
    
    [self getDetailRequest];
}

#pragma mark -添加列表视图
- (void)addTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigtBarH, kWidth, kHeight-kNavigtBarH-49) style:UITableViewStylePlain];
//    _tableView.backgroundColor = KLColor(246, 246, 246);
    //tableview head and foot
    _topView = [TouZiDetailTopView createView];
    _tableView.tableHeaderView = _topView;
    _tableView.tableFooterView = _bottonView;
    [self.view addSubview:_tableView];
}

#pragma mark - 项目详情请求
- (void)getDetailRequest
{
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    NSString *url;
    if(_vcFlag == 0)
    {
        //投资
        url = kqueryBiddingDetailUrl;
        [parameter setObject:_biddingId forKey:@"biddingId"];
    }
    else
    {
        //债权
        url = kqueryTransferDetailUrl;
        [parameter setObject:_biddingId forKey:@"ordId"];
    }
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        [self.tableView reloadData];
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
        if (_vcFlag == 0) {
            _tenderDetModel = [TenderDetailModel messageWithDict:dic];
        }
        else
        {
            _zhaiQuanDetModel = [ZaiDetailModel messageWithDict:dic];
        }
        [self addData];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

#pragma mark - 添加数据
- (void)addData
{
    NSDictionary* style1 = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:10.0],
                             @"bold":[UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0]
                             };
    if (_vcFlag == 0) {
        self.topView.processLab.text = [NSString stringWithFormat:@"%@%%",_tenderDetModel.process];
        [self.topView.companyBtn setTitle:_tenderDetModel.compName forState:UIControlStateNormal];
        NSString *nianString = [NSString stringWithFormat:@"<bold>%.1f</bold> <body>%%</body> ",[_tenderDetModel.interestRate floatValue]*100];
        self.topView.nianHLLab.attributedText = [nianString attributedStringWithStyleBook:style1];
        NSString *timeString = [NSString stringWithFormat:@"<bold>%@</bold> <body>个月</body> ",[_tenderDetModel.timeLimit stringValue]];
        self.topView.timeLab.attributedText = [timeString attributedStringWithStyleBook:style1];
        self.topView.moneyLab.text = [NSString stringWithFormat:@"%@元",[_tenderDetModel.biddingMoney stringValue]];
        
        self.topView.text1Lab.text = [NSString stringWithFormat:@"%d",[_tenderDetModel.biddingMoney intValue]-[_tenderDetModel.totalTender intValue]];
        MyLog(@"%@",_tenderDetModel.biddingStatus);
        switch ([_tenderDetModel.biddingStatus intValue]) {
            case 0:
                self.topView.text2Lab.text = @"投标中";
                [self.bottomBtn setTitle:@"我要投标" forState:UIControlStateNormal];
                break;
            case 1:
                self.topView.text2Lab.text = @"满标";
                self.bottomBtn.enabled = NO;
                [self.bottomBtn setTitle:@"回款中" forState:UIControlStateNormal];
                break;
            case 2:
                self.topView.text2Lab.text = @"回款中";
                self.bottomBtn.enabled = NO;
                [self.bottomBtn setTitle:@"回款中" forState:UIControlStateNormal];
                break;
            case 3:
                self.topView.text2Lab.text = @"回款成功";
                self.bottomBtn.enabled = NO;
                [self.bottomBtn setTitle:@"回款中" forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        if([_tenderDetModel.repaymentSort intValue] == 0)
        {
            self.topView.text3Lab.text = @"按月等额本息";
        }
        else
        {
            self.topView.text3Lab.text = @"先息后本";
        }
    }
    else
    {
        //状态
        self.topView.processLab.font = [UIFont systemFontOfSize:10];
        switch ([_zhaiQuanDetModel.transStatus intValue]) {
            case 0:
                self.topView.processLab.text = @"可承接";
                [self.bottomBtn setTitle:@"我要承接" forState:UIControlStateNormal];
                break;
            case 2:
                self.topView.processLab.text = @"承接成功";
                self.bottomBtn.enabled = NO;
                [self.bottomBtn setTitle:@"承接成功" forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        [self.topView.companyBtn setTitle:_zhaiQuanDetModel.compName forState:UIControlStateNormal];
        NSString *nianString = [NSString stringWithFormat:@"<bold>%.1f</bold> <body>%%</body> ",[_zhaiQuanDetModel.interestRate floatValue]*100];
        self.topView.nianHLLab.attributedText = [nianString attributedStringWithStyleBook:style1];
        NSString *timeString = [NSString stringWithFormat:@"<bold>%@</bold> <body>个月</body> ",[_zhaiQuanDetModel.surplusDays stringValue]];
        self.topView.timeLab.attributedText = [timeString attributedStringWithStyleBook:style1];
        self.topView.moneyLab.text = [_zhaiQuanDetModel.biddingMoney stringValue];
        
        self.topView.text1_lab.text = @"转让本金：";
        self.topView.text1Lab.text = [_zhaiQuanDetModel.transAmt stringValue];
        self.topView.text2_lab.text = @"承接价格：";
        self.topView.text2Lab.text = [_zhaiQuanDetModel.creditDealAmt stringValue];
        if([_zhaiQuanDetModel.repaymentSort intValue] == 0)
        {
            self.topView.text3Lab.text = @"按月等额本息";
        }
        else
        {
            self.topView.text3Lab.text = @"先息后本";
        }
    }
}

- (IBAction)bottomBtnAction:(UIButton *)sender
{
    MyLog(@"%ld",sender.tag);
    switch (sender.tag) {
        case 0:
        {
            //项目描叙
            NSString *detailString;
            NSString *title;
            if (_vcFlag == 0) {
                detailString = _tenderDetModel.dataDic[@"description"];
                title = _tenderDetModel.title;
            }
            else
            {
                detailString = _zhaiQuanDetModel.descriptionString;
                title = _zhaiQuanDetModel.title;
            }
            DanBaoJGViewController *xiangMuDetailVC = [[DanBaoJGViewController alloc]init];
            xiangMuDetailVC.vCflag = 1;
            xiangMuDetailVC.detailString = detailString;
            xiangMuDetailVC.titleString = title;
            [self.navigationController pushViewController:xiangMuDetailVC animated:YES];
            break;
        }
        case 1:
        {
            //图片资料
            NSArray *picArray = [NSArray array];
            NSString *title;
            if (_vcFlag == 0) {
                picArray = _tenderDetModel.fileList;
                title = _tenderDetModel.title;
            }
            else
            {
                picArray = _zhaiQuanDetModel.fileList;
                title = _zhaiQuanDetModel.title;
            }
            DiYanQDViewController *picVC = [[DiYanQDViewController alloc]init];
            picVC.vCflag = 1;
            picVC.titleString = title;
            picVC.picArray = picArray;
            [self.navigationController pushViewController:picVC animated:YES];
            break;
        }
        case 2:
        {
            //抵押清单
            NSArray *picArray = [NSArray array];
            NSString *title;
            if (_vcFlag == 0) {
                picArray = _tenderDetModel.fileMorList;
                title = _tenderDetModel.title;
            }
            else
            {
                picArray = _zhaiQuanDetModel.fileMorList;
                title = _zhaiQuanDetModel.title;
            }

            DiYanQDViewController *dYQDVC = [[DiYanQDViewController alloc]init];
            dYQDVC.vCflag = 0;
            dYQDVC.titleString = title;
            dYQDVC.picArray = picArray;
            [self.navigationController pushViewController:dYQDVC animated:YES];
            break;
        }
        case 3:
        {
            //法律意见
            NSString *detailString;
            NSString *title;
            if (_vcFlag == 0) {
                detailString = _tenderDetModel.lawAdvice;
                title = _tenderDetModel.title;
            }
            else
            {
                detailString = _zhaiQuanDetModel.lawAdvice;
                title = _zhaiQuanDetModel.title;
            }
            FaLvYJViewController *faLvVC = [[FaLvYJViewController alloc]init];
            faLvVC.titleString = title;
            faLvVC.detailString = detailString;
            [self.navigationController pushViewController:faLvVC animated:YES];
            break;
        }
        case 4:
        {
            //担保机构
            NSString *detailString;
            NSString *title;
            if (_vcFlag == 0) {
                detailString = _tenderDetModel.description;
                title = _tenderDetModel.title;
            }
            else
            {
                detailString = _zhaiQuanDetModel.description;
                title = _zhaiQuanDetModel.title;
            }
            DanBaoJGViewController *dBJGVC = [[DanBaoJGViewController alloc]init];
            dBJGVC.vCflag = 0;
            dBJGVC.titleString = title;
            [self.navigationController pushViewController:dBJGVC animated:YES];
            break;
        }
        case 5:
        {
            //担保意见
            NSString *detailString;
            NSString *title;
            if (_vcFlag == 0) {
                detailString = _tenderDetModel.advice;
                title = _tenderDetModel.title;
            }
            else
            {
                detailString = _zhaiQuanDetModel.advice;
                title = _zhaiQuanDetModel.title;
            }
            DanBaoJGViewController *danBaoJGVC = [[DanBaoJGViewController alloc]init];
            danBaoJGVC.vCflag = 2;
            danBaoJGVC.titleString = title;
            danBaoJGVC.detailString = detailString;
            [self.navigationController pushViewController:danBaoJGVC animated:YES];
            break;
        }
        case 6:
        {
            //计算器
            NSNumber *nianRate;
            NSNumber *money;
            NSNumber *time;
            NSString *title;
            if (_vcFlag == 0) {
                nianRate = _tenderDetModel.interestRate;
                money = _tenderDetModel.biddingMoney;
                time = _tenderDetModel.timeLimit;
                title = _tenderDetModel.title;
            }
            else
            {
                nianRate = _zhaiQuanDetModel.interestRate;
                money = _zhaiQuanDetModel.biddingMoney;
                time = _zhaiQuanDetModel.surplusDays;
                title = _zhaiQuanDetModel.title;
            }
            CalculatorViewController *calculatorVC = [[CalculatorViewController alloc]init];
            calculatorVC.nianRate = nianRate;
            calculatorVC.time = time;
            calculatorVC.totalMoney = money;
            [self.navigationController pushViewController:calculatorVC animated:YES];
            break;
        }
        case 7:
        {
            //开始投标
            NSString *biddingId;
            NSString *title;
            if (_vcFlag == 0) {
                biddingId = _tenderDetModel.biddingId;
                title = _tenderDetModel.title;
            }
            else
            {
                biddingId = _zhaiQuanDetModel.ordId;
                title = _zhaiQuanDetModel.title;
            }
            BeginTenderViewController *touBiaoVC = [[BeginTenderViewController alloc]init];
            touBiaoVC.biddingId = biddingId;
            [self.navigationController pushViewController:touBiaoVC animated:YES];
            break;
        }
        default:
            break;
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
