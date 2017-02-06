//
//  MSZXNetworkIndicator.m
//  MSZXFramework
//
//  Created by wenyanjie on 14-11-24.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "MSZXNetworkIndicator.h"
#import <UIKit/UIKit.h>

@interface MSZXNetworkIndicator ()

- (void)EnableNetworkActivityIndicator;
- (void)DisableNetworkActivityIndicator;
- (BOOL)isNetworkIndicatorVisible;

@end

@implementation MSZXNetworkIndicator

+ (MSZXNetworkIndicator *)sharedInstance
{
    static MSZXNetworkIndicator *_networkIndicator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _networkIndicator = [[MSZXNetworkIndicator alloc] init];
        
    });
    return _networkIndicator;
}

- (void)startWebviewIndicator
{
    @synchronized(self)
    {
        activeWebviewCount++;
        
        if (![self isNetworkIndicatorVisible])
        {
            [self EnableNetworkActivityIndicator];
        }
    }
}

- (void)stopWebviewIndicator
{
    @synchronized(self)
    {
        activeWebviewCount--;
        if  (activeWebviewCount <= 0)
        {
            [self DisableNetworkActivityIndicator];
            activeWebviewCount = 0;
        }
    }
}

#pragma mark - private method

- (void)EnableNetworkActivityIndicator
{
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
}

- (void)DisableNetworkActivityIndicator
{
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
}

- (BOOL)isNetworkIndicatorVisible
{
    UIApplication* app = [UIApplication sharedApplication];
    return [app isNetworkActivityIndicatorVisible];
}


@end
