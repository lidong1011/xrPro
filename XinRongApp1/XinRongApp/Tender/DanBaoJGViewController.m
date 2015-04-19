//
//  DanBaoJGViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/10.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "DanBaoJGViewController.h"

@interface DanBaoJGViewController ()
@property (nonatomic, strong) UITextView *textView;
@end

@implementation DanBaoJGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = _titleString;
    [self initSubview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initSubview
{
//    self.view.backgroundColor = KLColor(<#r#>, <#g#>, <#b#>)
    UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    switch (_vCflag) {
        case 0:
            [topBtn setTitle:@"担保机构" forState:UIControlStateNormal];
            break;
        case 1:
            [topBtn setTitle:@"项目描述" forState:UIControlStateNormal];
            break;
        case 2:
            [topBtn setTitle:@"担保意见" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    [topBtn setTitleColor:kZhuTiColor forState:UIControlStateNormal];
    UIImage *btnBgImg = [UIImage imageNamed:@"danBaoTop.9.png"];
    [topBtn setBackgroundImage:btnBgImg forState:UIControlStateNormal];
    //左右间隔
    CGFloat space = 100;
    topBtn.frame = CGRectMake(kWScare(space), kNavigtBarH+20, kWidth-2*kWScare(space), 30);
    [self.view addSubview:topBtn];
    
    //文字
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(kWScare(20), topBtn.bottom+20, kWidth-2*kWScare(20), kHeight-topBtn.bottom)];
    _textView.editable = NO;
//    _textView.text = @"新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展";
    _textView.text = _detailString;
    [self.view addSubview:_textView];
    
    if (_vCflag == 1) {
        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, topBtn.bottom+20, kWidth, kHeight-topBtn.bottom-20)];
        [webView loadHTMLString:_detailString baseURL:nil];
        webView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:webView];
    }
    
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
