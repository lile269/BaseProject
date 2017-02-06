//
//  MSZXDateUtil.m
//  MSZXFramework
//
//  Created by wenyanjie on 14-12-25.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "MSZXDateUtil.h"

@implementation MSZXDateUtil

+ (NSString *)yesterdayDateString
{
    NSDate *current_date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSHourCalendarUnit|
                                        NSMinuteCalendarUnit|
                                        NSSecondCalendarUnit
                                                   fromDate:current_date];
    [dateComponents setHour:-24];
    [dateComponents setMinute:0];
    [dateComponents setSecond:0];
    
    //昨天的时间
    NSDate *pre_date = [calendar dateByAddingComponents:dateComponents toDate:current_date options:0];
    NSDateFormatter *fotmatter = [[NSDateFormatter alloc] init];
    [fotmatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *preDateStr = [fotmatter stringFromDate:pre_date];
    return preDateStr;
}

+ (NSString *)getSeveralDaysLater:(NSInteger)days fromDate:(NSDate *)startDate
{
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:(NSDayCalendarUnit |
                                                          NSWeekdayCalendarUnit |
                                                          NSMonthCalendarUnit |
                                                          NSYearCalendarUnit)
                                                fromDate:startDate];
    
    NSDateComponents *addComponents = [[NSDateComponents alloc] init];
    [addComponents setDay:days];
    NSDate *previousSeveralDaysDate = [gregorian dateByAddingComponents:addComponents
                                                                 toDate:[gregorian dateFromComponents:components]
                                                                options:0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strResultDate = [formatter stringFromDate:previousSeveralDaysDate];
    
    return strResultDate;
}

+ (NSString *)predayDateString:(NSInteger)days{
    
    NSDate *current_date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSHourCalendarUnit|
                                        NSMinuteCalendarUnit|
                                        NSSecondCalendarUnit
                                                   fromDate:current_date];
    [dateComponents setHour:-24*days];
    [dateComponents setMinute:0];
    [dateComponents setSecond:0];
    
    //昨天的时间
    NSDate *pre_date = [calendar dateByAddingComponents:dateComponents toDate:current_date options:0];
    NSDateFormatter *fotmatter = [[NSDateFormatter alloc] init];
    [fotmatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *preDateStr = [fotmatter stringFromDate:pre_date];
    return preDateStr;

}
+ (NSString *)getpredayDaysLater:(NSInteger)days fromDate:(NSDate *)startDate{
    NSCalendar* gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:(NSDayCalendarUnit |
                                                          NSWeekdayCalendarUnit |
                                                          NSMonthCalendarUnit |
                                                          NSYearCalendarUnit)
                                                fromDate:startDate];
    
    NSDateComponents *addComponents = [[NSDateComponents alloc] init];
    [addComponents setDay:-days-6];
    NSDate *previousSeveralDaysDate = [gregorian dateByAddingComponents:addComponents
                                                                 toDate:[gregorian dateFromComponents:components]
                                                                options:0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strResultDate = [formatter stringFromDate:previousSeveralDaysDate];
    
    return strResultDate;


}
@end
