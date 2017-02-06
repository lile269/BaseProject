//
//  CourseListHeaderView.m
//  AppOne
//
//  Created by lile on 15/8/3.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "CourseListHeaderView.h"

@implementation CourseListHeaderView
@synthesize progressView;
@synthesize courseTittle;
@synthesize speedLable;
@synthesize questionNum;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    [self addProgressView];
    [self addLableView];
    
    return self;
}

-(void) addProgressView{
    progressView = [[ProgressView alloc] initWithFrame:CGRectMake(15, 10, 60, 60)];
    [self addSubview:progressView];
}
-(void) addLableView{
    courseTittle = [[UILabel alloc] initWithFrame:CGRectMake(84, 10, 270, 21)];
   // courseTittle setFont:[UIFont]
    courseTittle.font = [UIFont systemFontOfSize:17];
    questionNum = [[UILabel alloc] initWithFrame:CGRectMake(84, 48, 105, 21)];
    questionNum.font = [UIFont systemFontOfSize:13];
   
    speedLable = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-105, 48, 95, 21)];
    speedLable.font = [UIFont systemFontOfSize:13];
    
    [self addSubview:courseTittle];
    [self addSubview:speedLable];
    [self addSubview:questionNum];
}

@end
