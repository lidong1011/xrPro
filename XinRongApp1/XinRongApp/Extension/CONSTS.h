//
//  CONSTS.h
//  艺甲名妆
//
//  Created by 李冬强 on 15-3-10.
//  Copyright (c) 2014年 ldq. All rights reserved.
//

#ifndef _____CONSTS_h
#define _____CONSTS_h

#ifdef DEBUG

#define MyLog(...) NSLog(__VA_ARGS__)

#else

#define MyLog(...)

#endif

#define kWidth ([UIScreen mainScreen].bounds.size.width)
#define kHeight ([UIScreen mainScreen].bounds.size.height)
//#define kNavigtBarH ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0?64:44)
#define kNavigtBarH (self.navigationController.navigationBar.bottom)
#define kHScare(x) (([UIScreen mainScreen].bounds.size.height*(x))/568)
#define kWScare(x) (([UIScreen mainScreen].bounds.size.width*(x))/320)

//#import "UIImage+StrethImage.h"
#import "UIImage+WB.h"
//#import "KLCoverView.h"
#import "UIBarButtonItem+WB.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "SVProgressHUD.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "UIViewExt.h"
//#import "NSString+Date.h"


// 判断是否为ios7
#define ios7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define kVersion [[[UIDevice currentDevice] systemVersion] floatValue]

// 获得RGB颜色
#define KLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 是否是4寸iPhone
// 是否是4寸iPhone
#define is4Inch ([UIScreen mainScreen].bounds.size.height == 568)
#define isOver3_5Inch ([UIScreen mainScreen].bounds.size.height > 480)

//#define STRONG_NONATOMIC_PROPERTY (@property (nonatomic, strong))
//#define ASSIGN_NONATOMIC_PROPERTY (@property (nonatomic, assign))
//#define WEAK_NONATOMIC_PROPERTY   (@property (nonatomic, weak))


#define kusername @"username"
#define kCustomerId @"customerId"
#define kIsRemembPsd @"isRemembPsd"
#define kUserMsg @"userMsg"


#define kZhuTiColor KLColor(106, 198, 192)

//////接口///
#define kBaseUrl  @"https://www.xr58.com:8443/xr58/apprequest/request?code="
#define kPicUrl  @"https://www.xr58.com:8443/xr58/"


////////////个人中心/////////////////
//注册
#define kRegisterUrl  [kBaseUrl stringByAppendingString:@"userRegister"]

//获取验证码
//https://www.xr58.com:8443/xr58/apprequest/request?code=sendSMS
#define ksendSMSUrl  [kBaseUrl stringByAppendingString:@"sendSMS"]

//登陆
//https://www.xr58.com:8443/xr58/apprequest/request?code=userLogin
#define kLoginUrl  [kBaseUrl stringByAppendingString:@"userLogin"]

//updatePwd  修改密码
//https://www.xr58.com:8443/xr58/apprequest/request?code=updatePwd
#define kupdatePwdUrl  [kBaseUrl stringByAppendingString:@"updatePwd"]

///////////////个人中心 end////////////////////


///////////投资项目//////////////////////

//queryTransfer 标列表
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryTransfer&type=biddingList&pageNo=1&pageSize=100
#define kqueryTransferUrl  [kBaseUrl stringByAppendingString:@"queryTransfer"]

//queryBiddingDetail  标详情
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryBiddingDetail&biddingId=20150321114349593966
#define kqueryBiddingDetailUrl  [kBaseUrl stringByAppendingString:@"queryBiddingDetail"]

//queryTransferDetail  债权详情
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryBiddingDetail&biddingId=20150321114349593966
#define kqueryTransferDetailUrl  [kBaseUrl stringByAppendingString:@"queryTransferDetail"]

//initiativeTender  确认投标
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryBiddingDetail&biddingId=20150321114349593966
#define kinitiativeTenderUrl  [kBaseUrl stringByAppendingString:@"initiativeTender"]

//queryAmt  余额查询
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryAmt&customerId=db4aeea4-687f-4a97-8ee7-69c201cef608
#define kqueryAmtUrl  [kBaseUrl stringByAppendingString:@"queryAmt"]

//creditAssign  债权转让
#define kcreditAssignUrl  [kBaseUrl stringByAppendingString:@"creditAssign"]


///////////投资项目  end//////////////////////



///////////我的账户//////////////////////

//loadCustomer  个人信息获取
//https://www.xr58.com:8443/xr58/apprequest/request?code=loadCustomer&customerId=db4aeea4-687f-4a97-8ee7-69c201cef608
#define kloadCustomerUrl  [kBaseUrl stringByAppendingString:@"loadCustomer"]

//signAt 签到
//https://www.xr58.com:8443/xr58/apprequest/request?code=signAt
#define ksignAtUrl  [kBaseUrl stringByAppendingString:@"signAt"]

//queryBidding  我的投资
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryBidding&customerId=db4aeea4-687f-4a97-8ee7-69c201cef608&type=all&pageNo=1&pageSize=100
#define kqueryBiddingUrl  [kBaseUrl stringByAppendingString:@"queryBidding"]

//queryFunds  交易明细
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryFunds&
#define kqueryFundsUrl  [kBaseUrl stringByAppendingString:@"queryFunds"]

////initiativeTender  确认投标
////https://www.xr58.com:8443/xr58/apprequest/request?code=queryBiddingDetail&biddingId=20150321114349593966
//#define kinitiativeTenderUrl  [kBaseUrl stringByAppendingString:@"initiativeTender"]
//
////queryAmt  余额查询
////https://www.xr58.com:8443/xr58/apprequest/request?code=queryAmt&customerId=db4aeea4-687f-4a97-8ee7-69c201cef608
//#define kqueryAmtUrl  [kBaseUrl stringByAppendingString:@"queryAmt"]


///////////我的账户  end//////////////////////

#endif
