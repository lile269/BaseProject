//
//  DetailTextView.m
//  MSZX
//
//  Created by wenyanjie on 14-7-25.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "DetailTextView.h"

@interface DetailTextView ()
{
    UILabel *detailLabel;
}

@end

@implementation DetailTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithPoint:(CGPoint)point Text:(NSString*)lText
{
    self = [super initWithFrame:CGRectMake(0, 0, 41, 19)];
    if (self) {
        UIImage* bgImage = [MSZXImageManager imageNamed:@"vendor_linegraph_detail_bg"];
        self.backgroundColor = [UIColor colorWithPatternImage:bgImage];
        self.center = CGPointMake(point.x-9.5, point.y-21);
        
        detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.text = lText;
        detailLabel.textColor = [UIColor whiteColor];
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.font = [UIFont systemFontOfSize:10];
        [detailLabel sizeToFit];
        detailLabel.frame = CGRectMake((CGRectGetWidth(self.frame)-CGRectGetWidth(detailLabel.frame)-4)/2, 2,
                                       detailLabel.frame.size.width+4, detailLabel.frame.size.height);
        [self addSubview:detailLabel];
     }
    return self;
}

- (void)setDetailText:(NSString*)text
{
    detailLabel.text = text;
}
@end
