//
//  XIBTestCell.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 8/11/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

@protocol PhotoViewDelegate <NSObject>

- (void) showPicture;

@end

@interface PhotoViewCell : UITableViewCell

@property (strong, readwrite, nonatomic) UIImageView *userPhoto;
@property (assign, nonatomic) id<PhotoViewDelegate> delegate;
@end
