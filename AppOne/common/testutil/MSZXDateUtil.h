//
//  MSZXDateUtil.h
//  MSZXFramework
//
//  Created by wenyanjie on 14-12-25.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSZXDateUtil : NSObject

+ (NSString *)getSeveralDaysLater:(NSInteger)days fromDate:(NSDate *)startDate;
+ (NSString *)yesterdayDateString;

//获取days天前的日期
+(NSString *)predayDateString:(NSInteger)days;
//获取days+7天前的日期
+ (NSString *)getpredayDaysLater:(NSInteger)days fromDate:(NSDate *)startDate;

@end
