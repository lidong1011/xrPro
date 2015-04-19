//
//  TenderDetailViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/3/31.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "TenderDetailViewController.h"
#import "TenderDetView.h"
@interface TenderDetailViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) UILabel *companyInfoLab;
@end

@implementation TenderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTableView];
}

#pragma mark -添加列表视图
- (void)addTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
    _tableView.tableHeaderView = [TenderDetView createView];
    [self.view addSubview:_tableView];
    [self addTableViewFoot];
}

- (void)addTableViewFoot
{
    UITextView *companyInfoTV = [[UITextView alloc]init];
    NSString *string = @"   新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。";
    companyInfoTV.text = string;
    CGFloat fontSize = 16;
    companyInfoTV.font = [UIFont systemFontOfSize:fontSize];
    companyInfoTV.frame = [self getSizeWithString:string andFont:fontSize];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.numberOfLines = 0;
    CGRect frame = [self getSizeWithString:string andFont:fontSize];
    lab.frame = CGRectMake(0, 0, kWidth, frame.size.height+50);
//    lab.font = [UIFont systemFontOfSize:fontSize];
    lab.text = string;
    _companyInfoLab = lab;
    
    _tableView.tableFooterView = lab;
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
