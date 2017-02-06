//
//  CourseListCell.h
//  AppOne
//
//  Created by lile on 15/7/20.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *txtCourseName;
@property (weak, nonatomic) IBOutlet UILabel *txtDone;
@property (weak, nonatomic) IBOutlet UILabel *txtAverageSpeed;

@end
