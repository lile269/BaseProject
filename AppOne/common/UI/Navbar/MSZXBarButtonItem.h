//
//  MSZXBarButtonItem.h
//  MSZXFramework
//
//  Created by wenyanjie on 14-12-17.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LEFT_BUTTON_SHOWNO @"showNo"

#define RIGHT_BUTTON_HOME @"home"
#define RIGHT_BUTTON_HELP @"help"

typedef NS_ENUM(NSInteger, MSZXBarButtonItemStyle)
{
    PPBarButtonItemStyleBordered = 0,
    PPBarButtonItemStyleBack,
    PPBarButtonItemStyleCustom,
};

@interface MSZXBarButtonItem : NSObject

@property (nonatomic, copy) NSString *title;  //标题
@property (nonatomic, strong) UIImage *image; //背景
@property (nonatomic, strong) UIImage *imageHighlight;  //高亮背景
@property (nonatomic) SEL action;
@property (nonatomic, strong) id target;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) MSZXBarButtonItemStyle style;

- (id)initBackWithTarget:(id)target action:(SEL)action;
- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
