//
//  TableViewCell.h
//  AppOne
//
//  Created by lile on 15/7/20.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagePhoto;
@property (weak, nonatomic) IBOutlet UILabel *txtNickName;
@property (weak, nonatomic) IBOutlet UILabel *txtDistrict;

@end
