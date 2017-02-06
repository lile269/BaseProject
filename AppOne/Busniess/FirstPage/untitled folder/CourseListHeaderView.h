//
//  CourseListHeaderView.h
//  AppOne
//
//  Created by lile on 15/8/3.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressView.h"

@interface CourseListHeaderView : UIView

@property (strong,nonatomic) ProgressView * progressView;
@property (strong,nonatomic) UILabel *courseTittle;
@property (strong,nonatomic) UILabel *speedLable;
@property (strong,nonatomic) UILabel *questionNum;
@end
