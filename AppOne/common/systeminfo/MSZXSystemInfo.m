//
//  MSZXSystemInfo.m
//  MSZX
//
//  Created by wenyanjie on 14-3-24.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "MSZXSystemInfo.h"
#import "UIDevice+Addition.h"

@implementation MSZXSystemInfo

+ (NSString *)deviceIdentifier
{
    return [[UIDevice currentDevice] deviceIdentifier];
}

+ (NSString *)iOSVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)appVersion
{
	NSString *versionValue = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
	return versionValue;
}

+ (NSString *)appIdentifier
{
	static NSString * _identifier = nil;
	if (nil == _identifier)
	{
		_identifier = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
	}
    
	return _identifier;
}

+ (NSString *)osType
{
    return @"iphone";
}



@end
