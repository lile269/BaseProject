//
//  XIBTestCell.m
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 8/11/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "PhotoViewCell.h"
#import "SJAvatarBrowser.h"

@implementation PhotoViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
       // self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        self.userPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(mainWidth-90, 10, 60, 60)];
        self.userPhoto.userInteractionEnabled = YES;
        
        UITapGestureRecognizer* pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)];
        [self.userPhoto addGestureRecognizer:pan];
        [self addSubview:self.userPhoto];
            
    }
    return self;
}

-(void)showPicture{
    
    [SJAvatarBrowser showImage:self.userPhoto];
    if([self.delegate respondsToSelector:@selector(showPicture)])
    {
        
        //send the delegate function with the amount entered by the user
        [self.delegate showPicture];
    }

}
@end
