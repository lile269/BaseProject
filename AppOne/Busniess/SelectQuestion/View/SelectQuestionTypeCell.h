//
//  SelectQuestionTypeCell.h
//  AppOne
//
//  Created by lile on 15/9/14.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import <UIKit/UIKit.h>
#define cellHeight  [[UIScreen mainScreen] bounds].size.height*93/667
@interface SelectQuestionTypeCell : UITableViewCell
@property(nonatomic, strong)  UIImageView *imageView;
@property (copy, nonatomic)  UILabel *txtUnitTittle;
@end
