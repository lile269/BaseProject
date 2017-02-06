//
//  MSZXBaseViewController.h
//  MSZXFramework
//
//  Created by wenyanjie on 14-12-2.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSZXNavBarView.h"

@interface MSZXBaseViewController : UIViewController <UIGestureRecognizerDelegate>

/**
 *  是否隐藏navbar
 */
@property (nonatomic, assign) BOOL isNavbarHidden;

/**
 *  使用自定义的导航栏
 */
@property (nonatomic, strong) MSZXNavBarView *navBarView;

/**
 *  返回controller的可布局视图区域
 *
 *  @return return value description
 */
- (CGRect)contentViewFrame;

/**
 *  初始化返回MSZXNavBarView的默认返回参数
 *
 *  @return return value description
 */
- (MSZXBarButtonItem *)backButtonItem;

/**
 *  导航栏点击默认返回按钮的回调事件
 */
- (void)doNavigationBack;

@end
