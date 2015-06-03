//
//  AnimationView.m
//  MyMovie
//
//  Created by wxhl_zy107 on 14-8-27.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import "AnimationView.h"
#import "UIViewExt.h"
@implementation AnimationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //初始化子视图
        [self _initWithSubviews];
    }
    return self;
}

//初始化子视图
- (void)_initWithSubviews {
    //获取文件路径
    NSString *path =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/animation.plist"];
    //获取路径文件内容
    NSDictionary *fileDic = [NSDictionary dictionaryWithContentsOfFile:path];
    //判断文件内容是否为空
//    if (fileDic == nil) {
        //是第一次打开应用程序，开启第一次进入动画
        [self _firstAnimation];
        
        //把文件写入
        fileDic = @{@"animation":@"YES"};
        [fileDic writeToFile:path atomically:YES];
//    } else {
//        //不是第一次打开应用程序.默认动画
////        [self _initWithDefaultAnimation];
//    
//    }
    

}

//第一次进入时的动画效果
- (void)_firstAnimation {
    //创建滑动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    //开启翻页效果
    _scrollView.pagingEnabled = YES;
    //设置背景颜色
    _scrollView.backgroundColor = [UIColor clearColor];
    //设置代理对象
    _scrollView.delegate = self;
    //取消滑动指示器
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    //创建数组保存图片的名字
    NSArray *imageNames = @[@"leadye1.png",@"leadye2.png",@"leadye3.png"];
    //循环创建图片视图
    for (int i = 0; i < imageNames.count; i ++) {
        //创建图片视图
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kWidth, 0, kWidth, self.height)];
        //设置图片
        imageView.image = [UIImage imageNamed:imageNames[i]];
        
        //添加到滑动视图上
        [_scrollView addSubview:imageView];
//        [imageView release];
    }
    //设置视图大小
    _scrollView.contentSize = CGSizeMake((imageNames.count ) * kWidth, 0);
    //把滑动视图添加view上
    [self addSubview:_scrollView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    [self addGestureRecognizer:tap];
    
    //创建页码视图
    _pageImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth - 86.6) / 2.0, kHeight - 13 - 30, 86.5, 13)];
    //设置图片
    _pageImageView.image = [UIImage imageNamed:@"guideProgress1.png"];
    
    [self addSubview:_pageImageView];
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((kWidth-86.5) / 2.0, kHeight - 13 - 30, 86.5, 35)];
    pageControl.numberOfPages = imageNames.count;
    [self addSubview:pageControl];
}

- (void)didTap:(UITapGestureRecognizer *)recognizer
{
    //获取手势在_scrollView上的位置
    CGPoint point = [recognizer locationInView:_scrollView];//已经将偏移量计算在内
    //    CGPoint offset = _scrollView.contentOffset;
    
//    CGFloat x = point.x;// + offset.x;
//    CGFloat y = point.y;
//    for (int i = 0; i < _cellWdiths.count; i++) {
//        NSNumber *w = _cellWdiths[i];
//        x -= [w floatValue]+_widthInterval;
//        if (x < 0)
//        {
//            NSInteger sec = y/(self.bounds.size.height/sectionCount);
//            NSInteger index = i+sec*rowViewCount;
//            if (index<allViewCount) {
//                if (_didSelectedView)
//                {
//                    _didSelectedView(self, index);
//                }
//            }
//            break;
//        }
//    }
    if (pageControl.currentPage == pageControl.numberOfPages-1) {
        _didSelectedView(self,pageControl.currentPage);
    }
}

//默认动画
//- (void)_initWithDefaultAnimation {
//    //判断当前设备屏幕的尺寸,设置图片
//    NSString *imageName = kScreenHeight == 480 ? @"Default.png" :@"Default-568h.png";
//    //创建背景视图
//    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
//    backgroundImageView.image = [UIImage imageNamed:imageName];
//    [self addSubview:backgroundImageView];
//    [backgroundImageView release];
//    
//    //创建开机添加的小视图
//    //获取列数和行数
//    NSInteger lineNum = 4;  //列数
//    NSInteger rowNum = kScreenHeight == 480 ? 6 : 7;  //行数
//    //图片的宽度和高度
//    float imageWidth = kScreenWidth / lineNum;         //宽度
//    float imageHeight = kScreenHeight / rowNum;    //高度
//    
//    //图片的个数
//    _imagesCount = lineNum * rowNum;
//    
//    
//    //定义当前图片的位置
//    float x = 0.0;    //横坐标
//    float y = 0.0;    //纵坐标
//    
//    //循环创建小图标
//    NSMutableArray *imageviews = [NSMutableArray array];
//    for (int i = 0; i < _imagesCount; i ++) {
//        //创建图片视图
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x , y, imageWidth, imageHeight)];
//        //隐藏图片视图
//        imageView.alpha = 0;
//        //添加图片
//        imageView.image = [UIImage imageNamed:[NSString stringWithFormat: @"%d.png",i + 1]];
//        
//        //添加到视图上
//        [self addSubview:imageView];
//        [imageView release];
//        
//        //将图片视图保存到数组中
//        [imageviews addObject:imageView];
//        
//        //设置图片的横坐标和纵坐标
//        if (i < lineNum - 1) {
//            x += imageWidth;
//        } else if (i < (lineNum - 1) + (rowNum - 1)) {
//            y += imageHeight;
//        } else if (i < (lineNum - 1) * 2 + (rowNum - 1)) {
//            x -= imageWidth;
//        } else if (i < (lineNum - 1) * 2 + (rowNum - 1) * 2 - 1) {
//            y -= imageHeight;
//        } else if (i < (lineNum - 1) * 3 + (rowNum - 1) * 2 - 2) {
//            x += imageWidth;
//        } else if (i < (lineNum - 1) * 3 + (rowNum - 1) * 3 - 4) {
//            y += imageHeight;
//        } else if (i < (lineNum - 1) * 4 + (rowNum - 1) * 3 - 6) {
//            x -= imageWidth;
//        } else {
//            y -= imageHeight;
//        }
//    }
//    //将图片视图保存
//    self.imageViews = imageviews;
//    
//    //开始显示动画
//    [self showAnimationImages];
//}

//开始显示图片
- (void)showAnimationImages {
    //动画
    [UIView animateWithDuration:.2 animations:^{
        UIImageView *imageView = self.imageViews[_index];
        imageView.alpha = 1;
    }];
    _index ++;
    
    //递归调用方法
    if (_index < _imagesCount) {
        [self performSelector:@selector(showAnimationImages) withObject:nil afterDelay:.1];
    } else {
        //结束动画
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.5];
    }
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //获取点击视图的索引
    _index = scrollView.contentOffset.x / kWidth;
    //拼接图片的名字
    NSString *imageName = [NSString stringWithFormat:@"guideProgress%d.png",_index + 1];
    //设置页码图片
    _pageImageView.image = [UIImage imageNamed:imageName];
    pageControl.currentPage = _index;
    //超出图片视图范围，页码视图跟着一起移动
    if (scrollView.contentOffset.x >= 4 * kWidth) {
        //超出的距离
        float width = scrollView.contentOffset.x - 4 * kWidth;
        
        //页码视图的位置
        _pageImageView.left = (kWidth - 86.6) / 2.0 - width;
    }
    
    //判断偏移量为最大值的时候
    if (scrollView.contentOffset.x + kWidth >= scrollView.contentSize.width) {
        //滑动视图从视图上延时移除
//        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.2];
    }
}


- (void)dealloc
{
//    [_scrollView release];
    _scrollView = nil;
    
//    [_pageImageView release];
    _pageImageView = nil;
    
//    [_imageViews release];
    _imageViews = nil;
    
//    [super dealloc];
}




@end
