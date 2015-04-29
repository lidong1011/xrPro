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

//losePwd  找回密码
#define klosePwdUrl  [kBaseUrl stringByAppendingString:@"losePwd"]

///////////////个人中心 end////////////////////


///////////投资项目//////////////////////

//queryTransfer 标列表
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryTransfer&type=biddingList&pageNo=1&pageSize=100
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryTransfer&type=personalTransfer&pageNo=1&pageSize=10&statusType=0&customerId=c98a6ffd-8679-4967-ae2d-f419465d9bbc
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



///////////我的账户//////////////////////c98a6ffd-8679-4967-ae2d-f419465d9bbc

//loadCustomer  个人信息获取
//https://www.xr58.com:8443/xr58/apprequest/request?code=loadCustomer&customerId=db4aeea4-687f-4a97-8ee7-69c201cef608
#define kloadCustomerUrl  [kBaseUrl stringByAppendingString:@"loadCustomer"]

//signAt 签到
//https://www.xr58.com:8443/xr58/apprequest/request?code=signAt
#define ksignAtUrl  [kBaseUrl stringByAppendingString:@"signAt"]

//queryBidding  我的投资
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryBidding&customerId=db4aeea4-687f-4a97-8ee7-69c201cef608&type=all&pageNo=1&pageSize=100
#define kqueryBiddingUrl  [kBaseUrl stringByAppendingString:@"queryBidding"]

//toTransfer  转让数据获取
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryBiddingDetail&biddingId=20150321114349593966
#define ktoTransferUrl  [kBaseUrl stringByAppendingString:@"toTransfer"]

//transfer  转让
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryAmt&customerId=db4aeea4-687f-4a97-8ee7-69c201cef608
#define ktransferUrl  [kBaseUrl stringByAppendingString:@"transfer"]

//queryFunds  交易明细
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryFunds&
#define kqueryFundsUrl  [kBaseUrl stringByAppendingString:@"queryFunds"]

//safeplan  本息保障记录
//https://www.xr58.com:8443/xr58/apprequest/request?code=safeplan&customerId=c98a6ffd-8679-4967-ae2d-f419465d9bbc
#define ksafeplanUrl  [kBaseUrl stringByAppendingString:@"safeplan"]

//usrAcctPay4safeplan  加入本息保障
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryFunds&
#define kusrAcctPay4safeplanUrl  [kBaseUrl stringByAppendingString:@"usrAcctPay4safeplan"]

//queryExperience  体验金列表
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryExperience&customerId=c98a6ffd-8679-4967-ae2d-f419465d9bbc
#define kqueryExperienceUrl  [kBaseUrl stringByAppendingString:@"queryExperience"]

//queryPlanHistory   回款计划
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryExperience&customerId=c98a6ffd-8679-4967-ae2d-f419465d9bbc
#define kqueryPlanHistoryUrl  [kBaseUrl stringByAppendingString:@"queryPlanHistory"]

//queryRedPaper  我的红包
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryExperience&customerId=c98a6ffd-8679-4967-ae2d-f419465d9bbc
#define kqueryRedPaperUrl  [kBaseUrl stringByAppendingString:@"queryRedPaper"]

//queryKit  我的卡券
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryExperience&customerId=c98a6ffd-8679-4967-ae2d-f419465d9bbc
#define kqueryKitUrl  [kBaseUrl stringByAppendingString:@"queryKit"]

//checkMobileUnique  检查手机号码注册了没
#define kcheckMobileUniqueUrl  [kBaseUrl stringByAppendingString:@"checkMobileUnique"]

//kitTransfer  加息券转让
#define kkitTransferUrl  [kBaseUrl stringByAppendingString:@"kitTransfer"]

//undoTransferKit  撤销转让
#define kundoTransferKitUrl  [kBaseUrl stringByAppendingString:@"undoTransferKit"]

//kitTransferPay  加息券付款
#define kkitTransferPayUrl  [kBaseUrl stringByAppendingString:@"kitTransferPay"]

//kitTransferCancel  加息券付款取消
#define kkitTransferCancelUrl  [kBaseUrl stringByAppendingString:@"kitTransferCancel"]

//recharge  充值
#define krechargeUrl  [kBaseUrl stringByAppendingString:@"recharge"]

//withdraw  提现
#define kwithdrawUrl  [kBaseUrl stringByAppendingString:@"withdraw"]

//queryCard  银行卡列表
#define kqueryCardUrl  [kBaseUrl stringByAppendingString:@"queryCard"]

//bindCard  绑定银行卡
#define kbindCardUrl  [kBaseUrl stringByAppendingString:@"bindCard"]

//delCard  银行卡删除
#define kdelCardUrl  [kBaseUrl stringByAppendingString:@"delCard"]

//hfUserLogin  登陆汇付
#define khfUserLoginUrl  [kBaseUrl stringByAppendingString:@"hfUserLogin"]

//bandHF  绑定汇付
#define kbindHFUrl  [kBaseUrl stringByAppendingString:@"bindHF"]

//hfAcctModify  修改汇付
#define khfAcctModifyUrl  [kBaseUrl stringByAppendingString:@"hfAcctModify"]

//loadUnReadCount  未读消息条数
#define kloadUnReadCountUrl  [kBaseUrl stringByAppendingString:@"loadUnReadCount"]

//listMessage 消息列表
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryExperience&customerId=c98a6ffd-8679-4967-ae2d-f419465d9bbc
#define klistMessageUrl  [kBaseUrl stringByAppendingString:@"listMessage"]

//loadMessage 消息详情
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryExperience&customerId=c98a6ffd-8679-4967-ae2d-f419465d9bbc
#define kloadMessageUrl  [kBaseUrl stringByAppendingString:@"loadMessage"]

//delMessage 删除消息
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryExperience&customerId=c98a6ffd-8679-4967-ae2d-f419465d9bbc
#define kdelMessageUrl  [kBaseUrl stringByAppendingString:@"delMessage"]

//readedMessage 消息设为已读
//https://www.xr58.com:8443/xr58/apprequest/request?code=queryExperience&customerId=c98a6ffd-8679-4967-ae2d-f419465d9bbc
#define kreadedMessageUrl  [kBaseUrl stringByAppendingString:@"readedMessage"]

//addOpinion  反馈意见
#define kaddOpinionUrl  [kBaseUrl stringByAppendingString:@"addOpinion"]

///////////我的账户  end//////////////////////

#endif
