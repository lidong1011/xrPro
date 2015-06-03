//
//  AnswerViewController.m
//  XinRongApp
//
//  Created by 李冬强 on 15/4/29.
//  Copyright (c) 2015年 ldq. All rights reserved.
//

#import "AnswerViewController.h"

@interface AnswerViewController ()
@property (nonatomic, strong) UILabel *answerTitleLab;
@property (nonatomic, strong) UITextView *textView;
@end

#define kAnswer @"answer"
#define kQuestion @"question"

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"帮助中心";
    self.view.backgroundColor = KLColor(246, 246, 246);
    _answerTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, kNavigtBarH+5, kWidth-30, 45)];
    _answerTitleLab.numberOfLines = 2;
    _answerTitleLab.text = _dic[kQuestion];
    [self.view addSubview:_answerTitleLab];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(12, _answerTitleLab.bottom, kWidth-24, kHeight-_answerTitleLab.bottom)];
    _textView.text = [NSString stringWithFormat:@"    %@",_dic[kAnswer]];
    _textView.backgroundColor = KLColor(246, 246, 246);
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.editable = NO;
    [self.view addSubview:_textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
