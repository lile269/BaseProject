//
//  TableViewCell.m
//  AppOne
//
//  Created by lile on 15/7/20.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell
@synthesize imagePhoto;
@synthesize txtNickName;
@synthesize txtDistrict;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
