//
//  ExamAndPassingCell.h
//  AppOne
//
//  Created by lile on 15/7/21.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamAndPassingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelLeftTime;
@property (weak, nonatomic) IBOutlet UILabel *labelPassingPercent;
@property (weak, nonatomic) IBOutlet UIView *LeftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;

@end
