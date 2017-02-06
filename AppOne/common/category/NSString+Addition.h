//
//  NSString+Addition.h
//  MSZXFramework
//
//  Created by wenyanjie on 14-12-17.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addition)

/**
 *  判断字符串是否为空或nil
 *
 *  @param string 待判断的字符串
 *
 *  @return 结果
 */
+ (BOOL)strNilOrEmpty:(NSString *)aString;

/**
 *  除去字符串开头和末尾的空格
 *
 *  @return 除去空格后的字符串
 */
- (NSString *)trim;

/**
 *  md5转换
 *
 *  @return md5值
 */
- (NSString *)stringMD5;

@end
