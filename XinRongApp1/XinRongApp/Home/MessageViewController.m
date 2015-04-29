//
//  MessageViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/22.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageDetailViewController.h"
#import "MessageListCell.h"
#import "EditMessageListCell.h"
#import "MJRefresh.h"
#import "MessageListModel.h"
@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UIView *bottonView;
@property (nonatomic, weak) UIButton *rightBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tabViewMutArray;
@property (nonatomic, assign) int messagePageNo;

@property (nonatomic, assign) NSInteger dataCount;
@property (nonatomic, strong) NSString *msgId;
@property (nonatomic, strong) UIAlertView *deleteAlert;

@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, assign) BOOL isSeleAll;
@property (nonatomic, weak)   UIButton *selectBtn;
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) NSMutableArray *selectMutArray;
@end

#define kEditBlackTopH 30

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KLColor(246, 246, 246);
    self.navigationItem.title = @"消息中心";
    
    [self initData];
    //初始化试图
    [self initSubview];
    
//    [self getListRequestWithPageNo:1 andPageSize:@"20"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabViewMutArray removeAllObjects];
    _messagePageNo = 1;
    [self getListRequestWithPageNo:1 andPageSize:@"20"];
}

//初始数据
- (void)initData
{
    _messagePageNo = 1;
    _tabViewMutArray = [NSMutableArray array];
    _selectMutArray = [NSMutableArray array];
}

//把视图初始化
- (void)initSubview
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 100, 40, 31);
    //    [rightBtn setBackgroundImage:[UIImage imageNamed:@"person.png"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn setTitle:@"取消" forState:UIControlStateSelected];
    [rightBtn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    _rightBtn = rightBtn;
    
    //列表
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 2, kWidth, kHeight-2) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = KLColor(224, 224, 224);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    //编辑时顶部的全选
    _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavigtBarH, kWidth, kEditBlackTopH)];
    _blackView.backgroundColor = KLColor(29, 28, 40);
    _blackView.hidden = YES;
    [self.view addSubview:_blackView];
    
    UIButton *allSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    allSelectBtn.frame = CGRectMake(15, 5, kEditBlackTopH-10, kEditBlackTopH-10);
    [allSelectBtn setImage:[UIImage imageNamed:@"allseleBg.png"] forState:UIControlStateSelected];
    [allSelectBtn setImage:[UIImage imageNamed:@"allNorm.png"] forState:UIControlStateNormal];
    [allSelectBtn addTarget:self action:@selector(selectAllMsg:) forControlEvents:UIControlEventTouchUpInside];
    [_blackView addSubview:allSelectBtn];
    _selectBtn = allSelectBtn;
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(allSelectBtn.right+10, allSelectBtn.top, 80, allSelectBtn.height)];
    lab.text = @"全部";
    lab.textColor = [UIColor whiteColor];
    [_blackView addSubview:lab];
    
    
    //底部按钮
    _bottonView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight-kHScare(35), kWidth, kHScare(49))];
    //标记为已读
    UIButton *didYiReadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    didYiReadBtn.frame = CGRectMake(0, 0, kWidth/2-1, kHScare(35));
    didYiReadBtn.tag = 0;
    didYiReadBtn.backgroundColor = KLColor(136, 136, 136);
    [didYiReadBtn setTitle:@"全部标记已读" forState:UIControlStateNormal];
    [didYiReadBtn addTarget:self action:@selector(bottonAction:) forControlEvents:UIControlEventTouchUpInside];
    //删除按钮
    UIButton *deleteMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteMessageBtn.frame = CGRectMake(kWidth/2+1, 0, kWidth/2-1, kHScare(35));
    deleteMessageBtn.tag = 1;
    deleteMessageBtn.backgroundColor = KLColor(136, 136, 136);
    [deleteMessageBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteMessageBtn addTarget:self action:@selector(bottonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottonView addSubview:didYiReadBtn];
    [self.bottonView addSubview:deleteMessageBtn];
    [self.view addSubview:_bottonView];
    _bottonView.hidden = YES;
}

- (void)edit:(UIButton *)sender
{
    sender.selected = !sender.selected;
    _isEdit = sender.selected;
    if (sender.selected)
    {
        //显示
        _selectBtn.selected = NO;
        _bottonView.hidden = NO;
        _blackView.hidden = NO;
        _tableView.frame = CGRectMake(0, kEditBlackTopH+2, kWidth, kHeight-2-kEditBlackTopH);
    }
    else
    {
        _bottonView.hidden = YES;
        _blackView.hidden = YES;
        _tableView.frame = CGRectMake(0, 2, kWidth, kHeight-2);
        //退出编辑后把选中
        [_selectMutArray removeAllObjects];
    }
    _isSeleAll = NO;
    [_tableView reloadData];
}

//全选
- (void)selectAllMsg:(UIButton *)sender
{
    sender.selected = !sender.selected;
    _isSeleAll = sender.selected;
//    if (sender.selected) {
//        for(int i=0;i<_tabViewMutArray.count;i++)
//        {
//            [_selectMutArray addObject:@"1"];//0为未选，@“1”为选中；
//        }
//    }
//    else
//    {
//        for(int i=0;i<_tabViewMutArray.count;i++)
//        {
//            [_selectMutArray addObject:@"0"];//0为未选，@“1”为选中；
//        }
//    }
    [self.tableView reloadData];
}

- (void)bottonAction:(UIButton *)sender
{
    if (sender.tag == 0) {
        //全部标记为已读
        [self readedAllMessageRequest];
    }
    else
    {
        //删除选中的消息
        _deleteAlert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定要删除所选消息" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [_deleteAlert show];
        NSString *msgId;
        for (int i=0;i<_selectMutArray.count;i++)
        {
            if ([_selectMutArray[i] isEqualToString:@"1"])
            {
                MessageListModel *datamodel = _tabViewMutArray[i];
                if (msgId==nil) {
                    msgId = datamodel.msgId;
                }
                else
                {
                    msgId = [NSString stringWithFormat:@"%@,%@",msgId,datamodel.msgId];
                }
            }
        }
        _msgId = msgId;
    }
}

- (void)readedAllMessageRequest
{
    [SVProgressHUD showWithStatus:@"发送请求中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    [parameter setObject:custId forKey:kCustomerId];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    __weak typeof(self) weakSelf = self;
    [manager POST:kreadedMessageUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"code"] isEqualToString:@"000"])
        {
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            _messagePageNo = 1;
            [weakSelf getListRequestWithPageNo:1 andPageSize:@"20"];
            [weakSelf.tabViewMutArray removeAllObjects];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
    }];
}

- (void)loadMore
{
    [self getListRequestWithPageNo:(++_messagePageNo) andPageSize:@"20"];
}

#pragma mark - 我的投资请求
- (void)getListRequestWithPageNo:(int)pageNo andPageSize:(NSString *)pageSize
{
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    
    [parameter setObject:custId forKey:kCustomerId];
    [parameter setObject:[NSString stringWithFormat:@"%d",pageNo] forKey:@"pageNo"];
    [parameter setObject:pageSize forKey:@"pageSize"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    [manager POST:klistMessageUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        [_tabViewMutArray removeAllObjects];
        [self.tableView reloadData];
    }];
}

#pragma mark - 注册请求返回数据
- (void)success:(id)response
{
    //把tableView 清空
//    [_tabViewMutArray removeAllObjects];
//    [SVProgressHUD dismiss];
    NSDictionary *dic = (NSDictionary *)response;
    MyLog(@"%@",dic);
    [self.tableView.footer endRefreshing];
    if ([dic[@"code"] isEqualToString:@"000"])
    {
        [SVProgressHUD showImage:[UIImage imageWithName:@"logo_tu"] status:@"获取数据成功" maskType:SVProgressHUDMaskTypeGradient];
        for (NSDictionary *dataDic in dic[@"data"])
        {
            [_tabViewMutArray addObject:[MessageListModel messageWithDict:dataDic]];
        }
        [_tableView reloadData];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
    }
}

#pragma mark 列表数据代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MyLog(@"%ld",_tabViewMutArray.count);
    
    //判断是否还有数据可以加载
    if (_dataCount == _tabViewMutArray.count) {
        [self.tableView.footer noticeNoMoreData];
    }
    _dataCount = _tabViewMutArray.count;
    
//    //
//    for(int i=0;i<_tabViewMutArray.count;i++)
//    {
//        [_selectMutArray addObject:@"0"];//0为未选，@“1”为选中；
//    }
    [_selectMutArray removeAllObjects];
    if (_isSeleAll==NO) {
        for(int i=0;i<_tabViewMutArray.count;i++)
        {
            [_selectMutArray addObject:@"0"];//0为未选，@“1”为选中；
        }
    }
    else
    {
        for(int i=0;i<_tabViewMutArray.count;i++)
        {
            [_selectMutArray addObject:@"1"];//0为未选，@“1”为选中；
        }
    }
    
    return _tabViewMutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isEdit) {
        static NSString *edit_identifier = @"cell";
        EditMessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:edit_identifier];
        if (cell==nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"EditMessageListCell" owner:self options:nil][0];
        }
        //添加数据
        MessageListModel *dataModel = _tabViewMutArray[indexPath.row];
        cell.titleLab.text = dataModel.type;
        cell.infoLab.text = dataModel.content;
        cell.timeLab.text = [dataModel.sdate substringToIndex:10];
        cell.singleSeleBtn.tag = indexPath.row;
        [cell.singleSeleBtn addTarget:self action:@selector(singleSeleBtnAct:) forControlEvents:UIControlEventTouchUpInside];
        switch ([dataModel.isread integerValue]) {
            case 0:
                cell.isNewImgView.image = [UIImage imageWithName:@"newMsg.png"];
                break;
            case 1:
                cell.isNewImgView.image = [UIImage imageWithName:@""];
                break;
            default:
                break;
        }
        
        //判断改cell是否选中
        if([_selectMutArray[indexPath.row] isEqualToString:@"1"])
        {
            cell.singleSeleBtn.selected = YES;
        }
        else
        {
            cell.singleSeleBtn.selected = NO;
        }
        cell.backgroundColor = KLColor(246, 246, 246);
        return cell;
    }
    else
    {
        static NSString *all_identifier = @"cell1";
        MessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:all_identifier];
        if (cell==nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"MessageListCell" owner:self options:nil][0];
        }
        //添加数据
        MessageListModel *dataModel = _tabViewMutArray[indexPath.row];
        cell.titleLab.text = dataModel.type;
        cell.infoLab.text = dataModel.content;
        cell.timeLab.text = [dataModel.sdate substringToIndex:10];
        switch ([dataModel.isread integerValue]) {
            case 0:
                cell.isNewImgView.image = [UIImage imageWithName:@"newMsg.png"];
                break;
            case 1:
                cell.isNewImgView.image = [UIImage imageWithName:@""];
                break;
            default:
                break;
        }
        cell.backgroundColor = KLColor(246, 246, 246);
        return cell;
    }
}

- (void)singleSeleBtnAct:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        //
        [_selectMutArray replaceObjectAtIndex:sender.tag withObject:@"1"];
    }
    else
    {
        [_selectMutArray replaceObjectAtIndex:sender.tag withObject:@"0"];
    }
    _selectBtn.selected = NO;
    MyLog(@"%ld",sender.tag);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isEdit==NO) {
        MessageListModel *dataModel = _tabViewMutArray[indexPath.row];
        MessageDetailViewController *msgDetailVC = [[MessageDetailViewController alloc]init];
        msgDetailVC.dataModel = dataModel;
        [self.navigationController pushViewController:msgDetailVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 82;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageListModel *dataModel = _tabViewMutArray[indexPath.row];
    _msgId = dataModel.msgId;
    _deleteAlert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定要删除该条消息" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [_deleteAlert show];
//    [self deleteMyBankCardRequestWithOpenAcctId:dataModel.msgId];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (alertView!=_deleteAlert)
        {
            [self readedAllMessageRequest];
        }
        else
        {
            [self deleteMessageRequestWithMsgId:_msgId];
        }
    }
}

#pragma mark - 删除我的消息请求
- (void)deleteMessageRequestWithMsgId:(NSString *)msgId
{
    NSString *custId = [[NSUserDefaults standardUserDefaults]stringForKey:kCustomerId];
    
    [SVProgressHUD showWithStatus:@"加载数据中..."];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:custId forKey:@"customerId"];
    
    [parameter setObject:msgId forKey:@"msgIds"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //https请求方式设置
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    [manager POST:kdelMessageUrl parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"code"] isEqualToString:@"000"]) {
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            _messagePageNo = 1;
            [self getListRequestWithPageNo:1 andPageSize:@"20"];
            [self.tabViewMutArray removeAllObjects];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",error);
        
    }];
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
