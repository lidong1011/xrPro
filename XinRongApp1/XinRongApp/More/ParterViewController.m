//
//  ParterViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/25.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "ParterViewController.h"
#import "PartnerDetailViewController.h"
@interface ParterViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *partnerNameArray;
@property (nonatomic, strong) NSArray *partnerUrlArray;
@end

@implementation ParterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"合作伙伴";
    
    //初始化数据
    [self initData];
    //初始化试图
    [self initSubview];
}

- (void)initData
{
    //http://www.chinapnr.com/
    _partnerNameArray = @[@"汇付天下",@"华旅文化",@"电广传媒"];
    _partnerUrlArray = @[@"   2006年7月成立，投资额近10亿元人民币，是位居行业三甲的万亿级资金交易托管平台。国内首个第三方P2P账户系统托管体系的建设者，也是目前p2p资金托管最成熟的托管平台。目前，汇付天下已经为全国逾百万小微企业、国内95%商业银行、数百家领先P2P公司提供综合金融支付服务。",@"   公司前身为长沙华旅船说文化传播有限公司，始建于2007年，后更名为湖南华旅文化旅游产业发展股份有限公司，2014年12月28日成功登陆湖南省股权交易所上市（股票代码600026），是湖南首家成功登陆资本市场的文化旅游企业。\n\
            华旅扎根于旅游产业，主要从事旅游景区的整体策划、规划与设计、旅游景区投资与开发建设、旅游景区功能性创新产品的研发、旅游景区的整体品牌营销运营、旅游产业的中高端管理人才教育培训、5A级旅游景区的托管服务等业务与管理。现股份公司旗下已发展数家子公司：湖南快乐橘洲民俗文化经营有限公司、湖南美芙喜行婚庆文化发展有限公司、湖南天地之间集装箱露营基地经营发展有限公司、北京华旅时代教育咨询有限公司（简称华旅商学院）等等。\
",@"    湖南电广传媒股份有限公司（简称“电广传媒”，证券代码000917）成立于1998年，截止2010年12月31日，公司总资产为115.83亿元，净资产为38.91亿元。 电广传媒的主营业务和经营范围包括：广告发布、代理﹑策划﹑制作，影视节目制作发行和有线电视网络信息传输服务，兼营房地产、旅游﹑会展等业务。 公司辖属广告﹑节目﹑网络三大分公司，依托中国湖南电视台七大媒体的资源优势，拥有中国数亿的电视受众群体和湖南省200多万有线电视用户，形成公司业务的核心竞争力。公司在省内外拥有40多家控股、参股公司，形成以长沙、北京、上海和深圳为区域中心，辐射全国的业务网络，使公司业务得以持续、健康地发展壮大，经过资本扩张，电广传媒正向跨媒体、跨地域、综合性国际传媒产业集团发展。"];
}

//把视图初始化
- (void)initSubview
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

#pragma mark 列表数据代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *const identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    switch (indexPath.row)
    {
        case 0:
        {
//            UIImage *icon = [UIImage imageNamed:@"aboutUs.png"];
//            CGSize iconSize = CGSizeMake(30, 30);
//            UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
//            CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
//            [icon drawInRect:rect];
//            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
            //箭头
            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
            cell.accessoryView = jianTimgView;
            cell.textLabel.text = _partnerNameArray[indexPath.row];
            break;
        }
        case 1:
        {
//            UIImage *icon = [UIImage imageNamed:@"banBenMsg.png"];
//            CGSize iconSize = CGSizeMake(30, 30);
//            UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
//            CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
//            [icon drawInRect:rect];
//            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
            //箭头
            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
            cell.accessoryView = jianTimgView;
            cell.textLabel.text = _partnerNameArray[indexPath.row];
            break;
        }
        case 2:
        {
//            UIImage *icon = [UIImage imageNamed:@"help.png"];
//            CGSize iconSize = CGSizeMake(30, 30);
//            UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
//            CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
//            [icon drawInRect:rect];
//            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
            //箭头
            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
            cell.accessoryView = jianTimgView;
            cell.textLabel.text = _partnerNameArray[indexPath.row];
            break;
        }
        case 3:
        {
//            UIImage *icon = [UIImage imageNamed:@"feedback.png"];
//            CGSize iconSize = CGSizeMake(30, 30);
//            UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
//            CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
//            [icon drawInRect:rect];
//            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
            //箭头
            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
            cell.accessoryView = jianTimgView;
            cell.textLabel.text = _partnerNameArray[indexPath.row];
            break;
        }
        case 4:
        {
//            UIImage *icon = [UIImage imageNamed:@"clear.png"];
//            CGSize iconSize = CGSizeMake(30, 30);
//            UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
//            CGRect rect = CGRectMake(0, 0, iconSize.width, iconSize.height);
//            [icon drawInRect:rect];
//            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
            //箭头
            UIImage *jianTouImg = [UIImage imageNamed:@"jianTou.png"];
            UIImageView *jianTimgView = [[UIImageView alloc]initWithImage:jianTouImg];
            jianTimgView.frame = CGRectMake(0, 0, jianTouImg.size.width/2, jianTouImg.size.height/2);
            cell.accessoryView = jianTimgView;
            cell.textLabel.text = _partnerNameArray[indexPath.row];
            break;
        }
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PartnerDetailViewController *detailVC = [[PartnerDetailViewController alloc]init];
    detailVC.titleString = _partnerNameArray[indexPath.row];
    detailVC.detailString = _partnerUrlArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
