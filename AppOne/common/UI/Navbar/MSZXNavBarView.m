//
//  MSZXNavBarView.m
//  MSZXFramework
//
//  Created by wenyanjie on 14-12-12.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "MSZXNavBarView.h"

#define LoadingText @"加载中..."

@implementation MSZXNavBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self loadingSubviews];
    }
    return self;
}
-(void)loadingSubviews
{
    CGFloat OriginY = 0.0f;
    if (IOS7_OR_LATER)
    {
        OriginY = STATUS_GAP;
    }
    self.backgroundImageView = [[UIImageView alloc] init];
    self.backgroundImageView.frame = CGRectMake(0, 0, ScreenWidth, 44 + OriginY);
    self.backgroundImageView.userInteractionEnabled = YES;
    self.backgroundImageView.backgroundColor = UIColorFromHexValue(0x4b75cc);
    self.backgroundImageView.hidden = NO;
    
    self.navLabel =[[UILabel alloc] init];
    self.navLabel.text = LoadingText;
    self.navLabel.font = [UIFont systemFontOfSize:22];
    self.navLabel.frame = CGRectMake(44, OriginY, ScreenWidth - 88, 44);
    self.navLabel.textAlignment = NSTextAlignmentCenter;
    self.navLabel.textColor = [UIColor whiteColor];
    self.navLabel.hidden = NO;
    
    self.leftBarButton = [MSZXButton buttonWithType:UIButtonTypeCustom];
    [self.leftBarButton setFrame:CGRectMake( 0, OriginY, 44, 44)];
    [self.leftBarButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.leftBarButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    self.leftBarButton.hidden = YES;
    self.leftBarButton.showsTouchWhenHighlighted = YES;
    
    self.rightBarButton = [MSZXButton buttonWithType:UIButtonTypeCustom];
    [self.rightBarButton setFrame:CGRectMake( 320-44, OriginY, 44, 44)];
    [self.rightBarButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.rightBarButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    self.rightBarButton.hidden = YES;
    self.rightBarButton.showsTouchWhenHighlighted = YES;
    
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.navLabel];
    [self addSubview:self.leftBarButton];
    [self addSubview:self.rightBarButton];
}

-(void)setTitle:(NSString *)aTitle
{
    if (self.title != aTitle)
    {
        _title = aTitle;
        [self setNeedsLayout];
    }
}

-(void)setLeftButtonItem:(MSZXBarButtonItem *)aLeftButtonItem
{
    if (_leftButtonItem != aLeftButtonItem)
    {
        //移除点击事件
        if (_leftButtonItem)
        {
            [self.leftBarButton removeTarget:self.leftButtonItem.target
                                      action:self.leftButtonItem.action
                            forControlEvents:UIControlEventTouchUpInside];
        }
        _leftButtonItem = aLeftButtonItem;
        [self setNeedsLayout];
    }
}

-(void)setRightButtonItem:(MSZXBarButtonItem *)rightButtonItem
{
    if (_rightButtonItem != rightButtonItem)
    {
        if (_rightButtonItem)
        {
            [self.rightBarButton removeTarget:self.rightButtonItem.target
                                       action:_rightButtonItem.action
                             forControlEvents:UIControlEventTouchUpInside];
        }
        _rightButtonItem = rightButtonItem;
        [self setNeedsLayout];
    }
}
-(void)layoutSubviews
{
    if (self.title)
    {
        self.navLabel.text = self.title;
        self.navLabel.hidden = NO;
    }
    else if ([self.navLabel.text isEqualToString:LoadingText])
    {
        self.navLabel.hidden = NO;
    }
    else
    {
        self.navLabel.hidden = YES;
    }

    if (self.leftButtonItem)
    {
        if (self.leftButtonItem.image)
        {
            [self.leftBarButton setBackgroundImage:self.leftButtonItem.image
                                          forState:UIControlStateNormal];
        }
        else
        {
            [self.leftBarButton setBackgroundImage:nil forState:UIControlStateNormal];
        }

        if (self.leftButtonItem.imageHighlight)
        {
            [self.leftBarButton setBackgroundImage:self.leftButtonItem.imageHighlight
                                          forState:UIControlStateHighlighted];
        }
        else
        {
            [self.leftBarButton setBackgroundImage:nil forState:UIControlStateHighlighted];
        }

        if (self.leftButtonItem.style == PPBarButtonItemStyleBack)
        {
            [self.leftBarButton setTitle:@"" forState:UIControlStateNormal];
        }
        else if(self.leftButtonItem.style == PPBarButtonItemStyleBordered)
        {
            if (self.leftButtonItem.title)
            {
                [self.leftBarButton setTitle:self.leftButtonItem.title forState:UIControlStateNormal];
            }
            else
            {
                [self.leftBarButton setTitle:@"" forState:UIControlStateNormal];
            }
        }
        [self.leftBarButton addTarget:self.leftButtonItem.target
                               action:self.leftButtonItem.action
                     forControlEvents:UIControlEventTouchUpInside];
        self.leftBarButton.hidden = NO;
    }
    else
    {
        self.leftBarButton.hidden = YES;
    }

    if (self.rightButtonItem)
    {
        if (self.rightButtonItem.style == PPBarButtonItemStyleCustom)
        {
            if (self.rightButtonItem.title && self.rightButtonItem.image==nil && self.rightButtonItem.imageHighlight==nil)
            {
                [self.rightBarButton setBackgroundImage:nil forState:UIControlStateNormal];
                [self.rightBarButton setBackgroundImage:nil forState:UIControlStateHighlighted];
                
                UIFont *font=[UIFont systemFontOfSize:15.0];
                CGSize labelsize = [self.rightButtonItem.title sizeWithFont:font
                                                          constrainedToSize:CGSizeMake(ScreenWidth, 44)
                                                              lineBreakMode:0];
                if (labelsize.width >44)
                {
                    CGRect newFrame = CGRectMake(ScreenWidth - labelsize.width, 20, labelsize.width, 44);
                    [self.rightBarButton setFrame:newFrame];
                    [self.rightBarButton setTitle:self.rightButtonItem.title forState:UIControlStateNormal];
                    [self.rightBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [self.rightBarButton setContentArea:MSZXCGRectMake(labelsize.width, 44, labelsize.width, 15)];
                }
                else
                {
                
                    [self.rightBarButton setFrame:CGRectMake(ScreenWidth - 44, 20, 44, 44)];
                    [self.rightBarButton setTitle:self.rightButtonItem.title forState:UIControlStateNormal];
                    [self.rightBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
                
                if ([self.rightButtonItem.title isEqualToString:RIGHT_BUTTON_HOME])
                {
                    [self.rightBarButton setTitle:nil forState:UIControlStateNormal];
                }
            }
            else
            {
                [self.rightBarButton setFrame:CGRectMake(ScreenWidth - 44, 20, 44, 44)];
                [self.rightBarButton setTitle:@"" forState:UIControlStateNormal];
                if (self.rightButtonItem.image)
                {
                    [self.rightBarButton setBackgroundImage:self.rightButtonItem.image forState:UIControlStateNormal];
                    [self.rightBarButton setContentArea:MSZXCGRectMake(44, 44, self.rightButtonItem.image.size.width, self.rightButtonItem.image.size.height)];
                }
                else
                {
                    [self.rightBarButton setBackgroundImage:nil forState:UIControlStateNormal];
                }

                if (self.rightButtonItem.imageHighlight)
                {
                    [self.rightBarButton setBackgroundImage:self.rightButtonItem.imageHighlight forState:UIControlStateHighlighted];
                    [self.rightBarButton setContentArea:MSZXCGRectMake(44, 44,self.rightButtonItem.imageHighlight.size.width, self.rightButtonItem.imageHighlight.size.height)];
                }
                else
                {
                    [self.rightBarButton setBackgroundImage:nil forState:UIControlStateHighlighted];
                }
            
                [self.rightBarButton addTarget:self.rightButtonItem.target
                                        action:self.rightButtonItem.action
                              forControlEvents:UIControlEventTouchUpInside];
            }
            self.rightBarButton.hidden = NO;
        }
        else
        {
            self.rightBarButton.hidden = YES;
        }
    }
    [super layoutSubviews];
}


@end
