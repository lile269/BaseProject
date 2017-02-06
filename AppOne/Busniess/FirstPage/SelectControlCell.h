//
//  SelectControlCellTableViewCell.h
//  AppOne
//
//  Created by lile on 15/8/3.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectControlCellDelegate <NSObject>

- (void)choseTerm:(UIButton *)button course_id:(NSString *)course_id;

@end

@interface SelectControlCell : UITableViewCell
@property (assign, nonatomic) id<SelectControlCellDelegate> delegate;
@property(nonatomic,copy) NSString * courseID;

@end
