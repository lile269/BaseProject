//
//  MSZXLocalCache.h
//  MSZXFramework
//
//  Created by wenyanjie on 14-11-29.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RYBCACHE_KEY @"rybCache"

/**
 *  缓冲信息到本地,增强数据复用,利用系统自带的archive编码机制
 */
@interface MSZXLocalCache : NSObject

+ (MSZXLocalCache *)sharedInstance;

/**
 *  返回缓存string
 *
 *  @return 缓存string
 */
- (NSString *)getStringCache;

/**
 *  缓存string
 *
 *  @param aStringCache 缓存的string值
 */
- (void)setStringCache:(NSString *)aStringCache;

/**
 *  返回缓存array
 *
 *  @return 缓存array
 */
- (NSArray *)getArrayCache;

/**
 *  缓存array
 *
 *  @param aArrayCache 缓存的array值
 */
- (void)setArrayCache:(NSArray *)aArrayCache;

/**
 *  返回缓存dictionary
 *
 *  @return 缓存dictionary
 */
- (NSDictionary *)getDictionaryCache;

/**
 *  缓存dictionary
 *
 *  @param aDictionaryCache 缓存的dictionary值
 */
- (void)setDictionaryCache:(NSDictionary *)aDictionaryCache;

- (NSDictionary *)getRybCache;
- (void)setRybCache:(NSDictionary *)aRybCache;

@end

