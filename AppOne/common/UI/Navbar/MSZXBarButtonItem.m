//
//  MSZXBarButtonItem.m
//  MSZXFramework
//
//  Created by wenyanjie on 14-12-17.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "MSZXBarButtonItem.h"

@implementation MSZXBarButtonItem

- (id)initBackWithTarget:(id)target action:(SEL)action
{
    if (self = [super init])
    {
        self.target = target;
        self.action = action;
        self.style = PPBarButtonItemStyleBack;
        self.image = [MSZXImageManager imageNamed:@"navbarview_navbar_back"];
        self.imageHighlight = [MSZXImageManager imageNamed:@"navbarview_navbar_back"];
    }
    
    return self;
}

-(id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    if (self = [super init])
    {
        
        self.target = target;
        self.action = action;
        self.style = PPBarButtonItemStyleCustom;
        
        if ([title isEqualToString:RIGHT_BUTTON_HOME]){
            
            self.title = title;
            self.image =nil;
            self.imageHighlight = nil;
            
        }else if([title isEqual:RIGHT_BUTTON_HELP]){
            
            self.title = title;
            self.image =[MSZXImageManager imageNamed:@"navbarview_navbar_info"];
            self.imageHighlight =[MSZXImageManager imageNamed:@"navbarview_navbar_info"];
            
        }else
        {
            self.title = title;
            self.image = nil;
            self.imageHighlight = nil;
        }
    }
    return self;
}

@end
