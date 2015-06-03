//
//  ExpericeBiaoDetailViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/5/2.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "ExpericeBiaoDetailViewController.h"
#import "TouZiDetailTopView.h"
#import "ExperenceTenderViewController.h"
#import "ExperienceRecordViewController.h"
#import "CalculatorViewController.h"

#import "DanBaoJGViewController.h"
#import "FaLvYJViewController.h"
#import "DiYanQDViewController.h"

#import "WPAttributedStyleAction.h"
#import "NSString+WPAttributedMarkup.h"

//#import "TenderDetailModel.h"
//#import "ZaiDetailModel.h"
@interface ExpericeBiaoDetailViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TouZiDetailTopView *topView;
@property (nonatomic, strong) NSDictionary *dataDic;
@end
@implementation ExpericeBiaoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"体验标详情";
    [self initData];
    [self addTableView];
}

- (void)initData
{
    _dataDic = [NSDictionary dictionary];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getDetailRequest];
}

#pragma mark -添加列表视图
- (void)addTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigtBarH, kWidth, kHeight-kNavigtBarH-49) style:UITableViewStylePlain];
    //    _tableView.backgroundColor = KLColor(246, 246, 246);
    //tableview head and foot
    _topView = [TouZiDetailTopView createView];
    CGRect rect = _bottonView.frame;
    _bottonView.frame = CGRectMake(0, 0, kWidth, kHScare(rect.size.height));
    _tableView.tableHeaderView = _topView;
    _tableView.tableFooterView = _bottonView;
    [self.view addSubview:_tableView];
}

//- (void)back
//{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

#pragma mark - 体验标详情请求
- (void)getDetailRequest
{
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:_biddingId forKey:@"biddingId"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    [manager POST:kexperienceBiddingDetailUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        [SVProgressHUD showImage:[UIImage imageNamed:kLogo] status:kGetDataSuccess];
        _dataDic = dic;
        [self addDataToView];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

- (void)addDataToView
{
    /*"process": "0",
     "totalTender": 0,
     "intDate": null,
     "title": "新手体验标",
     "biddingStatus": 0,
     "biddingMoney": 50000,
     "seqNo": 2,
     "biddingId": "20150216184816881727",
     "intRate": 0.18,
     "ordDate": "2015-02-16"*/
    NSDictionary* style1 = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:10.0],
                             @"bold":[UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0]
                             };
    self.topView.processLab.text = [NSString stringWithFormat:@"%@%%",_dataDic[@"data"][@"process"]];
    [self.topView.companyBtn setTitle:_dataDic[@"data"][@"title"] forState:UIControlStateNormal];
    NSString *nianString = [NSString stringWithFormat:@"<bold>%.1f</bold> <body>%%</body> ",[_dataDic[@"data"][@"intRate"] floatValue]*100];
    self.topView.nianHLLab.attributedText = [nianString attributedStringWithStyleBook:style1];
    NSString *timeString = [NSString stringWithFormat:@"<bold>3</bold> <body>天</body> "];
    self.topView.timeLab.attributedText = [timeString attributedStringWithStyleBook:style1];
    self.topView.moneyLab.text = [NSString stringWithFormat:@"￥%@",[_dataDic[@"data"][@"biddingMoney"] stringValue]];

    self.topView.text1Lab.text = [NSString stringWithFormat:@"%d元",[_dataDic[@"data"][@"biddingMoney"] intValue]-[_dataDic[@"data"][@"totalTender"] intValue]];
    self.topView.text2_lab.text = @"发标日期:";
    self.topView.text2Lab.text = _dataDic[@"data"][@"ordDate"];
//    switch ([_dataDic[@"biddingStatus"] intValue]) {
//        case 0:
//            self.topView.text2Lab.text = @"投标中";
//            break;
//        case 1:
//            self.topView.text2Lab.text = @"满标";
//            break;
//        default:
//            break;
//    }
//    if([_tenderDetModel.repaymentSort intValue] == 0)
//    {
//        self.topView.text3Lab.text = @"按月等额本息";
//    }
//    else
    {
        self.topView.text3Lab.text = @"按月付息，到期还本";
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

- (IBAction)bottomAct:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 0:
        {
            //体验标投标记录
            ExperienceRecordViewController *touBiaoRecordVC = [[ExperienceRecordViewController alloc]init];
            touBiaoRecordVC.tabViewMutArray = _dataDic[@"tenders"];
            [self.navigationController pushViewController:touBiaoRecordVC animated:YES];
            break;
        }
        case 1:
        {
            //项目描叙
            DanBaoJGViewController *xiangMuDetailVC = [[DanBaoJGViewController alloc]init];
            xiangMuDetailVC.vCflag = 1;
            xiangMuDetailVC.isTiyanBiao = YES;
            xiangMuDetailVC.detailString = @"体验标项目描叙";
            [self.navigationController pushViewController:xiangMuDetailVC animated:YES];
            break;
        }
        case 2:
        {
            //图片资料
            ExperienceRecordViewController *touBiaoRecordVC = [[ExperienceRecordViewController alloc]init];
            touBiaoRecordVC.tabViewMutArray = _dataDic[@"tenders"];
            [self.navigationController pushViewController:touBiaoRecordVC animated:YES];
            break;
        }
        case 3:
        {
            //抵押清单
            DiYanQDViewController *dYQDVC = [[DiYanQDViewController alloc]init];
            dYQDVC.vCflag = 0;
            dYQDVC.isTiYanBiao = YES;
            [self.navigationController pushViewController:dYQDVC animated:YES];
            break;
        }
        case 4:
        {
            //法律意见
            FaLvYJViewController *faLvVC = [[FaLvYJViewController alloc]init];
            faLvVC.isTiYanBiao = YES;
            [self.navigationController pushViewController:faLvVC animated:YES];
            break;
        }
        case 5:
        {
            //计算器
            CalculatorViewController *calculatorVC = [[CalculatorViewController alloc]init];
            calculatorVC.nianRate = _dataDic[@"data"][@"intRate"];
            calculatorVC.time = @3;
            calculatorVC.totalMoney = _dataDic[@"data"][@"biddingMoney"];
            [self.navigationController pushViewController:calculatorVC animated:YES];
            break;
        }
        case 6:
        {
            //体验标投标
            ExperenceTenderViewController *touBiaoVC = [[ExperenceTenderViewController alloc]init];
            touBiaoVC.biddingId = _biddingId;
            touBiaoVC.ordType = _ordType;
            touBiaoVC.keTouMoney = [_dataDic[@"data"][@"biddingMoney"] integerValue]-[_dataDic[@"data"][@"totalTender"] integerValue];
            [self.navigationController pushViewController:touBiaoVC animated:YES];
            break;
        }
        default:
            break;
    }
}
@end
