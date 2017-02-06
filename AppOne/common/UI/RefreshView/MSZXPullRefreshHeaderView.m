//
//  MSZXPullRefreshHeaderView.m
//  MSZX
//
//  Created by wenyanjie on 14-4-17.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "MSZXPullRefreshHeaderView.h"
#import "MSZXImageManager.h"

@implementation MSZXPullRefreshHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame arrowImageName:[MSZXImageManager imageNamed:@"vendor_blueArrow"]];
    if (self) {
        // Initialization code
    }
    return self;
}
@end
