//
//  BECourseListCell.m
//  AppOne
//
//  Created by lile on 15/9/14.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "BECourseListCell.h"



@implementation BECourseListCell

@synthesize unitView;
@synthesize txtUnitTittle;
@synthesize txtUnitLabel;
@synthesize txtUnitSpec;
@synthesize txtUnitSpec2;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addCellView];

    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    [self setNeedsDisplay];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)drawRect:(CGRect)rect{
 
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//    CGContextFillRect(context, rect);
//    
//    //上分割线，
//    CGContextSetStrokeColorWithColor(context, [UIColor hexFloatColor:@"ffffff"].CGColor);
//    CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
//    
//    //下分割线
//    CGContextSetStrokeColorWithColor(context, [UIColor hexFloatColor:@"e2e2e2"].CGColor);
//    CGContextStrokeRect(context, CGRectMake(5, rect.size.height, rect.size.width - 10, 1));
    
   }

-(void) addCellView{
    unitView = [[UIView alloc]initWithFrame:CGRectMake(15, 23, 46, 46)];
    unitView.layer.cornerRadius = 23;//设置那个圆角的有多圆
    // unitView.layer.borderWidth = 30;//设置边框的宽度，当然可以不要
    //unitView.layer.borderColor = [[UIColor whiteColor] CGColor];
    unitView.layer.masksToBounds = YES;//设为NO去试试。设置YES是保证添加的图片覆盖视图
    [self addSubview:unitView];
    
    txtUnitLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 16, 46, 14)];
    txtUnitLabel.font = [UIFont systemFontOfSize:17];
    txtUnitLabel.textColor = [UIColor whiteColor];
    txtUnitLabel.textAlignment = NSTextAlignmentCenter;
    [unitView addSubview:txtUnitLabel];
    
    
    txtUnitTittle = [[UILabel alloc]init];
    txtUnitTittle.font = [UIFont systemFontOfSize:17];
    [self addSubview:txtUnitTittle];
    
    txtUnitSpec = [[UILabel alloc]init];
    txtUnitSpec.font = [UIFont systemFontOfSize:15];
    //txtUnitSpec.text = @"Listening Activities";
    [self addSubview:txtUnitSpec];
//    
//    txtUnitSpec2 = [[UILabel alloc]initWithFrame:CGRectMake(93*widthRation, 58, 200, 15)];
//    txtUnitSpec2.font = [UIFont systemFontOfSize:14];
//    [self addSubview:txtUnitSpec2];
    
    
}


@end
