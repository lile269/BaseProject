//
//  MSZXNavBarModel.m
//  MSZXFramework
//
//  Created by wenyanjie on 14-12-17.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "MSZXNavBarModel.h"

@implementation MSZXBarButtonModel

-(id)initWithDict:(NSDictionary*)navigatorButtonDict
{
    if (self = [super init])
    {
        NSString *strExist = [navigatorButtonDict objectForKey:@"exist"];
        self.exist = [strExist isEqual:@"true"];
        self.showNo = [navigatorButtonDict objectForKey:@"DoNot"];

        if (self.exist)
        {
            self.name = [navigatorButtonDict objectForKey:@"name"];
            self.func = [navigatorButtonDict objectForKey:@"func"];
        }
        else
        {
            self.name = @"";
            self.func = @"";
        }
    }
    return self;
}

@end

@implementation MSZXNavBarModel

-(id)initWithDict:(NSDictionary*)paraDict
{
    if (self = [super init])
    {
        self.title = [paraDict objectForKey:@"title"];
        
        NSDictionary *dictLeftNavButton = [paraDict objectForKey:@"leftButton"];
        self.leftButton = [[MSZXBarButtonModel alloc] initWithDict:dictLeftNavButton];
        self.theFunc= self.leftButton.func;
        
        NSDictionary *dictRightNavButton = [paraDict objectForKey:@"rightButton"];
        self.rightButton = [[MSZXBarButtonModel alloc] initWithDict:dictRightNavButton];
        self.rightButton = self.rightButton;
    }
    return self;
    
}

@end
