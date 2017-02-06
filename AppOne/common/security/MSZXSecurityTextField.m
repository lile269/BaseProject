//
//  MSZXSecurityTextField.m
//  MSZXFramework
//
//  Created by wenyanjie on 14-12-8.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "MSZXSecurityTextField.h"

@interface MSZXSecurityTextField ()

-(void)initPassGuardCtrl;

@end

@implementation MSZXSecurityTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initPassGuardCtrl];
        self = [self initWithMode:YES]; //控件中以密文显示
    }
    
    return self;
}

//初始化安全控件
-(void)initPassGuardCtrl
{
    [PassGuardTextField initPassGuardCtrl];
    
    [self setM_bsupportrotate:NO];//是否支持旋转
    [self setM_uiapp:[UIApplication sharedApplication]];
    [self setM_strInput1:kSecurityAesKey];//生产AES加密密钥
    [self setM_strInput2:kSecuritykey];//设置RSA加密公钥
    [self setM_hasstatus:YES];//有无按键状态
    [self setM_strInputR1:@"[0-9A-Za-z]"];//键盘输入正则表达式
    [self setM_strInputR2:@"[0-9A-Za-z]{6,20}"];//文本框匹配的表达式
    [self setM_iMaxLen:20];//最大输入长度
    [self setM_isEnablePaste:NO];//是否允许粘贴
}

// 自定义placeholer的字体和颜色
-(void)drawPlaceholderInRect:(CGRect)rect
{
    CGRect newframe = rect;
    newframe.origin.y += 3;
    rect = newframe;
    [UIColorFromHexValue(0x48567d) setFill];
    [[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:15]];
}

@end
