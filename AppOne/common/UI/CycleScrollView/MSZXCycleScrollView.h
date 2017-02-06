//
//  MSZXCycleScrollView.h
//  MSZXFramework
//
//  Created by wenyanjie on 15-1-29.
//  Copyright (c) 2015年 wenyanjie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, kScrollDirection)
{
    ScrollDirectionUp,
    ScrollDirectionRight,
};

@class MSZXCycleScrollView;
@protocol MSZXCycleScrollViewDelegate <NSObject>

@optional

/**
 *  CycleScrollView滚动时触发的方法
 *
 *  @param currentPage  当前显示的页数
 *  @param adScrollView adScrollView description
 */
- (void)adScrollViewDidScrollWithCurrentPage:(NSInteger)currentPage adScrollView:(MSZXCycleScrollView *)adScrollView;

/**
 *  点击页面时触发的方法
 *
 *  @param adScrollView adScrollView description
 *  @param contentView  点击的view
 *  @param index        点击view的索引值
 */
- (void)adScrollView:(MSZXCycleScrollView *)adScrollView tapContentView:(UIView *)contentView viewIndex:(NSInteger)index;

@end

@interface MSZXCycleScrollView : UIView <UIScrollViewDelegate>
{
}

/**
 *  要显示的view
 */
@property (nonatomic,strong) NSArray *displayViews;

/**
 *  内容是否需要自动滚动
 */
@property (nonatomic) BOOL autoScroll;

/**
 *  自动滚动的时间间隔
 */
@property (nonatomic) NSTimeInterval autoScrollInterval;

@property (nonatomic,weak) id<MSZXCycleScrollViewDelegate> delegate;

/**
 *  Description
 *
 *  @param frame     frame description
 *  @param array     显示的view数组
 *  @param direction 滚动方向
 *
 *  @return return value description
 */
- (id)initWithFrame:(CGRect)frame contentArray:(NSArray *)array scrollDirection:(kScrollDirection)direction;

/**
 *  暂停滚动
 */
- (void)pauseScroll;

/**
 *  继续滚动
 */
- (void)continueScroll;

@end
