//
//  SHPlot.h
//  MSZX
//
//  Created by other on 14-7-25.
//  Copyright (c) 2014年 other. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface SHPlot : NSObject

/**
 *  Array of dictionaries, where the key is the same as the one which you specified in the `xAxisValues` in `SHLineGraphView`, 
 *  the value is the number which will determine the point location along the y-axis line. make sure the values are not 
 *  greater than the `yAxisRange` specified in `SHLineGraphView`.
 */
@property (nonatomic, strong) NSArray *plottingValues;

/**
 *  this is an optional array of `NSString` that specifies the labels to show on the particular points. when user clicks on
 *  a particular points, a popover view is shown and will show the particular label on for that point, that is specified 
 *  in this array.
 */
@property (nonatomic, strong) NSArray *plottingPointsLabels;

/**
 *  for internal use
 */
@property (nonatomic) CGPoint *xPoints;

/**
 *  the dictionary which you can use to assing the theme attributes of the plot. if this property is nil, a default theme
 *  is applied selected and the graph is plotted with those default settings.
 */
@property (nonatomic, strong) NSDictionary *plotThemeAttributes;


@property (nonatomic, assign) double minPlottingValue;

@property (nonatomic, assign) double maxPlottingValue;


-(double)plottingRangeValues;


+(double)getYAxisWithLineXAxis:(double)xAxis BeginPoint:(CGPoint)begin EndPoint:(CGPoint)end;


+(double)getYValueWithLineXAxis:(double)xAxis
                    BeginPoint:(CGPoint)begin EndPoint:(CGPoint)end
                    BeginValue:(double)p1 EndPoint:(double)p2;


//following are the theme keys that you will be using to create the theme of the your grpah plot

/**
 *  plot fill color key. use this to define the fill color of the plot (UIColor*)
 */
UIKIT_EXTERN NSString *const kPlotFillColorKey;

/**
 *  plot stroke width key. use this to define the width of the plotting stroke line (in pixels)
 */
UIKIT_EXTERN NSString *const kPlotStrokeWidthKey;

/**
 *  plot stroke color key. use this to define the stroke color of the plotting line (UIColor*)
 */
UIKIT_EXTERN NSString *const kPlotStrokeColorKey;

/**
 *  plot point fill color key. use this to define the fill color of the point in plot (UIColor*)
 */
UIKIT_EXTERN NSString *const kPlotPointFillColorKey;

/**
 *  plotting point value label font key. use this key to define the font of the plotting point label.
 */
UIKIT_EXTERN NSString *const kPlotPointValueFontKey;

@end
