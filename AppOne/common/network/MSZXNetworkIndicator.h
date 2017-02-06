//
//  MSZXNetworkIndicator.h
//  MSZXFramework
//
//  Created by wenyanjie on 14-11-24.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSZXNetworkIndicator : NSObject
{
    NSInteger activeWebviewCount;
}

+ (MSZXNetworkIndicator *)sharedInstance;

/**
 *  增加计数,显示网路访问转动动画
 */
- (void)startWebviewIndicator;

/**
 *  减少计数,如果计数为0,停止网络访问转动动画
 */
- (void)stopWebviewIndicator;

@end
