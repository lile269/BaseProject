//
//  MSZXLineGraphView.m
//  MSZXFramework
//
//  Created by wenyanjie on 14-12-23.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "MSZXLineGraphView.h"
#import "SHPlot.h"
#import "MSZXDateUtil.h"

@interface MSZXLineGraphView ()

@property (nonatomic, strong) SHPlot *plotView;

- (NSArray *)getLineGraphXAxisValues;
+(NSArray *)getLineGraphXAxisValuesByCount:(NSInteger)count;
@end

@implementation MSZXLineGraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.xAxisValues = [self getLineGraphXAxisValues];
    }
    
    return self;
}
- (void)setPlotValues:(NSArray *)plotArray
{
    SHPlot *tmpPlot = [[SHPlot alloc] init];
    tmpPlot.plottingValues = plotArray;
    [self addPlot:tmpPlot];
    [self setupTheView];
}

- (NSArray*)getLineGraphXAxisValues
{

    
    NSDate *currentDate = [NSDate date];
    NSMutableArray* array = [NSMutableArray array];
    for (NSInteger i = 1; i <= 7; i++)
    {
        NSRange rangeMonth = {5,5};
        NSString *string = [MSZXDateUtil getSeveralDaysLater:-(8-i) fromDate:currentDate];
        NSString *calendarString = [string substringWithRange:rangeMonth];
        [array addObject:@{[NSNumber numberWithInteger:i]:calendarString}];
    }
    return array;
}
+(NSArray *)getLineGraphXAxisValuesByCount:(NSInteger)count{
    NSDate *currentDate = [NSDate date];
  
    NSMutableArray* array = [NSMutableArray array];
    for (NSInteger i = 1; i <= 7; i++)
    {
        NSRange rangeMonth = {5,5};
        NSString *string = [MSZXDateUtil getSeveralDaysLater:-(7-i)-count fromDate:currentDate];
        NSString *calendarString = [string substringWithRange:rangeMonth];
        [array addObject:@{[NSNumber numberWithInteger:i]:calendarString}];
    }
    return array;

}


@end
