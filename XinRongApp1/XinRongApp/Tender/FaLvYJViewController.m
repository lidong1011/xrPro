//
//  DanBaoYJViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/13.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "FaLvYJViewController.h"

@interface FaLvYJViewController ()
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation FaLvYJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = _titleString;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    //设置导航栏的背景图片
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
////    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                                     [UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1], UITextAttributeTextColor,
//                                                                     [UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1], UITextAttributeTextShadowColor,
//                                                                     [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
//                                                                     [UIFont fontWithName:@"Arial-Bold" size:0.0], UITextAttributeFont,
//                                                                     nil]];
    [self initSubview];
}

- (void)initSubview
{
    //    self.view.backgroundColor = KLColor(<#r#>, <#g#>, <#b#>)
    UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [topBtn setTitle:@"法律意见" forState:UIControlStateNormal];
    [topBtn setTitleColor:kZhuTiColor forState:UIControlStateNormal];
    UIImage *btnBgImg = [UIImage imageNamed:@"danBaoTop.9.png"];
    [topBtn setBackgroundImage:btnBgImg forState:UIControlStateNormal];
    //左右间隔
    CGFloat space = 100;
//    topBtn.frame = CGRectMake(kWScare(space), kNavigtBarH+20, kWidth-2*kWScare(space), (kWidth-2*kWScare(space)*btnBgImg.size.width/btnBgImg.size.height));
    topBtn.frame = CGRectMake(kWScare(space), kNavigtBarH+20, kWidth-2*kWScare(space), 30);
    [self.view addSubview:topBtn];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, topBtn.size.width, topBtn.size.width)];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"faLv.png"]];
    _imageView.center = CGPointMake(kWidth/2, topBtn.bottom+20+_imageView.size.height/2);
    [self.view addSubview:_imageView];
    
    //线条
    UILabel *topLine = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.top, kWidth, 1)];
    topLine.backgroundColor = kZhuTiColor;
    [self.view addSubview:topLine];
    
    UILabel *bottomLine = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageView.bottom, kWidth, 1)];
    bottomLine.backgroundColor = kZhuTiColor;
    [self.view addSubview:bottomLine];
    
    UILabel *leftLine = [[UILabel alloc]initWithFrame:CGRectMake(_imageView.left-1 , _imageView.top, 1, _imageView.height)];
    leftLine.backgroundColor = kZhuTiColor;
    [self.view addSubview:leftLine];
    
    UILabel *rightLine = [[UILabel alloc]initWithFrame:CGRectMake(_imageView.right, _imageView.top, 1, _imageView.height)];
    rightLine.backgroundColor = kZhuTiColor;
    [self.view addSubview:rightLine];

    
    
    //文字
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(kWScare(20), _imageView.bottom+20, kWidth-2*kWScare(20), kHeight-_imageView.bottom-20)];
    _textView.editable = NO;
//    _textView.text = @"新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展";
    _textView.text = _detailString;
    if (_isTiYanBiao) {
        _textView.text = @"湖南芙蓉律师事务所的前身为直属长沙市司法局的长沙市法律顾问处， 1991年法律法律顾问处改制为律师事务所,更名为“长沙市第一律师事务所”， 1996年根据《律师法》的规范要求更名为现用名“湖南芙蓉律师事务所”，是省内成立最早的国办综合法律服务机构之一， 2009年改制为合伙制律师事务所。基于芙蓉律师于法律业务、律师事务所管理和社会活动诸多领域皆有卓越表现，获得业内和社会的广泛赞同， 事务所被多次评为“湖南省优秀律师事务所”、“长沙市优秀律师事务所”。芙蓉律师曾办理过数千件诉讼、仲裁和非诉讼法律案件， 代理案件具有较高的社会关注度，部分案件曾被评为优秀案例或被作为经典案例列入有关数据库。芙蓉具有提供综合性法律业务服务的出色能力， 芙蓉律师的业务操作水准和案件解决结果始终获得高度评价，在疑难、复杂、跨专业诉讼及非诉讼领域，芙蓉都享有很高的信誉。";
    }
    [self.view addSubview:_textView];
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
