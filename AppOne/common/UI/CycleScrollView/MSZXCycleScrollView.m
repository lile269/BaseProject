//
//  MSZXCycleScrollView.m
//  MSZXFramework
//
//  Created by wenyanjie on 15-1-29.
//  Copyright (c) 2015年 wenyanjie. All rights reserved.
//

#import "MSZXCycleScrollView.h"

@interface MSZXCycleScrollView ()
{
    NSInteger currentContentPage_;
    NSInteger pageCount_;
    UIScrollView *scrollView_;
    kScrollDirection scrollDirection;
}

@property (nonatomic, strong) NSTimer *timer;

- (void)refreshScrollView;
- (NSArray *)curDisplayViewsWithCurPage:(NSInteger)currentPage;
- (NSInteger)pageNumber:(NSInteger)num;
- (void)timerAutoScroll:(NSTimer *)sender;
- (void)fireTimer;
- (UIView *)duplicate:(UIView*)view;
- (void)tapGesture:(UITapGestureRecognizer *)sender;

@end

@implementation MSZXCycleScrollView

- (void)dealloc
{
    self.displayViews = nil;
    self.timer = nil;
}

-(id)initWithFrame:(CGRect)frame contentArray:(NSArray *)array scrollDirection:(kScrollDirection)direction
{
    self = [super initWithFrame:frame];
    if (self) {
        self.displayViews = array ;
        currentContentPage_ = 0;
        pageCount_ = _displayViews.count;
        scrollDirection = direction;
        [self initScrollView];
    }
    return self;
}

- (void)initScrollView {
    
    scrollView_ = [[UIScrollView alloc] initWithFrame:CGRectZero];
    scrollView_.pagingEnabled = YES;
    scrollView_.showsHorizontalScrollIndicator = NO;
    scrollView_.showsVerticalScrollIndicator = NO;
    scrollView_.delegate = self;
    [self addSubview:scrollView_];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(tapGesture:)];
    [self addGestureRecognizer:tapGesture];
    
}

- (void)layoutSubviews
{
    [scrollView_ setFrame:self.bounds];
    
    CGSize contentSize = CGSizeZero;
    if (scrollDirection == ScrollDirectionRight)
    {
        contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
    }
    else if(scrollDirection == ScrollDirectionUp)
    {
        contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height * 3);
    }
    
    scrollView_.contentSize = contentSize;
    
    [self refreshScrollView];
}

#pragma mark - public methods
- (void)pauseScroll
{
    if (self.timer.isValid)
    {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)continueScroll
{
    if (self.timer.isValid)
    {
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.autoScrollInterval]];
    }
}

#pragma mark - set method

- (void)setAutoScroll:(BOOL)isAutoScroll
{
    if (_autoScroll != isAutoScroll)
    {
        _autoScroll = isAutoScroll;
        
        //如果只有一张图片,禁止滚动
        if (_displayViews.count == 1)
        {
            _autoScroll = NO;
            scrollView_.scrollEnabled = NO;
        }
        else
        {
            scrollView_.scrollEnabled = YES;
        }
        
        if (_autoScroll)
        {
            [self fireTimer];
        }
    }
}

- (void)setAutoScrollInterval:(NSTimeInterval)autoScrollInterval
{
    if (_autoScrollInterval != autoScrollInterval)
    {
        _autoScrollInterval = autoScrollInterval;
        [self fireTimer];
    }
}

#pragma mark - private methods

- (void)refreshScrollView
{
    
    NSArray *subViews = scrollView_.subviews;
    [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSMutableArray *currentViews = [[NSMutableArray alloc] init];
    [currentViews setArray:[self curDisplayViewsWithCurPage:currentContentPage_]];
    
    int count = (int)currentViews.count;
    for (NSInteger i = 0;i < count;i ++)
    {
        UIView *aView = [self duplicate:[currentViews objectAtIndex:i]];
        
        if (scrollDirection == ScrollDirectionRight)
        {
            aView.frame = CGRectMake(self.bounds.size.width * i,
                                     0,
                                     self.bounds.size.width,
                                     self.bounds.size.height);
        }
        else if (scrollDirection == ScrollDirectionUp)
        {
            aView.frame = CGRectMake(0,
                                     self.bounds.size.height * i,
                                     self.bounds.size.width,
                                     self.bounds.size.height);
        }
        
        [scrollView_ addSubview:aView];
    }
    
    if (scrollDirection == ScrollDirectionRight)
    {
        [scrollView_ setContentOffset:CGPointMake(self.bounds.size.width, 0.0f)];
    }
    else if (scrollDirection == ScrollDirectionUp)
    {
        [scrollView_ setContentOffset:CGPointMake(0.0f, self.bounds.size.height)];
    }
    
}

- (NSArray *)curDisplayViewsWithCurPage:(NSInteger)currentPage
{
    NSInteger backPage = [self pageNumber:currentPage - 1];
    NSInteger forwardPage = [self pageNumber:currentPage + 1];
    
    NSMutableArray *currentViews = [[NSMutableArray alloc] init];
    
    UIView *backPageView = [_displayViews objectAtIndex:backPage];
    UIView *curPageView = [_displayViews objectAtIndex:currentPage];
    UIView *forwardPageView = [_displayViews objectAtIndex:forwardPage];
    
    [currentViews addObject:backPageView];
    [currentViews addObject:curPageView];
    [currentViews addObject:forwardPageView];
    
    return currentViews;
}


- (NSInteger)pageNumber:(NSInteger)num
{
    NSInteger temp = 0;
    
    if (num == -1)
    {
        temp = pageCount_ - 1;
    }
    else if (num == pageCount_)
    {
        temp = 0;
    }
    else
    {
        temp = num;
    }
    
    return temp;
}

- (void)timerAutoScroll:(NSTimer *)sender
{
    
    if (scrollDirection == ScrollDirectionRight)
    {
        [scrollView_ setContentOffset:CGPointMake(self.bounds.size.width * 2, 0.0f)
                             animated:YES];
    }
    else if (scrollDirection == ScrollDirectionUp)
    {
        [scrollView_ setContentOffset:CGPointMake(0.0f, self.bounds.size.height * 2)
                             animated:YES];
    }
}

- (void)fireTimer
{
    if (self.autoScroll && self.autoScrollInterval != 0)
    {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollInterval
                                                      target:self
                                                    selector:@selector(timerAutoScroll:)
                                                    userInfo:nil
                                                     repeats:YES];
        
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.autoScrollInterval]];
    }
}

- (UIView *)duplicate:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

- (void)tapGesture:(UITapGestureRecognizer *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(adScrollView:tapContentView:viewIndex:)])
    {
        [self.delegate adScrollView:self
                     tapContentView:[self.displayViews objectAtIndex:currentContentPage_]
                          viewIndex:currentContentPage_];
    }
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollDirection == ScrollDirectionRight)
    {
        CGFloat offset = scrollView.contentOffset.x;
        
        if(offset >= (2 * scrollView_.bounds.size.width))
        {
            currentContentPage_ = [self pageNumber:currentContentPage_ + 1];
            [self refreshScrollView];
        }
        else if(offset <= 0)
        {
            currentContentPage_ = [self pageNumber:currentContentPage_ - 1];
            [self refreshScrollView];
        }
    }
    else if (scrollDirection == ScrollDirectionUp)
    {
        CGFloat offset = scrollView.contentOffset.y;
        
        if (offset >= 2 * scrollView_.bounds.size.height)
        {
            currentContentPage_ = [self pageNumber:currentContentPage_ + 1];
            [self refreshScrollView];
        }
        else if (offset <= 0)
        {
            currentContentPage_ = [self pageNumber:currentContentPage_ - 1];
            [self refreshScrollView];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(adScrollViewDidScrollWithCurrentPage:adScrollView:)])
    {
        [self.delegate adScrollViewDidScrollWithCurrentPage:currentContentPage_ adScrollView:self];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.timer.isValid == YES)
    {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.autoScrollInterval]];
}

@end
