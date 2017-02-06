//
//  SHLineGraphView.h
//  MSZX
//
//  Created by other on 14-7-25.
//  Copyright (c) 2014年 other. All rights reserved.
//

#import "SHLineGraphView.h"
#import "DetailTextView.h"
#import "SHPlot.h"
#import <math.h>
#import <objc/runtime.h>

#define BOTTOM_MARGIN_TO_LEAVE 15.0
#define TOP_MARGIN_TO_LEAVE 10.0
#define INTERVAL_COUNT 4
#define PLOT_WIDTH (self.bounds.size.width - _leftMarginToLeave)

#define kAssociatedPlotObject @"kAssociatedPlotObject"

@interface SHLineGraphView ()
{
    CAShapeLayer *backgroundLayer;
    CAShapeLayer *circleLayer;
    CAShapeLayer *graphLayer;
    
    UIImageView* circleImage;
    UIImageView* separateLine;
    DetailTextView* detailView;

    double xIntervalInPx;
    double yIntervalInPx;
}
@end

@implementation SHLineGraphView
{
  float _leftMarginToLeave;
}

- (instancetype)init {
  if((self = [super init])) {
    [self loadDefaultTheme];
  }
  return self;
}

- (void)awakeFromNib
{
  [self loadDefaultTheme];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self loadDefaultTheme];
    }
    return self;
}

- (void)loadDefaultTheme {
    /**
     *  theme attributes dictionary. you can specify graph theme releated attributes in this dictionary. if this property is
     *  nil, then a default theme setting is applied to the graph.
     */
      _themeAttributes = @{
                           kXAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                           kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                           kYAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                           kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                           kYAxisLabelSideMarginsKey : @10,
                           kPlotBackgroundLineColorKye : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4]
                           };
}

- (void)addPlot:(SHPlot *)newPlot;
{
    if(nil == newPlot) {
       return;
    }
  
    if(_plots == nil){
       _plots = [NSMutableArray array];
    }
    [_plots addObject:newPlot];
}

- (void)setupTheView
{
    for(SHPlot *plot in _plots) {
       [self drawPlotWithPlot:plot];
    }
}

#pragma mark - Actual Plot Drawing Methods

- (void)drawPlotWithPlot:(SHPlot *)plot {
    
  _yAxisRange = [NSNumber numberWithDouble:[plot plottingRangeValues]];

  [self drawYLabels:plot];

  [self drawXLabels:plot];
  
  [self drawLines:plot];
  
  [self drawPlot:plot];
}

- (int)getIndexForValue:(NSNumber*)value forPlot:(SHPlot *)plot
{
    for (int i = 0; i < _xAxisValues.count; i++) {
        NSDictionary* dict = [_xAxisValues objectAtIndex:i];
        __block BOOL foundValue = NO;
        [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSNumber* k = (NSNumber*)key;
            if ([k doubleValue] == [value doubleValue]) {
                foundValue = YES;
                *stop = foundValue;
            }
        }];
        if (foundValue) {
            return i;
        }
    }
    return -1;
}

- (void)drawPlot:(SHPlot *)plot
{
   NSDictionary *theme = plot.plotThemeAttributes;
   //
   backgroundLayer = [CAShapeLayer layer];
   backgroundLayer.frame = self.bounds;
   backgroundLayer.fillColor = ((UIColor *)theme[kPlotFillColorKey]).CGColor;
   backgroundLayer.backgroundColor = [UIColor clearColor].CGColor;
   [backgroundLayer setStrokeColor:[UIColor clearColor].CGColor];
   [backgroundLayer setLineWidth:((NSNumber *)theme[kPlotStrokeWidthKey]).intValue];

   CGMutablePathRef backgroundPath = CGPathCreateMutable();

   //
   circleLayer = [CAShapeLayer layer];
   circleLayer.frame = self.bounds;
   circleLayer.fillColor = ((UIColor *)theme[kPlotPointFillColorKey]).CGColor;
   circleLayer.backgroundColor = [UIColor clearColor].CGColor;
   [circleLayer setStrokeColor:((UIColor *)theme[kPlotPointFillColorKey]).CGColor];
   [circleLayer setLineWidth:((NSNumber *)theme[kPlotStrokeWidthKey]).intValue];
  
   CGMutablePathRef circlePath = CGPathCreateMutable();

   //
   graphLayer = [CAShapeLayer layer];
   graphLayer.frame = self.bounds;
   graphLayer.fillColor = [UIColor clearColor].CGColor;
   graphLayer.backgroundColor = [UIColor clearColor].CGColor;
   [graphLayer setStrokeColor:((UIColor *)theme[kPlotStrokeColorKey]).CGColor];
   [graphLayer setLineWidth:((NSNumber *)theme[kPlotStrokeWidthKey]).intValue];
  
   CGMutablePathRef graphPath = CGPathCreateMutable();
  
   double yRange = [_yAxisRange doubleValue]; // this value will be in dollars
   double yIntervalValue = yRange / INTERVAL_COUNT;
  
   //logic to fill the graph path, ciricle path, background path.
   [plot.plottingValues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       NSDictionary *dic = (NSDictionary *)obj;
    
       __block NSNumber *_key = nil;
       __block NSNumber *_value = nil;
    
       [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
           _key = (NSNumber *)key;
           _value = (NSNumber *)obj;
    }];
    
    int xIndex = [self getIndexForValue:_key forPlot:plot];
    
    //x value
    double height = self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE;
    double y = height - ((height / ([_yAxisRange doubleValue] + yIntervalValue)) * ([_value doubleValue]-plot.minPlottingValue));
    (plot.xPoints[xIndex]).x = ceil((plot.xPoints[xIndex]).x);
    (plot.xPoints[xIndex]).y = ceil(y);
  }];
  
  //move to initial point for path and background.
  CGPathMoveToPoint(graphPath, NULL, plot.xPoints[0].x, plot.xPoints[0].y);
  CGPathMoveToPoint(backgroundPath, NULL, plot.xPoints[0].x, plot.xPoints[0].y);
  
  int count = (int)_xAxisValues.count;
  for(int i=0; i< count; i++){
    CGPoint point = plot.xPoints[i];
    
    CGPathAddLineToPoint(graphPath, NULL, point.x, point.y);
    CGPathAddLineToPoint(backgroundPath, NULL, point.x, point.y);
      //仅绘制最后一个锚点的坐标
      if (i == count-1) {
          CGPathAddEllipseInRect(circlePath, NULL, CGRectMake(point.x - 5, point.y - 5, 10, 10));
      }
  }
  
  //move to initial point for path and background.
  CGPathAddLineToPoint(graphPath, NULL, _leftMarginToLeave + PLOT_WIDTH - xIntervalInPx/2, plot.xPoints[count -1].y);
  CGPathAddLineToPoint(backgroundPath, NULL, _leftMarginToLeave + PLOT_WIDTH - xIntervalInPx/2, plot.xPoints[count - 1].y);
  
  //additional points for background.
  CGPathAddLineToPoint(backgroundPath, NULL, _leftMarginToLeave + PLOT_WIDTH - xIntervalInPx/2, self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE);
  CGPathAddLineToPoint(backgroundPath, NULL, _leftMarginToLeave, self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE);
  CGPathCloseSubpath(backgroundPath);
  
  backgroundLayer.path = backgroundPath;
  graphLayer.path = graphPath;
  circleLayer.path = circlePath;
  
  //animation
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
  animation.duration = 1.0;
  animation.fromValue = @(0.0);
  animation.toValue = @(1.0);
  animation.delegate = self;
  [graphLayer addAnimation:animation forKey:@"strokeEnd"];

  [self.layer addSublayer:graphLayer];
  //[self.layer addSublayer:circleLayer];

  for(int i=0; i < count; i++)
  {
     CGPoint point = plot.xPoints[i];
     UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
     btn.backgroundColor = [UIColor clearColor];
     btn.tag = i;
     btn.frame = CGRectMake(point.x - 20, point.y - 20, 40, 40);
     //[btn addTarget:self action:@selector(pointClicked:) forControlEvents:UIControlEventTouchUpInside];
     objc_setAssociatedObject(btn, kAssociatedPlotObject, plot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
     //[self addSubview:btn];
      
      // 当前的收益率的坐标点单独绘制
      if (i == count-1)
      {
          //坐标点背景图片
          circleImage = [[UIImageView alloc]initWithFrame:CGRectMake(point.x - 6, point.y - 6, 12, 12)];
          circleImage.image = [MSZXImageManager imageNamed:@"vendor_linegraph_circle"];
          circleImage.hidden = YES;
          circleImage.layer.zPosition = 3;
          [self addSubview:circleImage];
          
          //坐标点描述信息Label
          NSDictionary* dic = [plot.plottingValues objectAtIndex:i];
          __block NSNumber *_key = nil;
          __block NSNumber *_value = nil;
          
          [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
              _key = (NSNumber *)key;
              _value = (NSNumber *)obj;
          }];
          
          NSString *text = [NSString stringWithFormat:@"%.3f%@", [_value doubleValue], _yAxisSuffix];
          separateLine = [[UIImageView alloc]initWithFrame:CGRectMake(point.x, 0, 0.5, self.frame.size.height-BOTTOM_MARGIN_TO_LEAVE)];
          separateLine.backgroundColor =  UIColorFromRGBAValue(0xff, 0x6c, 0x32, 0.3);// UIColorFromHexValue(0xff6c32);
          separateLine.hidden = YES;
          [self.layer addSublayer:separateLine.layer];
          
          detailView = [[DetailTextView alloc] initWithPoint:point Text:text];
          detailView.layer.zPosition = 0;
          [self.layer insertSublayer:detailView.layer above:graphLayer];
          detailView.hidden = YES;
      }
   }
}

- (void)drawXLabels:(SHPlot *)plot {
   int xIntervalCount = (int)_xAxisValues.count;
   // 为了美观，x坐标需要向左偏移(xIntervalInPx/2)的距离
   xIntervalInPx = PLOT_WIDTH / (_xAxisValues.count-0.5);
  
   //initialize actual x points values where the circle will be
   plot.xPoints = calloc(xIntervalCount, sizeof(CGPoint));
  
   for(int i = 0; i < xIntervalCount; i++)
   {
       // 每个x坐标向左偏移(xIntervalInPx/2)的距离
       CGPoint currentLabelPoint = CGPointMake((xIntervalInPx * i) + _leftMarginToLeave-(xIntervalInPx/2), self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE);
       CGRect xLabelFrame = CGRectMake(currentLabelPoint.x , currentLabelPoint.y, xIntervalInPx, BOTTOM_MARGIN_TO_LEAVE);

       plot.xPoints[i] = CGPointMake((int) xLabelFrame.origin.x + (xLabelFrame.size.width /2) , (int) 0);

       UILabel *xAxisLabel = [[UILabel alloc] initWithFrame:xLabelFrame];
       xAxisLabel.backgroundColor = [UIColor clearColor];
       xAxisLabel.font = (UIFont *)_themeAttributes[kXAxisLabelFontKey];

       xAxisLabel.textColor = (UIColor *)_themeAttributes[kXAxisLabelColorKey];
       xAxisLabel.textAlignment = NSTextAlignmentCenter;

       NSDictionary *dic = [_xAxisValues objectAtIndex:i];
       __block NSString *xLabel = nil;
       [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
           xLabel = (NSString *)obj;
        }];

       xAxisLabel.text = [NSString stringWithFormat:@"%@", xLabel];
       [self addSubview:xAxisLabel];
   }
}

- (void)drawYLabels:(SHPlot *)plot
{
    // y轴共有(INTERVAL_COUNT +1)个单元的长度
    double yRange = [_yAxisRange doubleValue]; // this value will be in dollars
    double yIntervalValue = yRange / INTERVAL_COUNT;
    // intervalInPx表示每个单元长度对应的像素
    yIntervalInPx = (self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE ) / (INTERVAL_COUNT +1);
  
    NSMutableArray *labelArray = [NSMutableArray array];
    float maxWidth = 0;
  
    for(int i= INTERVAL_COUNT + 1; i >= 0; i--){
    CGPoint currentLinePoint = CGPointMake(_leftMarginToLeave, i * yIntervalInPx);
    CGRect lableFrame = CGRectMake(0, currentLinePoint.y - (yIntervalInPx / 2), 100, yIntervalInPx);
    
        if(i != 0)
        {
            UILabel *yAxisLabel = [[UILabel alloc] initWithFrame:lableFrame];
            yAxisLabel.backgroundColor = [UIColor clearColor];
            yAxisLabel.font = (UIFont *)_themeAttributes[kYAxisLabelFontKey];
            yAxisLabel.textColor = (UIColor *)_themeAttributes[kYAxisLabelColorKey];
            yAxisLabel.textAlignment = NSTextAlignmentCenter;
            float val =  plot.minPlottingValue + (yIntervalValue * (INTERVAL_COUNT + 1 - i));
            if(val > 0){
               yAxisLabel.text = [NSString stringWithFormat:@"%.2f%@", val, _yAxisSuffix];
            }else{
               yAxisLabel.text = [NSString stringWithFormat:@"%.0f", val];
            }
            [yAxisLabel sizeToFit];
            CGRect newLabelFrame = CGRectMake(0, currentLinePoint.y - (yAxisLabel.layer.frame.size.height / 2), yAxisLabel.frame.size.width, yAxisLabel.layer.frame.size.height);
            yAxisLabel.frame = newLabelFrame;
          
            if(newLabelFrame.size.width > maxWidth) {
                maxWidth = newLabelFrame.size.width;
            }
          
            [labelArray addObject:yAxisLabel];
            [self addSubview:yAxisLabel];
            
            // 为了美观，微调y坐标原点的位置
            if (i == INTERVAL_COUNT + 1) {
                CGRect rect = yAxisLabel.frame;
                rect.origin.y -= 2;
                yAxisLabel.frame = rect;
            }
        }
  }
  
  _leftMarginToLeave = maxWidth + [_themeAttributes[kYAxisLabelSideMarginsKey] doubleValue];
  
  for( UILabel *label in labelArray) {
      CGSize newSize = CGSizeMake(_leftMarginToLeave, label.frame.size.height);
      CGRect newFrame = label.frame;
      newFrame.size = newSize;
      label.frame = newFrame;
   }
}

- (void)drawLines:(SHPlot *)plot
{
  CAShapeLayer *linesLayer = [CAShapeLayer layer];
  linesLayer.frame = self.bounds;
  linesLayer.fillColor = [UIColor clearColor].CGColor;
  linesLayer.backgroundColor = [UIColor clearColor].CGColor;
  linesLayer.strokeColor = ((UIColor *)_themeAttributes[kPlotBackgroundLineColorKye]).CGColor;
  linesLayer.lineWidth = 0.5;
  
  CGMutablePathRef linesPath = CGPathCreateMutable();
  
  // 绘制坐标系系统
  double intervalInPx = (self.bounds.size.height - BOTTOM_MARGIN_TO_LEAVE) / (INTERVAL_COUNT + 1);
  for(int i = INTERVAL_COUNT + 1; i > 0; i--)
  {
      CGPoint currentLinePoint = CGPointMake(_leftMarginToLeave, (i * intervalInPx));
      if (i == INTERVAL_COUNT + 1) {
          CGPathMoveToPoint(linesPath, NULL, _leftMarginToLeave, currentLinePoint.y);
          CGPathAddLineToPoint(linesPath, NULL, _leftMarginToLeave + PLOT_WIDTH, currentLinePoint.y);
          continue;
      }
      int gapWidth = 1;
      int dashWidth = 2;
      int offfsetX = currentLinePoint.x;
      for (int j = 0; offfsetX < PLOT_WIDTH + currentLinePoint.x; j++) {
          CGPathMoveToPoint(linesPath, NULL, offfsetX, currentLinePoint.y);
          CGPathAddLineToPoint(linesPath, NULL, offfsetX + dashWidth, currentLinePoint.y);
          offfsetX += (gapWidth + dashWidth);
      }
  }
    
  CGPathMoveToPoint(linesPath, NULL, _leftMarginToLeave, 0);
  CGPathAddLineToPoint(linesPath, NULL, _leftMarginToLeave , self.bounds.size.height-BOTTOM_MARGIN_TO_LEAVE);
  linesLayer.path = linesPath;
  [self.layer addSublayer:linesLayer];
}

#pragma mark - animation delegate
-(void)animationDidStart:(CAAnimation *)anim
{
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //graph绘制动画结束 显示坐标点
    //[self.layer addSublayer:circleLayer];
    [self.layer insertSublayer:backgroundLayer below:graphLayer];

    circleImage.hidden = NO;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.2;
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.7];
    animation.repeatCount = 2;
    animation.autoreverses = YES;
    [circleImage.layer addAnimation:animation forKey:nil];
    
    [UIView animateWithDuration:0.2 animations:^{
        detailView.hidden = NO;
        separateLine.hidden = NO;
        detailView.hidden = NO;
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
        [self addGestureRecognizer:tap];
        
        UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(singlePan:)];
        [self addGestureRecognizer:pan];
    }];
}

/*#pragma mark - UIButton event methods
- (void)pointClicked:(id)sender
{
	@try {
		UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
		lbl.backgroundColor = [UIColor clearColor];
        UIButton *btn = (UIButton *)sender;
		NSUInteger tag = btn.tag;
    
        SHPlot *_plot = objc_getAssociatedObject(btn, kAssociatedPlotObject);
        NSDictionary* dic = [_plot.plottingValues objectAtIndex:tag];
        __block NSNumber *_key = nil;
        __block NSNumber *_value = nil;
        
        [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            _key = (NSNumber *)key;
            _value = (NSNumber *)obj;
        }];
		NSString *text = [NSString stringWithFormat:@"%.3f%%", [_value doubleValue]];
		
		lbl.text = text;
		lbl.textColor = [UIColor whiteColor];
		lbl.textAlignment = NSTextAlignmentCenter;
		lbl.font = (UIFont *)_plot.plotThemeAttributes[kPlotPointValueFontKey];
		[lbl sizeToFit];
		lbl.frame = CGRectMake(0, 0, lbl.frame.size.width + 5, lbl.frame.size.height);
		
		CGPoint point =((UIButton *)sender).center;
		point.y -= 7;
		
		dispatch_async(dispatch_get_main_queue(), ^{
			[PopoverView showPopoverAtPoint:point
                               inView:self
                      withContentView:lbl
                             delegate:nil];
		});
	}
	@catch (NSException *exception) {
		NSLog(@"plotting label is not available for this point");
	}
}*/

#pragma mark - Theme Key Extern Keys
NSString *const kXAxisLabelColorKey         = @"kXAxisLabelColorKey";
NSString *const kXAxisLabelFontKey          = @"kXAxisLabelFontKey";
NSString *const kYAxisLabelColorKey         = @"kYAxisLabelColorKey";
NSString *const kYAxisLabelFontKey          = @"kYAxisLabelFontKey";
NSString *const kYAxisLabelSideMarginsKey   = @"kYAxisLabelSideMarginsKey";
NSString *const kPlotBackgroundLineColorKye = @"kPlotBackgroundLineColorKye";

#pragma mark - TapGesturinzer
-(void)singleTap:(UIGestureRecognizer*)gesture
{
    SHPlot * plot = _plots[0];
    int count = (int)_xAxisValues.count;
    
    circleImage.hidden = YES;

    CGPoint tapPoint = [gesture locationInView:self];
    if (CGRectContainsPoint(self.bounds, tapPoint)) {
        
        if (tapPoint.x < plot.xPoints[0].x && tapPoint.x > plot.xPoints[count-1].x) {
            return;
        }
       
        // 判断坐标点的范围
        int index = (int)((tapPoint.x-plot.xPoints[0].x) / xIntervalInPx);
        double offsetX = tapPoint.x-plot.xPoints[index].x;
        
        if (offsetX / xIntervalInPx > 0.8) {
            index++;
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = separateLine.frame;
            rect.origin.x = plot.xPoints[index].x+1;
            separateLine.frame = rect;
            
            CGPoint point = detailView.center;
            point.x = plot.xPoints[index].x - 9;
            point.y = plot.xPoints[index].y - 21;
            detailView.center = point;
            
            double value = [(NSNumber*)(plot.plottingValues[index][@(index+1)]) doubleValue];
            NSString* text = [ NSString stringWithFormat:@"%.3f%@", value , _yAxisSuffix];
            [detailView setDetailText:text];
            
            rect = circleImage.frame;
            rect.origin.x = plot.xPoints[index].x-5;
            rect.origin.y = plot.xPoints[index].y-6;
            circleImage.frame = rect;
            
        } completion:^(BOOL finished) {
            circleImage.hidden = NO;

        }];
    }
}

-(void)singlePan:(UIPanGestureRecognizer*)gesture
{
    SHPlot * plot = _plots[0];
    int count = (int)_xAxisValues.count;
    
    CGPoint panPoint = [gesture locationInView:self];
    //NSLog(@"%.2f,%.2f", panPoint.x, panPoint.y);
    if(!CGRectContainsPoint(self.bounds, panPoint)){
        return;
    }
    if (panPoint.x < plot.xPoints[0].x-1 || panPoint.x > plot.xPoints[count-1].x+1) {
        return;
    }
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
    }
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        CGRect rect = separateLine.frame;
        rect.origin.x = panPoint.x;
        
        CGPoint beginPoint;
        CGPoint endPoint;
        
        // 判断坐标点的范围
        int index = (int)((panPoint.x-plot.xPoints[0].x) / xIntervalInPx);
        double offsetX = panPoint.x-plot.xPoints[index].x;
        
        if (offsetX / xIntervalInPx > 0.5) {
            index++;
            beginPoint = CGPointMake(plot.xPoints[index-1].x, plot.xPoints[index-1].y);
            endPoint = CGPointMake(plot.xPoints[index].x, plot.xPoints[index].y);
        }else{
            beginPoint = CGPointMake(plot.xPoints[index].x, plot.xPoints[index].y);
            endPoint = CGPointMake(plot.xPoints[index+1].x, plot.xPoints[index+1].y);
        }
        
        CGPoint point = detailView.center;
        point.x = panPoint.x - 10;
        point.y = [SHPlot getYAxisWithLineXAxis:panPoint.x BeginPoint:beginPoint EndPoint:endPoint] - 21;

        
        double value = [(NSNumber*)(plot.plottingValues[index][@(index+1)]) doubleValue];
        NSString* text = [ NSString stringWithFormat:@"%.3f%@", value , _yAxisSuffix];

        
        CGRect circleRect = circleImage.frame;
        circleRect.origin.x = panPoint.x-5;
        circleRect.origin.y = [SHPlot getYAxisWithLineXAxis:panPoint.x BeginPoint:beginPoint EndPoint:endPoint]-6;
        [UIView animateWithDuration:0.2 animations:^{
            separateLine.frame = rect;
            detailView.center = point;
            [detailView setDetailText:text];
            circleImage.frame = circleRect;
        }];
    }
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
        // 判断坐标点的范围
        int index = (int)((panPoint.x-plot.xPoints[0].x) / xIntervalInPx);
        double offsetX = panPoint.x-plot.xPoints[index].x;
        
        if (offsetX / xIntervalInPx > 0.5) {
            index++;
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            CGRect rect = separateLine.frame;
            rect.origin.x = plot.xPoints[index].x+1;
            separateLine.frame = rect;
            
            CGPoint point = detailView.center;
            point.x = plot.xPoints[index].x - 9;
            point.y = plot.xPoints[index].y - 21;
            detailView.center = point;
            
            double value = [(NSNumber*)(plot.plottingValues[index][@(index+1)]) doubleValue];
            NSString* text = [ NSString stringWithFormat:@"%.3f%@", value , _yAxisSuffix];
            [detailView setDetailText:text];
            
            rect = circleImage.frame;
            rect.origin.x = plot.xPoints[index].x-5;
            rect.origin.y = plot.xPoints[index].y-6;
            circleImage.frame = rect;
            
        } completion:^(BOOL finished) {
            circleImage.hidden = NO;
            detailView.hidden = NO;
        }];
    }
}

@end
