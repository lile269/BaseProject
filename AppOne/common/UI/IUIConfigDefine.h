//
//  IUIConfigDefine.h
//  MSZXFramework
//
//  Created by wenyanjie on 14-12-2.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#ifndef MSZXFramework_IUIConfigDefine_h
#define MSZXFramework_IUIConfigDefine_h

#import "MSZXButton.h"
#import "MSZXBaseViewController.h"
#import "MSZXBaseScrollViewController.h"
#import "MSZXWebViewController.h"
#import "MSZXLineGraphView.h"

#define UIColorFromHexValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBAValue(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define VIEWCONTROLLERBACKGROUNDCOLOR UIColorFromHexValue(0xf5f7fb)

#define MSZXCGRectMake(w,h,x,y) CGRectMake(((w)-(x))/2, ((h)-(y))/2, (x), (y) )

typedef NS_ENUM(NSInteger, TestToolbarTag)
{
    TOOLBAR_TAG_FIRST = 0x0001000,
    TOOLBAR_TAG_SECOND,
    TOOLBAR_TAG_THIRD,
    TOOLBAR_TAG_FOURTH,
};

#define NAV_BAR_HEIGHT 44
#define STATUS_GAP 20
#define NAV_BAR_FRAME (IOS7_OR_LATER? CGRectMake(0, 0, ScreenWidth, NAV_BAR_HEIGHT + STATUS_GAP):CGRectMake(0, 0, ScreenWidth, NAV_BAR_HEIGHT))

#define TOOLBAR_HEIGHT 48

#endif
