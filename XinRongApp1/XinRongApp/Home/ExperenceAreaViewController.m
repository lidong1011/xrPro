//
//  HomeViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/3/10.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "ExperenceAreaViewController.h"
#import "WPAttributedStyleAction.h"
#import "NSString+WPAttributedMarkup.h"

#import "MyAccoutViewController.h"
#import "YaoYiYaoViewController.h"
#import "ActivityViewController.h"
#import "WuYeBiaoViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"

#import "ExpericeBiaoDetailViewController.h"

#import "ImagePlayerView.h"
#import "BWMCoverView.h"
#import "MDRadialProgressLabel.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressView.h"
#import "menuView.h"
#import "KLCoverView.h"


@interface ExperenceAreaViewController ()<UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *imagesMuArray;
@property (nonatomic, strong) BWMCoverView *topBanner;
@property (nonatomic, strong) UILabel *bianNameLab;
@property (nonatomic, strong) UILabel *yearRateLab;
@property (nonatomic, strong) UILabel *numOfBiaoLab;
@property (nonatomic, strong) UILabel *moneyLab;
@property (nonatomic, strong) UILabel *backMonthLab;
@property (nonatomic, strong) UIButton *tiYanBtn;

@property (nonatomic, strong) MDRadialProgressView *progress;

//菜单
@property (nonatomic, strong) KLCoverView *coverView;
@property (nonatomic, strong) MenuView *menuView;
@property (nonatomic, assign) BOOL menuShowFlag;  //记录菜单的是处在的状态

//体验标
@property (nonatomic, strong) NSDictionary *dic;

//是否体验过体验jin
@property (nonatomic, assign) BOOL isNotTiYan;
@end

#define kTopH 140
#define kVSpace 20 //上下之间的间隔
#define kH_Space 20 //左右的间距
@implementation ExperenceAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新手标";
    
//    self.navigationController.navigationBarHidden = YES;
//    self.tabBarController.tabBar.hidden = YES;
    //初始化数据
    [self initData];
    
    [self initSubview];
    
    //得到体验金
    [self getTiYanJRequest];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getTiYanBiaoRequest];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideMenuView];
}


//初始化数据
- (void)initData
{
    _imagesMuArray = [NSMutableArray array];
    _imagesMuArray = [NSMutableArray arrayWithObjects:@"banner.png",@"banner.png",@"banner.png",@"banner.png", nil];
}

#pragma mark - 体验标
- (void)getTiYanBiaoRequest
{
    /*用户IDcustomerId
     体验金额 transAmt
     类型 ordRes*/
    //    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:@"ios" forKey:@"reqType"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    __weak typeof(self) weakSelf = self;
    [manager POST:kexperienceBiddingUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf success:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        [SVProgressHUD showInfoWithStatus:@"体验金获取失败"];
    }];
}

#pragma mark - 请求返回数据
- (void)success:(id)response
{
    //    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    //    [self.tableView.footer endRefreshing];
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        _dic = dic[@"data"];
        [self addData];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"暂无体验标" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)addData
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
    NSString *nianString = [NSString stringWithFormat:@"<bold>%.1f</bold> <body>%%</body> ",[_dic[@"intRate"] floatValue]*100];
    self.yearRateLab.attributedText = [nianString attributedStringWithStyleBook:style1];
    self.bianNameLab.text = _dic[@"title"];
    self.numOfBiaoLab.text = [NSString stringWithFormat:@"No %@",[_dic[@"seqNo"] stringValue]];
    self.moneyLab.text = [NSString stringWithFormat:@"￥%@",[_dic[@"biddingMoney"] stringValue]];
    NSString *numOfMonth = [NSString stringWithFormat:@"<bold>3</bold> <body>天</body> "];
    self.backMonthLab.attributedText = [numOfMonth attributedStringWithStyleBook:style1];
    self.progress.progressTotal = 100;
    self.progress.progressCounter = [_dic[@"process"] integerValue];
}

#pragma mark - 体验金请求(判断是否获取过体验金)
- (void)getTiYanJRequest
{
    /*用户IDcustomerId 必填
     转让标ID tenderId 必填
     */
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    
    [SVProgressHUD showWithStatus:@"加载数据中..." maskType:SVProgressHUDMaskTypeGradient];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:custId forKey:@"customerId"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    __weak typeof(self) weakSelf = self;
    [manager POST:kexperienceRecordUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weakSelf TiYanJSuccess:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 请求返回数据
- (void)TiYanJSuccess:(id)response
{
    [SVProgressHUD dismiss];
    
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    if ([dic[@"code"] isEqualToString:@"000"])
    {
//        [SVProgressHUD showImage:[UIImage imageNamed:kLogo] status:dic[@"msg"]];
        if([dic[@"unTenderAmt"] integerValue]==0&&[dic[@"tenderAmt"] integerValue]>0)
        {
//            _isNotTiYan = YES;
//            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isNotTiYan"];
            _tiYanBtn.enabled = NO;
            [_tiYanBtn setTitle:@"已经体验过了" forState:UIControlStateDisabled];
        }
    }
    else
    {
//        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
    
}

//把视图初始化
- (void)initSubview
{
    //菜单按钮
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftBtn.frame = CGRectMake(0, 100, 31, 31);
//    [leftBtn setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
////    [leftBtn setTitle:@"菜单" forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(menuList:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(0, 100, 31, 31);
//    [rightBtn setBackgroundImage:[UIImage imageNamed:@"person.png"] forState:UIControlStateNormal];
////    [rightBtn setTitle:@"个人" forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(person) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];

    
//    UIImageView *coverImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
//    coverImageView.image = [UIImage imageNamed:@"1.png"];
//    [self.view addSubview:coverImageView];
    //体验标的布局
    
    //马上体验按钮的高度
    CGFloat tiYanBtnH = 35;
    
    //马上体验
    UIButton *tiYanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tiYanBtn.frame = CGRectMake(kWScare(kH_Space), kHeight-49-kHScare(tiYanBtnH)-kHScare(kVSpace), kWidth-2*kWScare(kH_Space), kHScare(tiYanBtnH));
//    [tiYanBtn setBackgroundImage:[UIImage imageNamed:@"tiYanBtn_bg.png"] forState:UIControlStateNormal];
    [tiYanBtn setTitle:@"马上体验" forState:UIControlStateNormal];
    [tiYanBtn setBackgroundColor:kZhuTiColor];
    tiYanBtn.layer.cornerRadius = kHScare(10);
    tiYanBtn.clipsToBounds = YES;
    [tiYanBtn addTarget:self action:@selector(tiYanAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tiYanBtn];
    _tiYanBtn = tiYanBtn;
    
//    [self.view bringSubviewToFront:tiYanBtn];
    
    //轮播图
//    _topBanner = [[ImagePlayerView alloc]initWithFrame:CGRectMake(0, kNavigtBarH, kWidth, kHScare(kTopH))];
////    [self.topBanner clearsContextBeforeDrawing];
//    [self.topBanner initWithCount:_imagesMuArray.count delegate:self];
//    self.topBanner.scrollInterval = 2.0f;
//    
//    // adjust pageControl position
//    self.topBanner.pageControlPosition = ICPageControlPosition_BottomRight;
//    
//    // hide pageControl or not
//    self.topBanner.hidePageControl = NO;
////    self.topBanner.backgroundColor = [UIColor redColor];
//    [self.view addSubview:_topBanner];
    
    // 此数组用来保存BWMCoverViewModel
//    NSMutableArray *realArray = [[NSMutableArray alloc] init];
//    
//    for (int i = 0; i<5; i++)
//    {
//        NSString *imageStr = [NSString stringWithFormat:@"http://ikaola-image.b0.upaiyun.com/club/2014/9/28/575ba9141352103160644106f6ea328d_898_600.jpg"];
////        NSString *imageTitle = [NSString stringWithFormat:@"第%d个小猫", i+1];
//        BWMCoverViewModel *model = [[BWMCoverViewModel alloc] initWithImageURLString:imageStr imageTitle:nil];
//        [realArray addObject:model];
//    }
//    
//    // 以上代码只为了构建一个包含BWMCoverViewModel的数组而已——realArray
//     //* 快速创建BWMCoverView
//    // * models是一个包含BWMCoverViewModel的数组
//     //* placeholderImageNamed为图片加载前的本地占位图片名
//     
//    _topBanner = [BWMCoverView coverViewWithModels:realArray andFrame:CGRectMake(0, kNavigtBarH, self.view.bounds.size.width, kHScare(kTopH)) andPlaceholderImageNamed:@"1.png" andClickdCallBlock:^(NSInteger index) {
//        NSLog(@"你点击了第%d个图片", index);
//    }];
//    [_topBanner setAutoPlayWithDelay:2.0];
//    [self.view addSubview:_topBanner];
    UIImageView *topImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kNavigtBarH, self.view.bounds.size.width, kHScare(kTopH))];
    topImgView.image = [UIImage imageNamed:@"xiangBanner.png"];
    [self.view addSubview:topImgView];
    
    //新手标的高度
    CGFloat allHeight = kHeight-topImgView.bottom-tiYanBtn.height-49-3*kHScare(kVSpace);
    CGFloat fontSize = 12;
    
    //标名
    _bianNameLab = [[UILabel alloc]initWithFrame:CGRectMake(kH_Space, topImgView.bottom+kHScare(kHScare(kVSpace)), kWidth-2*kH_Space, allHeight/4)];
    _bianNameLab.text = @"";
    _bianNameLab.textAlignment = NSTextAlignmentCenter;
    _bianNameLab.font = [UIFont systemFontOfSize:kWScare(fontSize+2)];
    [self.view addSubview:_bianNameLab];
    
    UIImageView *leftRoundCorImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kH_Space, _bianNameLab.top, kWScare(60), kWScare(70))];
    leftRoundCorImgView.image = [UIImage imageNamed:@"leftCorner.png"];
    [self.view addSubview:leftRoundCorImgView];
    UIImageView *rightRoundCorImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth-kH_Space-kWScare(60), _bianNameLab.top, kWScare(60), kWScare(71))];
    rightRoundCorImgView.image = [UIImage imageNamed:@"rightCorner.png"];
    [self.view addSubview:rightRoundCorImgView];
    
    
    //中间图形
    _progress = [[MDRadialProgressView alloc]initWithFrame:CGRectMake(kWidth/2-allHeight/4, _bianNameLab.bottom, allHeight/2, allHeight/2)];
    _progress.theme.completedColor = kZhuTiColor;
    _progress.progressTotal = 100;
    _progress.progressCounter = 1;
    //    _progress.theme.completedColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    _progress.theme.incompletedColor = KLColor(202, 201, 201);
    _progress.theme.thickness = kWScare(30);
    _progress.theme.sliceDividerHidden = YES;
    [self.view addSubview:_progress];
    
    //下面数据间隔线
    UIImageView *lineImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth/2, _progress.bottom+4, 1, allHeight/4)];
    lineImgView.image = [UIImage imageNamed:@"shuLine.png"];
    [self.view addSubview:lineImgView];
    
    //年化率
    UILabel *nianHuaLvLab = [[UILabel alloc]init];
    nianHuaLvLab.text = @"年化率:";
    nianHuaLvLab.font = [UIFont systemFontOfSize:fontSize];
    nianHuaLvLab.frame = CGRectMake(kWScare(kH_Space), lineImgView.top, [self getSizeWithString:nianHuaLvLab.text andFont:fontSize].width, lineImgView.height/2);
    [self.view addSubview:nianHuaLvLab];
    
    //lab 字体大小
    NSDictionary* style1 = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:14.0],
                             @"bold":[UIFont fontWithName:@"HelveticaNeue-Bold" size:28.0]
                             };
    NSString *nianRate = [NSString stringWithFormat:@"<bold>%.2f</bold> <body>%%</body>",18.5];
    _yearRateLab = [[UILabel alloc]init];
    _yearRateLab.attributedText = [nianRate attributedStringWithStyleBook:style1];
    _yearRateLab.textColor = KLColor(221, 86, 86);
    _yearRateLab.font = [UIFont systemFontOfSize:fontSize+8];
    _yearRateLab.frame = CGRectMake(nianHuaLvLab.right+5, nianHuaLvLab.top-3, kWidth/2-kWScare(kH_Space)-nianHuaLvLab.width, lineImgView.height/2);
    [self.view addSubview:_yearRateLab];
    
    //编号
    UILabel *biaoNumLab = [[UILabel alloc]init];
    biaoNumLab.text = @"编号:";
    biaoNumLab.font = [UIFont systemFontOfSize:fontSize];
    biaoNumLab.frame = CGRectMake(lineImgView.right+15, lineImgView.top, [self getSizeWithString:biaoNumLab.text andFont:fontSize].width, lineImgView.height/2);
    [self.view addSubview:biaoNumLab];
    
    _numOfBiaoLab = [[UILabel alloc]init];
    _numOfBiaoLab.text = @"";
    _numOfBiaoLab.font = [UIFont systemFontOfSize:fontSize];
    _numOfBiaoLab.frame = CGRectMake(biaoNumLab.right+5, nianHuaLvLab.top, kWidth/2-kWScare(kH_Space)-nianHuaLvLab.width, lineImgView.height/2);
    [self.view addSubview:_numOfBiaoLab];
    
    //募集总额
    UILabel *moneyLab = [[UILabel alloc]init];
    moneyLab.text = @"募集总额:";
    moneyLab.font = [UIFont systemFontOfSize:fontSize];
    moneyLab.frame = CGRectMake(kWScare(kH_Space), nianHuaLvLab.bottom, [self getSizeWithString:moneyLab.text andFont:fontSize].width, lineImgView.height/2);
    [self.view addSubview:moneyLab];
    
    _moneyLab = [[UILabel alloc]init];
    _moneyLab.text = @"0元";
    _moneyLab.font = [UIFont systemFontOfSize:fontSize];
    _moneyLab.frame = CGRectMake(moneyLab.right+5, moneyLab.top, kWidth/2-kWScare(kH_Space)-nianHuaLvLab.width, lineImgView.height/2);
    [self.view addSubview:_moneyLab];
    
    //回款月数
    UILabel *monthLab = [[UILabel alloc]init];
    monthLab.text = @"回款月数:";
    monthLab.font = [UIFont systemFontOfSize:fontSize];
    monthLab.frame = CGRectMake(lineImgView.right+15, moneyLab.top, [self getSizeWithString:monthLab.text andFont:fontSize].width, lineImgView.height/2);
    [self.view addSubview:monthLab];
    
    NSString *month = [NSString stringWithFormat:@"<bold>%d</bold> <body>天</body>",3];
    _backMonthLab = [[UILabel alloc]init];
    _backMonthLab.attributedText = [month attributedStringWithStyleBook:style1];
    _backMonthLab.font = [UIFont systemFontOfSize:fontSize+8];
    _backMonthLab.frame = CGRectMake(monthLab.right+5, moneyLab.top-3, kWidth/2-kWScare(kH_Space)-_backMonthLab.width, lineImgView.height/2);
    [self.view addSubview:_backMonthLab];
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
    _coverView.frame = CGRectMake(0, 0, kWidth, kHeight);
    [self.view addSubview:_coverView];
    _menuView = [MenuView createView];
    _menuView.frame = CGRectMake(0, -kWidth/2*3/4+kNavigtBarH, kWidth, kWidth/2*3/4);
    _menuView.alpha = 0.5;
    __block MenuView *blockMenu = _menuView;
    [UIView animateWithDuration:0.35 animations:^{
        blockMenu.frame = CGRectMake(0, kNavigtBarH, kWidth, kWidth/2*3/4);
        blockMenu.alpha = 1;
    } completion:nil];
    
    [_menuView.activityBtn addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_menuView.wuYeBtn addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_menuView];
    
}

- (void)menuBtnAction:(UIButton *)sender
{
    [self hideMenuView];
    
    if (sender.tag == 0) {
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

//进入体验标
- (void)tiYanAction
{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:kCustomerId]==nil)
    {
        [SVProgressHUD showInfoWithStatus:@"还未登录，去登录或注册" maskType:SVProgressHUDMaskTypeGradient];
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    [self isDidYaoGuo];
}

- (void)isDidYaoGuo
{
    if (_dic[@"ordType"]==nil) {
        
        return;
    }
    //判断是否第1次进入，第一次进入摇一摇获取体验金
    NSDictionary *msgDic = [[NSUserDefaults standardUserDefaults] objectForKey:kUserMsg];
    if ([msgDic[@"allAmt"] integerValue]!=0)
    {
        //去投体验标
        ExpericeBiaoDetailViewController *detailVC = [[ExpericeBiaoDetailViewController alloc]init];
        detailVC.biddingId = _dic[@"biddingId"];
        detailVC.ordType = _dic[@"ordType"];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    else
    {
        //进入摇一摇
        YaoYiYaoViewController *biaoTiYVC =[[YaoYiYaoViewController alloc]init];
        biaoTiYVC.biddingId = _dic[@"biddingId"];
        biaoTiYVC.ordType = _dic[@"ordType"];
        [self.navigationController pushViewController:biaoTiYVC animated:YES];
    }
}

#pragma mark - 根据文字获取视图大小
- (CGSize)getSizeWithString:(NSString *)string andFont:(CGFloat)font
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentLeft;
    
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:style};
    CGSize size = [string sizeWithAttributes:dict];
    return size;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ImagePlayerViewDelegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    // recommend to use SDWebImage lib to load web image
    //    [imageView setImageWithURL:[self.imageURLs objectAtIndex:index] placeholderImage:nil];
    //    imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[imageURLs objectAtIndex:index]]];
//    [imageView sd_setImageWithURL:_imagesMuArray[index] placeholderImage:[UIImage imageNamed:@"banner.png"]];
    imageView.image = [UIImage imageNamed:@"banner.png"];
//    [imageView setImageWithURL:[NSURL URLWithString:_imagesMuArray[index]] placeholderImage:[UIImage imageNamed:@"banner.png"]];
    //    imageView.image = [UIImage imageNamed:@"banner.png"];
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSLog(@"did tap index = %d", (int)index);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
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
