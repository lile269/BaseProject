//
//  MSZXPullRefreshFooterView.m
//  MSZX
//
//  Created by wenyanjie on 14-4-17.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "MSZXPullRefreshFooterView.h"
#import "MSZXImageManager.h"

@implementation MSZXPullRefreshFooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame arrowImageName:[MSZXImageManager imageNamed:@"vendor_blueArrow"]];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
