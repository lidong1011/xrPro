//
//  HomeViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/5/7.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "HomeViewController.h"
#import "TenderViewController.h"
#import "TransferListViewController.h"
#import "ExperenceAreaViewController.h"
#import "ActivityViewController.h"
#import "LoginViewController.h"
#import "TiYanJinViewController.h"
#import "SafeViewController.h"
#import "BWMCoverView.h"
#import "MyButton.h"
#import "AnimationView.h"
@interface HomeViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *imagesMuArray;
@property (nonatomic, strong) BWMCoverView *topBanner;

@property (nonatomic, strong) NSArray *btnImages;
@property (nonatomic, strong) NSArray *btnTitles;
@property (nonatomic, strong) UIImageView *tipOfNew;

@property (nonatomic, strong) NSString *updataStr;
@end

#define kTopH 180

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = KLColor(237, 239, 249);
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(0, 100, 31, 31);
//    [rightBtn setBackgroundImage:[UIImage imageNamed:@"person.png"] forState:UIControlStateNormal];
//    //    [rightBtn setTitle:@"个人" forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    [self initData];
    [self addTableView];
    //检查更新
    [self checkUpdata];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self getBannerPic];
}

- (void)getBannerPic
{
//    [SVProgressHUD showWithStatus:@"加载数据中..." maskType:SVProgressHUDMaskTypeGradient];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    __weak typeof(self) weakSelf = self;
    [manager POST:kqueryIndexPicUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf getBannerPicSuccess:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 请求返回数据
- (void)getBannerPicSuccess:(id)response
{
    [SVProgressHUD dismiss];
    
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        NSArray *data = dic[@"data"];
        //判断是否有图片
        if(data.count)
        {
            [_imagesMuArray removeAllObjects];
        }
        else
        {
            BWMCoverViewModel *model = [[BWMCoverViewModel alloc] initWithImageURLString:@"1.png" imageTitle:nil];
            _imagesMuArray = [NSMutableArray arrayWithObject:model];
        }
        for (int i = 0; i<data.count; i++)
        {
            NSString *imageStr = [NSString stringWithFormat:@"%@%@",kPicUrl,data[i][@"filePath"]];
            //        NSString *imageTitle = [NSString stringWithFormat:@"第%d个小猫", i+1];
            BWMCoverViewModel *model = [[BWMCoverViewModel alloc] initWithImageURLString:imageStr imageTitle:nil];
            [_imagesMuArray addObject:model];
        }
        _topBanner.models = _imagesMuArray;
//        _topBanner.placeholderImageNamed = BWMCoverViewDefaultImage;
//        _topBanner.animationOption = UIViewAnimationOptionTransitionCurlUp;
        
        [_topBanner setCallBlock:^(NSInteger index) {
            NSLog(@"你点击了第%d个图片", index);
        }];
        
//        [coverView2 setScrollViewCallBlock:^(NSInteger index) {
//            NSLog(@"当前滚动到第%d个页面", index);
//        }];
        
        
#warning 修改属性后必须调用updateView方法
        [_topBanner updateView];
    }
    else
    {
        //        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

- (void)initData
{
    _btnImages = @[@"tiyb.png",@"woytz.png",@"zhaiquan.png",@"safe.png",@"huodong.png",@"",@"",@"",@""];
    _btnTitles = @[@"新手标",@"我要投资",@"债权转让",@"安全保障",@"活动",@"",@"",@"",@""];
    _imagesMuArray = [NSMutableArray array];
}

#pragma mark -添加列表视图
- (void)addTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHScare(kTopH), kWidth, kHeight-kHScare(kTopH)) style:UITableViewStylePlain];
    _tableView.backgroundColor = KLColor(236, 237, 239);
        //    _tableView.backgroundColor = KLColor(246, 246, 2);
    if (isOver3_5Inch)
    {
//        CGRect rect = _allView.frame;
//        _allView.frame = CGRectMake(0, 0, kWidth, kHScare(rect.size.height));
    }
//    tableView.tableFooterView = _allView;
    [self.view addSubview:_tableView];
    
    // 此数组用来保存BWMCoverViewModel
    NSMutableArray *realArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<1; i++)
    {
        NSString *imageStr = [NSString stringWithFormat:@"http://www.xr58.com:8085/esb/apprequest/request?code=onlinePic&path=test/atta_banner_app_pic/20150518/3131431932392358.png"];
        //        NSString *imageTitle = [NSString stringWithFormat:@"第%d个小猫", i+1];
        BWMCoverViewModel *model = [[BWMCoverViewModel alloc] initWithImageURLString:imageStr imageTitle:nil];
        [realArray addObject:model];
    }
    
    // 以上代码只为了构建一个包含BWMCoverViewModel的数组而已——realArray
    //* 快速创建BWMCoverView
    // * models是一个包含BWMCoverViewModel的数组
    //* placeholderImageNamed为图片加载前的本地占位图片名
    
    _topBanner = [BWMCoverView coverViewWithModels:realArray andFrame:CGRectMake(0, kNavigtBarH, kWidth, kHScare(kTopH)) andPlaceholderImageNamed:@"1.png" andClickdCallBlock:^(NSInteger index) {
        NSLog(@"你点击了第%ld个图片", index);
    }];
    [_topBanner setAutoPlayWithDelay:1.0];
    [self.view addSubview:_topBanner];

    CGFloat bottonW = kWidth/3.0;
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kWidth)];
    _tableView.tableFooterView = footView;
    
    for (int i=0; i<9; i++)
    {
        MyButton *custBtn = [MyButton createView];
        custBtn.frame = CGRectMake(i%3*bottonW, i/3*bottonW, bottonW, bottonW);
        custBtn.imgView.image = [UIImage imageNamed:_btnImages[i]];
        custBtn.label.text = _btnTitles[i];
        custBtn.botton.tag = i;
        //是否有新标的标志
        if (i==1)
        {
            _tipOfNew = [[UIImageView alloc]initWithFrame:CGRectMake(bottonW-27, 0, 27, 27)];
            _tipOfNew.image = [UIImage imageNamed:@"newTip.png"];
            _tipOfNew.hidden = YES;
            [custBtn addSubview:_tipOfNew];
        }
        if (i==5)
        {
            custBtn.bgImg.image = [UIImage imageNamed:@"more_h.png"];
        }
        [custBtn.botton addTarget:self action:@selector(goTo:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:custBtn];
    }
    UIImageView *hengLine = [[UIImageView alloc]init];
    hengLine.image = [UIImage imageWithName:@"hengLine_h.9.png"];
    hengLine.frame = CGRectMake(0, bottonW, kWidth, 1);
    [footView addSubview:hengLine];
    
    UIImageView *hengLine2 = [[UIImageView alloc]init];
    hengLine2.image = [UIImage imageWithName:@"hengLine_h.9.png"];
    hengLine2.frame = CGRectMake(0, bottonW*2, kWidth, 1);
    [footView addSubview:hengLine2];
    
    UIImageView *shuLine = [[UIImageView alloc]init];
    shuLine.image = [UIImage imageWithName:@"shuLine_h.9.png"];
    shuLine.frame = CGRectMake(bottonW, 0, 1, kWidth);
    [footView addSubview:shuLine];
    
    UIImageView *shuLine2 = [[UIImageView alloc]init];
    shuLine2.image = [UIImage imageWithName:@"shuLine_h.9.png"];
    shuLine2.frame = CGRectMake(bottonW*2, 0, 1, kWidth);
    [footView addSubview:shuLine2];
}

- (void)goTo:(UIButton *)sender
{
//    return;
    switch (sender.tag)
    {
        case 0:
        {//新手
            if ([[NSUserDefaults standardUserDefaults] stringForKey:kCustomerId]==nil)
            {
                [SVProgressHUD showInfoWithStatus:@"还未登录，去登录或注册" maskType:SVProgressHUDMaskTypeGradient];
                LoginViewController *loginVC = [[LoginViewController alloc]init];
                [self.navigationController pushViewController:loginVC animated:YES];
                return;
            }
//            NSDictionary *msgDic = [[NSUserDefaults standardUserDefaults] objectForKey:kUserMsg];
//            if ([msgDic[@"allAmt"] integerValue]==0)
            {//未领取体验金
                ExperenceAreaViewController *experenceVC = [[ExperenceAreaViewController alloc]init];
                [self.navigationController pushViewController:experenceVC animated:YES];
            }
//            else
//            {
//                TiYanJinViewController *tiYanJinVC = [[TiYanJinViewController alloc]init];
//                [self.navigationController pushViewController:tiYanJinVC animated:YES];
//            }
            break;
        }
        case 1:
        {//我要投资
            TenderViewController *tenderVC = [[TenderViewController alloc]init];
            [self.navigationController pushViewController:tenderVC animated:YES];
            break;
        }
        case 2:
        {//债权
            TransferListViewController *tenderVC = [[TransferListViewController alloc]init];
            [self.navigationController pushViewController:tenderVC animated:YES];
            break;
        }
        case 3:
        {//安全保障
            SafeViewController *safeVC = [[SafeViewController alloc]init];
            [self.navigationController pushViewController:safeVC animated:YES];
            break;
        }
        case 4:
        {//活动
            ActivityViewController *actiVC = [[ActivityViewController alloc]init];
            [self.navigationController pushViewController:actiVC animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==10000)
    {
        if (buttonIndex==1) {
            
            NSURL *url = [NSURL URLWithString:_updataStr];
            
            [[UIApplication sharedApplication]openURL:url];
            
        }
    }
}

#pragma mark 检查更新
- (void)checkUpdata
{
    //    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    //    [parameter setObject:@"id" forKey:@"959293324"];
    [SVProgressHUD showWithStatus:@"检查更新中..." maskType:SVProgressHUDMaskTypeGradient];
    AFHTTPSessionManager *_manager = [[AFHTTPSessionManager alloc]init];
    [_manager POST:@"http://itunes.apple.com/lookup?id=1001047776" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        [self verionback:responseObject];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        [SVProgressHUD dismiss];
    }];
}

- (void)verionback:(id)response
{
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    [SVProgressHUD dismiss];
    //    //    SBJsonParser *sbParser = [[SBJsonParser alloc]init];
    //    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:dic[@"msg"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //    [alert show];
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    //CFShow((__bridge CFTypeRef)(infoDic));
    
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    NSLog(@"----%@----",currentVersion);
    
    NSArray *infoArray = [dic objectForKey:@"results"];
    
    if ([infoArray count]) {
        
        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
        
        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        _updataStr = [releaseInfo objectForKey:@"trackViewUrl"];
        [[NSUserDefaults standardUserDefaults]setObject:_updataStr forKey:kDownloadUrl];
        MyLog(@"%@",_updataStr);
        
        if (![lastVersion isEqualToString:currentVersion]) {
            
            //trackViewURL = [releaseInfo objectForKey:@"trackVireUrl"];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
            
            alert.tag = 10000;
            
            [alert show];
            
        }
        else
        {
           
        }
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
