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
//    self.navigationItem.title = @"法律意见";
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
    [_imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"1.png"]];
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
    _textView.text = @"新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展。新华网北京3月31日电(记者刘华) 国家主席习近平31日在人民大会堂同乌干达总统穆塞韦尼举行会谈。两国元首高度评价中乌友谊和互利合作，同意共同抓住机遇，顺势而为，实现两国发展战略对接，把中乌关系打造成为体现平等互信、合作共赢新型国际伙伴关系的典范，共同推动中非关系向前发展";
    _textView.text = _detailString;
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
