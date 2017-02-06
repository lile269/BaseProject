//
//  MSZXSecurityUtil.m
//  MSZXFramework
//
//  Created by wenyanjie on 14-11-28.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "MSZXSecurityUtil.h"
#import "GTMBase64.h"
#import "MSZXReachability.h"
#import "NSData+Encryption.h"
#import "RSAEncrypt.h"

#define USER_APP_PATH @"/User/Applications/"
#define NumberOfChars 16

@interface MSZXSecurityUtil ()

/**
 *  设备是否安装了cydia
 *
 *  @return 返回YES说明已经越狱
 */
+ (BOOL)isJailBreakWithCydia;

/**
 *  是否可以读取系统所有应用的名称
 *
 *  @return 返回YES说明已经越狱
 */
+ (BOOL)isJailBreakWithAllAppName;

@end

@implementation MSZXSecurityUtil

+ (MSZXSecurityUtil *)sharedInstance
{
    static MSZXSecurityUtil *_securiryUtilManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _securiryUtilManager = [[self alloc] init];
    });
    return _securiryUtilManager;
}

+(BOOL)isJailBreak
{
    return  ([MSZXSecurityUtil isJailBreakWithAllAppName] || [MSZXSecurityUtil isJailBreakWithCydia]);
}

+ (BOOL)isJailBreakWithCydia
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]])
    {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isJailBreakWithAllAppName
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:USER_APP_PATH])
    {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isReachabilityWiFi
{
    return [MSZXReachability isReachableViaWIFI];
}

+ (NSString*)generateAESKey
{
    
    char data[NumberOfChars];
    for (int i = 0; i < NumberOfChars; i++)
    {
        data[i] = (char)('A' + (arc4random_uniform(26)));
    }
    
    NSString *randomStr = [[NSString alloc] initWithBytes:data length:NumberOfChars encoding:NSUTF8StringEncoding];
    
    return randomStr;
}

+ (NSString*)MSZXAESEncrypt:(NSString*)codeString key:(NSString *)aesKey
{
    NSData* data = [codeString dataUsingEncoding:NSUTF8StringEncoding];
    NSData* encodeData = [data AES256EncryptWithKey:aesKey];
    NSString *postString = [GTMBase64 stringByEncodingData:encodeData];
    
    return postString;
}

+ (NSString*)MSZXAESDecrypt:(NSString*)codeString key:(NSString *)aesKey
{
    NSData* decodeData = [GTMBase64 decodeString:codeString];
    NSData* base64Data =  [decodeData AES256DecryptWithKey:aesKey];
    NSString* requestString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    
    return requestString;
}

+ (NSString*)MSZXRSAEncrypt:(NSString*)codeString
{
    NSError* error = nil;
    RSAEncrypt *encrypt = [[RSAEncrypt alloc] init];
    SecKeyRef key = [encrypt getPublicKey];
    NSData *data = [encrypt encrypt:codeString usingKey:key error:&error];
    NSString *postString = [GTMBase64 stringByEncodingData:data];

    return postString;
}

+ (NSString*)encodeBase64String:(NSString * )input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)decodeBase64String:(NSString * )input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)encodeBase64Data:(NSData *)data
{
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)decodeBase64Data:(NSData *)data
{
    data = [GTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

@end
