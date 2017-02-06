//
//  UIDevice+Addition.h
//  MSZXFramework
//
//  Created by wenyanjie on 14-11-21.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Addition)

/**
 *  获取设备标识符
 *
 *  @return iOS6以及之后的版本返回IDFA，之前的版本返回OpenUDID
 */
- (NSString *)deviceIdentifier;

@end
