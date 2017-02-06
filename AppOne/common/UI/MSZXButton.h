//
//  MSZXButton.h
//  MSZX
//
//  Created by wenyanjie on 14-3-24.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 功能:可以便捷的设置按钮的可视区域
 使用场景:按钮的可视区域小于触控区域
 用法:触控区由setFrame:设定,可视区域通过接口setContentArea:设置.
 */
@interface MSZXButton : UIButton
{
    CGRect contentRect;
}

@property(nonatomic) UIEdgeInsets titleLabelEdgeInsets;

/**
 *  相对于button的bounds,设置可视区域
 *
 *  @param areaRect 相对于bounds的可视区域
 */
- (void)setContentArea:(CGRect)areaRect;

@end
