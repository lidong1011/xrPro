//
//  XinRongInfoViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/25.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "XinRongInfoViewController.h"
#import "CompanyInfoCell.h"

@interface XinRongInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableViewArray;
@end

@implementation XinRongInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于新融";
    
//    NSString *string = @"   新融网（www.xr58.com)成立于2013年3月，公司全称为“衡阳新润民间资本投资服务有限公司”， 是一家经过衡阳市工商行政管理批准成立的合法机构。\n\
//     新融网（www.xr58.com)致力于解决小微企业的资金需求和民间投资者理财需求的信息撮合和网上匹配。新融网运用先进的理念和创新的技术建立了一个安全、高效、诚信、透明的互联网金融平台，规范了个 人借贷行为，让借入者改善生产生活，让借出者增加投资渠道.";
//    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight-kNavigtBarH)];
//    textView.text = string;
//    textView.font = [UIFont systemFontOfSize:18];
//    textView.editable = NO;
//    [self.view addSubview:textView];
    _tableViewArray = [NSMutableArray arrayWithArray:@[@"shuiwuzheng.jpg",@"yinyezhao.jpg",@"fulv_ci.jpg"]];
    [self addTableView];
}

#pragma mark -添加列表视图
- (void)addTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addTableViewHeader];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

- (void)addTableViewHeader
{
    UITextView *companyInfoTV = [[UITextView alloc]init];
    NSString *string = @"       新融网（www.xr58.com)成立于2013年3月，公司全称为“衡阳新润民间资本投资服务有限公司”， 是一家经过衡阳市工商行政管理批准成立的合法机构。\n\
        新融网（www.xr58.com)致力于解决小微企业的资金需求和民间投资者理财需求的信息撮合和网上匹配。新融网运用先进的理念和创新的技术建立了一个安全、高效、诚信、透明的互联网金融平台，规范了个 人借贷行为，让借入者改善生产生活，让借出者增加投资渠道.";
    companyInfoTV.text = string;
    CGFloat fontSize = 16;
    companyInfoTV.font = [UIFont systemFontOfSize:fontSize];
    companyInfoTV.frame = [self getSizeWithString:string andFont:fontSize];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.numberOfLines = 0;
    lab.textColor  = [UIColor grayColor];
    CGRect frame = [self getSizeWithString:string andFont:fontSize];
    lab.frame = CGRectMake(15, 0, kWidth-30, frame.size.height);
    lab.font = [UIFont systemFontOfSize:fontSize];
//    lab.backgroundColor = [UIColor redColor];
    lab.text = string;
    
    _tableView.tableHeaderView = lab;
    //    [_tableView reloadData];
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
    CGRect rect = [string boundingRectWithSize:CGSizeMake(_tableView.width-30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:NULL];
    return rect;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    CompanyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CompanyInfoCell" owner:self options:nil][0];
    }
    cell.imgView.image = [UIImage imageWithName:_tableViewArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //391*268
    return 206;
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
