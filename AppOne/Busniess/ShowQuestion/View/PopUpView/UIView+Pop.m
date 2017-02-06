//
//  UIView+Pop.m
//  模态跳转下滑返回
//
//  Created by GXY on 15/8/3.
//  Copyright (c) 2015年 Tangxianhai. All rights reserved.
//

#import "UIView+Pop.h"

@implementation UIView (Pop)

- (void)showPopUpView:(UIView *)popView Frame:(CGRect)rect {
    popView.frame = rect;
    //popView.top = 50;
    [self addSubview:popView];
    [UIView animateWithDuration:0.3f animations:^{
        popView.top = 80.f;
    }];
}

@end
