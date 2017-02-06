//
//  SelectQuestionTypeCell.m
//  AppOne
//
//  Created by lile on 15/9/14.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "SelectQuestionTypeCell.h"


@implementation SelectQuestionTypeCell
@synthesize imageView;
@synthesize txtUnitTittle;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
       
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

//-(void)drawRect:(CGRect)rect{
//    
//    
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
//    
//}

-(void) addCellView{
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, cellHeight/2-23, 84, 46)];
    //imageView.layer.cornerRadius = 23.5;//设置那个圆角的有多圆
    // unitView.layer.borderWidth = 30;//设置边框的宽度，当然可以不要
    //unitView.layer.borderColor = [[UIColor whiteColor] CGColor];
    //imageView.layer.masksToBounds = YES;//设为NO去试试。设置YES是保证添加的图片覆盖视图
    [self addSubview:imageView];
    
    
    txtUnitTittle = [[UILabel alloc]init];
    txtUnitTittle.numberOfLines = 0;// 需要把显示行数设置成无限制
    //txtUnitTittle.font          = [UIFont systemFontOfSize:17];
    txtUnitTittle.textAlignment = NSTextAlignmentLeft;
    txtUnitTittle.font = [UIFont systemFontOfSize:17];
    [self addSubview:txtUnitTittle];
    
    
    
}


@end
