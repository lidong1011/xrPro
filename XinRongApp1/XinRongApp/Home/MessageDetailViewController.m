//
//  MessageDetailViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/23.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController ()
@property (nonatomic, strong) UIView *detailViewBgView;
//@property (nonatomic, strong) UILabel *detailViewBgView;
//@property (nonatomic, strong)  *detailViewBgView;
@end
#define space 15
@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息详情";
    
    [self addSubview];
    [self readedMessageRequest];
}

- (void)addSubview
{
    _detailViewBgView = [[UIView alloc]init];
    
    NSString *string = _dataModel.content;
//    string= @"本息保障-为您的投资保驾护航\n1.A种方式120元/年，对发生逾期后的本金及利息进行垫付最高垫付额为人民币10万元\n2.B种方式200元/年，对发生逾期后的本金及利息进行垫付无最高垫付额\n3.两种方式之间独立，不可补交升级。对于加入了A计划的用户，想要加入B计划时只能重新购买";
    CGFloat fontSize = 16;
    
    //titleLab
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 30)];
    titleLab.text = _dataModel.type;
    titleLab.font = [UIFont systemFontOfSize:fontSize+3];
    [_detailViewBgView addSubview:titleLab];
    
    //timeLab
    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(10, titleLab.bottom, 200, 30)];
    timeLab.text = _dataModel.sdate;
    timeLab.font = [UIFont systemFontOfSize:fontSize];
    [_detailViewBgView addSubview:timeLab];

    UILabel *lab = [[UILabel alloc]init];
    lab.numberOfLines = 0;
    CGRect frame = [self getSizeWithString:string andFont:fontSize];
    lab.frame = CGRectMake(kWScare(10), timeLab.bottom, kWidth-2*kWScare(10), frame.size.height);
    lab.font = [UIFont systemFontOfSize:fontSize];
    lab.text = string;
    
    //msgType
    UILabel *msgType = [[UILabel alloc]initWithFrame:CGRectMake(10, lab.bottom, 80, 30)];
    msgType.text = @"信息类型：";
    msgType.font = [UIFont systemFontOfSize:fontSize];
    [_detailViewBgView addSubview:msgType];
    //cMsgType
    UILabel *cMsgType = [[UILabel alloc]initWithFrame:CGRectMake(msgType.right, lab.bottom, 100, 30)];
    cMsgType.text = _dataModel.type;
    cMsgType.font = [UIFont systemFontOfSize:fontSize];
    [_detailViewBgView addSubview:cMsgType];
    
    //sendMsgPer
    UILabel *sendMsgPer = [[UILabel alloc]initWithFrame:CGRectMake(cMsgType.right, lab.bottom, kWidth-cMsgType.right, 30)];
    sendMsgPer.text = [NSString stringWithFormat:@"发送人：%@",_dataModel.fmuser];
    sendMsgPer.font = [UIFont systemFontOfSize:fontSize];
    [_detailViewBgView addSubview:sendMsgPer];

//    lab.backgroundColor = [UIColor redColor];
    [_detailViewBgView addSubview:lab];
    
    _detailViewBgView.frame = CGRectMake(0, kNavigtBarH, kWidth, lab.bottom);
    [self.view addSubview:_detailViewBgView];
}


- (void)readedMessageRequest
{
//    [SVProgressHUD showWithStatus:@"发送请求中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:_dataModel.msgId forKey:@"msgId"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
//    __weak typeof(self) weakSelf = self;
    [manager POST:kloadMessageUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MyLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
    }];
}

#pragma mark - 根据文字获取视图大小
- (CGRect)getSizeWithString:(NSString *)string andFont:(CGFloat)font
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentCenter;
    
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:style.copy};
    //    CGSize size = [string sizeWithAttributes:dict];
    
    // 计算文字在指定最大宽和高下的真实大小
    // 1000 表示高度不限制
    CGRect rect = [string boundingRectWithSize:CGSizeMake(kWidth-2*kWScare(space), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:NULL];
    return rect;
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
