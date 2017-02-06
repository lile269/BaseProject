//
//  NSString+Addition.m
//  MSZXFramework
//
//  Created by wenyanjie on 14-12-17.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "NSString+Addition.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Addition)

+ (BOOL)strNilOrEmpty:(NSString *)aString
{
    if ([aString isKindOfClass:[NSString class]])
    {
        if (aString.length > 0)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        return YES;
    }
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)stringMD5
{
    if(self == nil || [self length] == 0)
    {
        return nil;
    }
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

@end
