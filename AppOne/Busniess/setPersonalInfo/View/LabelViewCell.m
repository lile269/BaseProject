//
//  LableViewCell.m
//  AppOne
//
//  Created by lile on 15/8/17.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "LabelViewCell.h"

@implementation LabelViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
       // self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //self.la = [[UIImageView alloc]initWithFrame:CGRectMake(mainWidth-90, 10, 60, 60)];
        _labelContent = [[UILabel alloc]initWithFrame:CGRectMake(mainWidth-200, 7,170,30)];
        //_labelContent.text = self.labelContent;
        _labelContent.textAlignment = NSTextAlignmentRight;
        _labelContent.textColor = [UIColor grayColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self addSubview:_labelContent];
        
    }
    return self;
}
@end
