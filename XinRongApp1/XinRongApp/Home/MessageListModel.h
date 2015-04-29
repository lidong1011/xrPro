//
//  MessageListModel.h
//  XinRongApp
//
//  Created by 李冬强 on 15/4/23.
//  Copyright (c) 2015年 ldq. All rights reserved.
//
/*{"msgId":"0117a210-ec08-47a6-9f85-d47849be682a","content":"尊敬的客户，您的借款项目[测试小贷公司项目（第1标）]放款完毕，即日开始计息,请按时还款。本笔拆标金额为 200000.00元；实际到账：196000.00;扣费：4000.00。","touser":"af9f1435-d623-4f20-a619-309faad5ef29","fmuser":"000000","sdate":"2015-01-23 15:19:48","isread":0,"type":"放款信息"},"code":"000","msg":"查询成功"}*/
#import "BaseModel.h"

@interface MessageListModel : BaseModel
@property (nonatomic, strong) NSString *msgId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *touser;
@property (nonatomic, strong) NSString *fmuser;
@property (nonatomic, strong) NSString *sdate;
@property (nonatomic, strong) NSNumber *isread;
@property (nonatomic, strong) NSString *type;

@end
