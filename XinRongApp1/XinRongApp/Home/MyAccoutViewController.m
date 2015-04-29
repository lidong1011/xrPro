//
//  MyAccoutViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/2.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "MyAccoutViewController.h"
#import "SettingsViewController.h"
#import "JiaoYiMXViewController.h"
#import "PersonSetViewController.h"
#import "MyTenderViewController.h"
#import "LoginViewController.h"
#import "HuiKuanJHViewController.h"
#import "TiYanJinViewController.h"
#import "ChongZhiViewController.h"
#import "TiXianViewController.h"
#import "KaiTongHFViewController.h"
#import "MyCardViewController.h"
#import "BenXiBaoZViewController.h"
#import "MessageViewController.h"
@interface MyAccoutViewController ()
@property (nonatomic, strong) NSDictionary *balDic;
@property (nonatomic, assign) NSInteger msgCount;
@end

@implementation MyAccoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _balDic = [NSDictionary dictionary];
    self.navigationItem.title = @"账户设置";
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    if ([[NSUserDefaults standardUserDefaults] stringForKey:kCustomerId]==nil)
    {
        [SVProgressHUD showInfoWithStatus:@"还未登录，去登录或注册" maskType:SVProgressHUDMaskTypeGradient];
        [self performSelector:@selector(goLogin) withObject:nil afterDelay:1];
    }
    else
    {
        //获取我余额
        [self getMyBalanceRequest];
        [self getMyMsgRequest];
        [self getMyMessageRequest];
    }
}

#pragma mark - 获取我的消息条数请求（判断按设置是否进入消息中心界面）
- (void)getMyMessageRequest
{
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:custId forKey:@"customerId"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    __weak typeof(self) weakSelf = self;
    [manager POST:kloadUnReadCountUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        MyLog(@"%@",dic);
        if ([dic[@"code"] isEqualToString:@"000"]) {
            _msgCount = [dic[@"unreadMsgCount"] integerValue];
            switch ([dic[@"unreadMsgCount"] integerValue]) {
                case 0:
                    weakSelf.messageImg.image = [UIImage imageNamed:@""];
                    break;
                
                default:
                    weakSelf.messageImg.image = [UIImage imageNamed:@"newMsg.png"];
                    break;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        
    }];
}

#pragma mark - 获取我的余额请求
- (void)getMyBalanceRequest
{
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:custId forKey:@"customerId"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    __weak typeof(self) weakSelf = self;
    [manager POST:kqueryAmtUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf getBalansuccess:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        
    }];
}

#pragma mark - 请求返回数据
- (void)getBalansuccess:(id)response
{
    /*
     账户余额 acctBal
     冻结金额 frzBal
     待收总额(待收本金+待收利息)
     待收本金restCap
     待收利息restInt
     可用余额avlBal
     待收奖励collectionReward*/
    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        //        [SVProgressHUD showSuccessWithStatus:@"成功"];
        _balDic = dic;
        self.totalMoneyLab.text = [NSString stringWithFormat:@"%@元",[dic[@"avlBal"] stringValue]];
        if (dic[@"restCap"]==nil) {
            self.daiShouJinLab.text = @"0元";
        }
        else
        {
            self.daiShouJinLab.text = [NSString stringWithFormat:@"%@元",[dic[@"restCap"] stringValue]];
        }
        if (dic[@"restInt"]==nil) {
            self.daiShouLXLab.text = @"0元";
        }
        else
        {
            self.daiShouLXLab.text = [NSString stringWithFormat:@"%@元",[dic[@"restInt"] stringValue]];
        }
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

#pragma mark - 获取我的个人信息请求
- (void)getMyMsgRequest
{
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:custId forKey:@"customerId"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    __weak typeof(self) weakSelf = self;
    [manager POST:kloadCustomerUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf getMyMsgSuccess:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        
    }];
}

- (void)getMyMsgSuccess:(id)response
{
    //个人信息
    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:dic forKey:kUserMsg];
        self.nameLab.text = dic[@"name"];
        self.jiFenLab.text = [dic[@"points"] stringValue];
        self.yongHuLab.text = dic[@"mobile"];
        if(dic[@"usrCustId"])
        {
            self.huiFuNumLab.text = dic[@"usrCustId"];
            self.huiFNextImgView.hidden = YES;
            self.huiHuiBtn.hidden = YES;
        }
        else
        {
            self.huiFuNumLab.text = @"还未开通汇付天下";
        }
        switch ([dic[@"level"] integerValue]) {
            case 0:
                self.vipImgView.image = [UIImage imageNamed:@"vip1.png"];
                break;
            case 1:
                self.vipImgView.image = [UIImage imageNamed:@"vip2.png"];
                break;
            case 2:
                self.vipImgView.image = [UIImage imageNamed:@"vip3.png"];
                break;
            case 3:
                self.vipImgView.image = [UIImage imageNamed:@"vip4.png"];
                break;
            case 4:
                self.vipImgView.image = [UIImage imageNamed:@"vip5.png"];
                break;
                
            default:
                break;
        }
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }

}

- (void)goLogin
{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
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
//返回
- (IBAction)backAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//进入设置页面
- (IBAction)settings:(UIButton *)sender
{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:kCustomerId]==nil)
    {
        [SVProgressHUD showInfoWithStatus:@"还未登录，去登录或注册" maskType:SVProgressHUDMaskTypeGradient];
        [self goLogin];
        return;
    }
    
    if (_msgCount) {
        MessageViewController *messageVC = [[MessageViewController alloc]init];
        [self.navigationController pushViewController:messageVC animated:YES];
    }
    else
    {
        SettingsViewController *settings = [[SettingsViewController alloc]init];
        [self.navigationController pushViewController:settings animated:YES];
    }
}

- (IBAction)qianDaoAction:(UIButton *)sender
{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:kCustomerId]==nil)
    {
        [SVProgressHUD showInfoWithStatus:@"还未登录，去登录或注册" maskType:SVProgressHUDMaskTypeGradient];
        [self goLogin];
        return;
    }
    //先判断是否开通汇付
    NSDictionary *userMsgDic = [[NSUserDefaults standardUserDefaults]objectForKey:kUserMsg];
    if(userMsgDic[@"usrCustId"])
    {
        [self qianDaoRequest];
    }
    else
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"还未开通汇付，请开通汇付"];
        KaiTongHFViewController *kaitongHFVC = [[KaiTongHFViewController alloc]init];
        [self.navigationController pushViewController:kaitongHFVC animated:YES];
    }
    
}

#pragma mark - 签到
- (void)qianDaoRequest
{
//    [SVProgressHUD showWithStatus:@"登录中..."];
    NSString *custId = [[NSUserDefaults standardUserDefaults] stringForKey:kCustomerId];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:custId forKey:kCustomerId];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    __weak typeof(self) weakSelf = self;
    [manager POST:ksignAtUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf qianDaoSuccess:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        
    }];
}

#pragma mark - 签到请求返回数据
- (void)qianDaoSuccess:(id)response
{
    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:dic[@"msg"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
    
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        NSString *msg = [NSString stringWithFormat:@"成功签到%@",dic[@"msg"]];
        [SVProgressHUD showImage:[UIImage imageWithName:@"logo_tu.png"] status:msg maskType:SVProgressHUDMaskTypeGradient];
        self.jiFenLab.text = [NSString stringWithFormat:@"%d",[_jiFenLab.text intValue]+1];
    }
    if ([dic[@"code"] isEqualToString:@"105"])
    {
        NSString *msg = [NSString stringWithFormat:@"今日已签到"];
        [SVProgressHUD showImage:[UIImage imageWithName:@"logo_tu.png"] status:msg maskType:SVProgressHUDMaskTypeGradient];
    }
    if ([dic[@"code"] isEqualToString:@"128"])
    {
        NSString *msg = [NSString stringWithFormat:@"没有绑定汇付天下"];
        [SVProgressHUD showImage:[UIImage imageWithName:@"logo_tu.png"] status:msg maskType:SVProgressHUDMaskTypeGradient];
    }
}

- (IBAction)nextAction:(UIButton *)sender
{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:kCustomerId]==nil)
    {
        [SVProgressHUD showInfoWithStatus:@"还未登录，去登录或注册" maskType:SVProgressHUDMaskTypeGradient];
        [self goLogin];
        return;
    }
    switch (sender.tag)
    {
        case 0:
        {
            //理财计划
            
            break;
        }
        case 1:
        {
            //交易明细
            JiaoYiMXViewController *jiaoYiVC = [[JiaoYiMXViewController alloc]init];
            [self.navigationController pushViewController:jiaoYiVC animated:YES];
            break;
        }
        case 2:
        {
            //我的卡券
            //先判断是否开通汇付
            NSDictionary *userMsgDic = [[NSUserDefaults standardUserDefaults]objectForKey:kUserMsg];
            if(userMsgDic[@"usrCustId"])
            {
                MyCardViewController *myCardVC = [[MyCardViewController alloc]init];
                [self.navigationController pushViewController:myCardVC animated:YES];
            }
            else
            {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"还未开通汇付，请开通汇付"];
                KaiTongHFViewController *kaitongHFVC = [[KaiTongHFViewController alloc]init];
                [self.navigationController pushViewController:kaitongHFVC animated:YES];
            }
            break;
        }
        case 3:
        {
            //我的荐利宝
            
            break;
        }
        case 4:
        {
            //充值
            //先判断是否开通汇付
            NSDictionary *userMsgDic = [[NSUserDefaults standardUserDefaults]objectForKey:kUserMsg];
            if(userMsgDic[@"usrCustId"])
            {
                ChongZhiViewController *chongZhiVC = [[ChongZhiViewController alloc]init];
                [self.navigationController pushViewController:chongZhiVC animated:YES];
            }
            else
            {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"还未开通汇付，请开通汇付"];
                KaiTongHFViewController *kaitongHFVC = [[KaiTongHFViewController alloc]init];
                [self.navigationController pushViewController:kaitongHFVC animated:YES];
            }
            break;
        }
        case 5:
        {
            //提现
            //先判断是否开通汇付
            NSDictionary *userMsgDic = [[NSUserDefaults standardUserDefaults]objectForKey:kUserMsg];
            if(userMsgDic[@"usrCustId"])
            {
                TiXianViewController *tiXianVC = [[TiXianViewController alloc]init];
                tiXianVC.balDic = _balDic;
                [self.navigationController pushViewController: tiXianVC animated:YES];
            }
            else
            {
                KaiTongHFViewController *kaitongHFVC = [[KaiTongHFViewController alloc]init];
                [self.navigationController pushViewController:kaitongHFVC animated:YES];
            }
            
            break;
        }
        case 6:
        {
            
            break;
        }
        case 7:
        {
            //汇付天下
            KaiTongHFViewController *kaitongHFVC = [[KaiTongHFViewController alloc]init];
            [self.navigationController pushViewController:kaitongHFVC animated:YES];
            break;
        }

        default:
            break;
    }
}

//我的投资
- (IBAction)myTouZi:(UIButton *)sender {
    if ([[NSUserDefaults standardUserDefaults] stringForKey:kCustomerId]==nil)
    {
        [SVProgressHUD showInfoWithStatus:@"还未登录，去登录或注册" maskType:SVProgressHUDMaskTypeGradient];
        [self goLogin];
        return;
    }
    MyTenderViewController *touZiVC = [[MyTenderViewController alloc]init];
    [self.navigationController pushViewController:touZiVC animated:YES];
}

//体验金
- (IBAction)tiYanJin:(UIButton *)sender
{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:kCustomerId]==nil)
    {
        [SVProgressHUD showInfoWithStatus:@"还未登录，去登录或注册" maskType:SVProgressHUDMaskTypeGradient];
        [self goLogin];
        return;
    }
    if (sender.tag==0) {
        TiYanJinViewController *tiYanJinVC = [[TiYanJinViewController alloc]init];
        [self.navigationController pushViewController:tiYanJinVC animated:YES];
    }
    else
    {
        //回款计划
        HuiKuanJHViewController *huiKuanVC = [[HuiKuanJHViewController alloc]init];
        [self.navigationController pushViewController:huiKuanVC animated:YES];
    }
}
@end
