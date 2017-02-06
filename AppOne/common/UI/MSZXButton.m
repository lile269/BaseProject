//
//  MSZXButton.m
//  MSZX
//
//  Created by wenyanjie on 14-3-24.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "MSZXButton.h"

@implementation MSZXButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    {
        if (self)
        {
            contentRect = CGRectZero;
#ifdef UICONTROLAREA
            self.backgroundColor = [UIColor yellowColor];
#endif
        }
    }
    return self;
}

+ (id)buttonWithType:(UIButtonType)buttonType
{
    id tmp = [super buttonWithType:buttonType];
#ifdef UICONTROLAREA
    [(UIButton *)tmp setBackgroundColor:[UIColor yellowColor]];
#endif
    return tmp;
}

- (void)setContentArea:(CGRect)areaRect
{
    contentRect = areaRect;
}

- (CGRect)backgroundRectForBounds:(CGRect)bounds
{
    if (CGRectIsEmpty(contentRect))
    {
        return bounds;
    }
    else
    {
        return contentRect;
    }
}

- (CGRect)contentRectForBounds:(CGRect)bounds
{
    if (CGRectIsEmpty(contentRect))
    {
        return bounds;
    }
    else
    {
        return contentRect;
    }
}

@end
