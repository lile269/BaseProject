//
//  MSZXReachability.m
//  MSZXFramework
//
//  Created by wenyanjie on 14-11-24.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//
#import "MSZXLog.h"
#import "MSZXReachability.h"
#import "Reachability.h"
#import <net/if.h>
#import <arpa/inet.h>
#import <ifaddrs.h>

@interface MSZXReachability()
{
    Reachability *	_reach;
}

- (BOOL)isReachable;
- (BOOL)isReachableViaWIFI;
- (BOOL)isReachableViaWLAN;

- (void)networkReachabilityChanged:(NSNotification* )indicator;

@end


@implementation MSZXReachability

+ (MSZXReachability *)sharedInstance
{
    static MSZXReachability *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[MSZXReachability alloc] init];
        
    });
    return _instance;
}


- (id)init
{
    self = [super init];
    if ( self )
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(networkReachabilityChanged:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
        _reach = [Reachability reachabilityForInternetConnection];
        [_reach startNotifier];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (BOOL)isReachable
{
    return [[MSZXReachability sharedInstance] isReachable];
}

- (BOOL)isReachable
{
    return [_reach isReachable];
}

+ (BOOL)isReachableViaWIFI
{
    return [[MSZXReachability sharedInstance] isReachableViaWIFI];
}

- (BOOL)isReachableViaWIFI
{
    if ( NO == [_reach isReachable] )
    {
        return NO;
    }
    
    return [_reach isReachableViaWiFi];
}

+ (BOOL)isReachableViaWLAN
{
    return [[MSZXReachability sharedInstance] isReachableViaWLAN];
}

- (BOOL)isReachableViaWLAN
{
    if ( NO == [_reach isReachable] )
    {
        return NO;
    }
    
    return [_reach isReachableViaWWAN];
}

+ (NSString *)localIP
{
    return [[MSZXReachability sharedInstance] localIP];
}

- (NSString *)localIP
{
    NSString *			ipAddr = nil;
    struct ifaddrs *	addrs = NULL;
    
    int ret = getifaddrs( &addrs );
    if ( 0 == ret )
    {
        const struct ifaddrs * cursor = addrs;
        
        while ( cursor )
        {
            if ( AF_INET == cursor->ifa_addr->sa_family && 0 == (cursor->ifa_flags & IFF_LOOPBACK) )
            {
                ipAddr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                break;
            }
            
            cursor = cursor->ifa_next;
        }
        
        freeifaddrs( addrs );
    }
    
    return ipAddr;
}

- (void)networkReachabilityChanged:(NSNotification* )indicator
{
    Reachability* curReach = [indicator object];
    
    if (curReach && [curReach isKindOfClass:[Reachability class]])
    {
        ReachabilityLog_i(@"NetWork status changed to:%ld", [curReach currentReachabilityStatus]);
    }
}


@end
