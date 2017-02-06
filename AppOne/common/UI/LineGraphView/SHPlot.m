//
//  SHPlot.h
//  MSZX
//
//  Created by other on 14-7-25.
//  Copyright (c) 2014年 other. All rights reserved.
//

#import "SHPlot.h"

@interface SHPlot ()

@end

@implementation SHPlot

- (instancetype)init {
  if((self = [super init])) {
    [self loadDefaultTheme];
  }
  return self;
}

- (void)loadDefaultTheme {
    //set plot theme attributes
    
    /**
     *  the dictionary which you can use to assing the theme attributes of the plot. if this property is nil, a default theme
     *  is applied selected and the graph is plotted with those default settings.
     */
    
    _plotThemeAttributes = @{kPlotFillColorKey : [UIColor colorWithRed:0xff/255.0  green:0xda/255.0 blue:0x2d/255.0 alpha:0.15], // 折现区域填充颜色
                             kPlotStrokeWidthKey : @1, // 折现宽度
                             kPlotStrokeColorKey : [UIColor colorWithRed:0xf7/255.0 green:0x97/255.0 blue:0x15/255.0 alpha:1], // 折现颜色
                             kPlotPointFillColorKey : [UIColor colorWithRed:0xee/255.0 green:0xf0/255.0 blue:0xfe/255.0 alpha:1], // 选中点颜色
                             kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]};                              // 选中点字体大小 -- 未使用
}

-(double)plottingRangeValues
{
    if ([_plottingValues count] == 0) {
        return 0;
    }
    
    NSDictionary* dict = _plottingValues[0];
    __block NSNumber *_key = nil;
    __block NSNumber *_value = nil;
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        _key = (NSNumber *)key;
        _value = (NSNumber *)obj;
    }];
    _maxPlottingValue = [_value doubleValue];
    _minPlottingValue = [_value doubleValue];

    for (NSDictionary* dict in _plottingValues) {
        __block NSNumber *_key = nil;
        __block NSNumber *_value = nil;
        
        [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            _key = (NSNumber *)key;
            _value = (NSNumber *)obj;
        }];
        if ([_value doubleValue] > _maxPlottingValue) {
            _maxPlottingValue = [_value doubleValue];
        }
        if ([_value doubleValue] < _minPlottingValue) {
            _minPlottingValue = [_value doubleValue];
        }
    }
    
    double thres = (_maxPlottingValue-_minPlottingValue);
    _maxPlottingValue += thres * 1;
    
    _minPlottingValue -= 5 * thres;
    
    _minPlottingValue = (_minPlottingValue < 0) ? 0 : _minPlottingValue;

    double gapPlottingValue = _maxPlottingValue - _minPlottingValue;
    if (gapPlottingValue > 0.00001)
    {
        return gapPlottingValue;
    }
    else
    {
        return 0.00001;
    }
}

// 根据线段的斜率 获取点坐标
+(double)getYAxisWithLineXAxis:(double)xAxis BeginPoint:(CGPoint)begin EndPoint:(CGPoint)end
{
    double a = begin.x;
    double b = begin.y;
    
    double c = end.x;
    double d = end.y;
    
    if (xAxis == a) {
        return b;
    }else if(xAxis == c){
        return d;
    }else{
        return (xAxis-a)*(d-b)/(c-a)+b;
    }
}

+(double)getYValueWithLineXAxis:(double)xAxis
                     BeginPoint:(CGPoint)begin EndPoint:(CGPoint)end
                     BeginValue:(double)p1 EndPoint:(double)p2
{
    double yAxis = [self getYAxisWithLineXAxis:xAxis BeginPoint:begin EndPoint:end];
    
    double b = begin.y;
    double d = end.y;
    
    if (yAxis == b) {
        return p1;
    }else if(yAxis == d){
        return p2;
    }else{
        return (p1-p2)*(b-yAxis)/(b-d)+p1;
    }
}

#pragma mark - Theme Key Extern Keys
NSString *const kPlotFillColorKey           = @"kPlotFillColorKey";
NSString *const kPlotStrokeWidthKey         = @"kPlotStrokeWidthKey";
NSString *const kPlotStrokeColorKey         = @"kPlotStrokeColorKey";
NSString *const kPlotPointFillColorKey      = @"kPlotPointFillColorKey";
NSString *const kPlotPointValueFontKey      = @"kPlotPointValueFontKey";
@end
