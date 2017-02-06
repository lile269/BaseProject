//
//  MSZXSecurityUtil.h
//  MSZXFramework
//
//  Created by wenyanjie on 14-11-28.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSZXSecurityUtil : NSObject

+ (MSZXSecurityUtil *)sharedInstance;

/**
 *  判断手机是否越狱
 *
 *  @return 返回YES说明越狱
 */
+(BOOL)isJailBreak;

/**
 *  判断手机是否处于wifi环境
 *
 *  @return 返回YES说明处于wifi环境
 */
+(BOOL)isReachabilityWiFi;

/**
 *  生成AES密钥
 *
 *  @return AES密钥
 */
+ (NSString*)generateAESKey;

/**
 *  AES加密
 *
 *  @param code   格式为NSString
 *  @param aesKey AES秘钥
 *
 *  @return AES加密结果
 */
+(NSString*)MSZXAESEncrypt:(NSString*)code key:(NSString *)aesKey;

/**
 *  AES解密
 *
 *  @param code   格式为NSString
 *  @param aesKey AES秘钥
 *
 *  @return AES解密结果
 */
+(NSString*)MSZXAESDecrypt:(NSString*)code key:(NSString *)aesKey;

/**
 *  RSA加密
 *
 *  @param codeString 格式为NSString
 *
 *  @return RSA加密结果
 */
+ (NSString*)MSZXRSAEncrypt:(NSString*)codeString;

/**
 *  base64编码
 *
 *  @param input 输入格式为NSString
 *
 *  @return 编码结果
 */
+(NSString*)encodeBase64String:(NSString *)input;

/**
 *  base64解码
 *
 *  @param input 输入格式为NSString
 *
 *  @return 解码结果
 */
+(NSString*)decodeBase64String:(NSString *)input;

/**
 *  base64编码
 *
 *  @param input 输入格式为NSData
 *
 *  @return 编码结果
 */
+(NSString*)encodeBase64Data:(NSData *)data;

/**
 *  base64解码
 *
 *  @param input 输入格式为NSData
 *
 *  @return 解码结果
 */
+(NSString*)decodeBase64Data:(NSData *)data;

@end
