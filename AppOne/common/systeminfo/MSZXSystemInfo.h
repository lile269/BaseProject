//
//  MSZXSystemInfo.h
//  MSZX
//
//  Created by wenyanjie on 14-3-24.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSZXSystemInfo : NSObject

#define IOS8_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS7_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS5_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
#define IOS4_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending )
#define IOS3_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"3.0"] != NSOrderedAscending )

#define IOS7_OR_EARLIER		( !IOS8_OR_LATER )
#define IOS6_OR_EARLIER		( !IOS7_OR_LATER )
#define IOS5_OR_EARLIER		( !IOS6_OR_LATER )
#define IOS4_OR_EARLIER		( !IOS5_OR_LATER )
#define IOS3_OR_EARLIER		( !IOS4_OR_LATER )

#define IS_SCREEN_4_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640/2, 1136/2), [[UIScreen mainScreen] bounds].size) : NO)
#define IS_SCREEN_35_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640/2, 960/2),  [[UIScreen mainScreen] bounds].size) : NO)
#define DiffHeight (IS_SCREEN_4_INCH ? 88 : 0) //(1136-960)/2

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

/**
 *  获取设备标识符
 *
 *  @return 设备标示符
 */
+ (NSString *)deviceIdentifier;

/**
 *  获取iOS系统版本号
 *
 *  @return iOS系统版本号
 */
+ (NSString *)iOSVersion;

/**
 *  获取应用版本号
 *
 *  @return 应用版本号
 */
+ (NSString *)appVersion;

/**
 *  获取应用标识符
 *
 *  @return 应用标识符
 */
+ (NSString *)appIdentifier;

/**
 *  获取手机操作系统类型
 *
 *  @return 手机操作系统类型
 */
+ (NSString *)osType;

@end
