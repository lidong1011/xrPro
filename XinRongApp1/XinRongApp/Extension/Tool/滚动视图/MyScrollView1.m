//
//  MyScrollView1.m
//  滚动视图封装
//
//  Created by apple on 14-10-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "MyScrollView1.h"

@interface MyScrollView1 () <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    NSMutableArray *_cellWdiths;
//    CGFloat _heightOfView;
    NSInteger allViewCount;
    NSInteger rowViewCount;
    NSInteger sectionCount;
}
@end

@implementation MyScrollView1

@synthesize currentPage = _currentPage;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _cellWdiths = [NSMutableArray array];
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;
//        _scrollView.backgroundColor = [UIColor grayColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)didTap:(UITapGestureRecognizer *)recognizer
{
    //获取手势在_scrollView上的位置
    CGPoint point = [recognizer locationInView:_scrollView];//已经将偏移量计算在内
    //    CGPoint offset = _scrollView.contentOffset;
    
    CGFloat x = point.x;// + offset.x;
    CGFloat y = point.y;
    for (int i = 0; i < _cellWdiths.count; i++) {
        NSNumber *w = _cellWdiths[i];
        x -= [w floatValue]+_widthInterval;
        if (x < 0)
        {
            NSInteger sec = y/(self.bounds.size.height/sectionCount);
            NSInteger index = i+sec*rowViewCount;
            if (index<allViewCount) {
                if (_didSelectedView)
                {
                    _didSelectedView(self, index);
                }
            }
            break;
        }
    }
}

- (void)reloadData
{
    //将scrollView上的所有子视图都移除掉
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //获取scrollView上视图的总数等
    allViewCount = _numberOfAllView(self);
    rowViewCount = _numberOfViewAtRow(self);
//    sectionCount = allViewCount%rowViewCount?allViewCount/rowViewCount+1:allViewCount/rowViewCount;
    if (_heightOfView) {
//        _heightOfView
        sectionCount = self.frame.size.height/(_heightOfView+_HeightInterval);
    }
    else
    {
        sectionCount = allViewCount%rowViewCount?allViewCount/rowViewCount+1:allViewCount/rowViewCount;
        _heightOfView = (self.frame.size.height-(sectionCount+1)*_HeightInterval)/sectionCount;
    }
    
    //获取一行的宽度
    CGFloat width = 0;
//    [_cellWdiths addObject:[NSNumber numberWithFloat:width]];
    for (NSInteger i = 0; i < rowViewCount; i++) {
        //获取每个视图的宽度
        CGFloat tmp = _widthForView(self, i);
        //根据宽度计算scrollView的contentSize
        width += tmp;
        
        //保存每个视图的宽度
        
        [_cellWdiths addObject:[NSNumber numberWithFloat:tmp]];
    }
    
    //设置contentSize
    _scrollView.contentSize = CGSizeMake(width+(rowViewCount+1)*_widthInterval, self.frame.size.height);
    
    CGFloat x = _widthInterval;
    for (int i = 0; i < allViewCount; i++)
    {
        //获取每个位置的视图
        UIView *v = _viewForScr(self, i);
        
        //获取每个视图的宽度
        NSNumber *w = _cellWdiths[i%rowViewCount];
        //设置第i个视图的位置和尺寸
        v.frame = CGRectMake(x,_HeightInterval+(_HeightInterval+_heightOfView)*(i/rowViewCount), [w floatValue], _heightOfView);
        MyLog(@"%@",NSStringFromCGRect(v.frame));
        if (i%rowViewCount == rowViewCount-1)
        {
            x = _widthInterval;
        }
        else
        {
            x += [w floatValue]+_widthInterval;
        }
        
        
        //在cell上显示视图
        [_scrollView addSubview:v];
    }
}

- (NSInteger)currentPage
{
    return (_scrollView.contentOffset.x+_widthInterval) / _scrollView.frame.size.width;
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width * currentPage-_widthInterval, 0);
    _currentPage = currentPage;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidEndScroll:)]) {
            [_delegate scrollViewDidEndScroll:self];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidEndScroll:)]) {
        [_delegate scrollViewDidEndScroll:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _scrollView.frame = self.bounds;
    
    [self reloadData];
}

@end
