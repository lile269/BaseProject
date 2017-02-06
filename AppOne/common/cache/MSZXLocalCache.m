//
//  MSZXLocalCache.m
//  MSZXFramework
//
//  Created by wenyanjie on 14-11-29.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "MSZXLocalCache.h"

#define CACHEFILE @"MSZXLocalCache"

@interface MSZXCacheData : NSObject

@property (nonatomic, strong) NSString *stringCache;
@property (nonatomic, strong) NSArray *arrayCache;
@property (nonatomic, strong) NSDictionary *dictionaryCache;
@property (nonatomic, strong) NSDictionary *rybDataCache;

@end

@implementation MSZXCacheData

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.stringCache forKey:@"stringCache"];
    [aCoder encodeObject:self.arrayCache forKey:@"arrayCache"];
    [aCoder encodeObject:self.dictionaryCache forKey:@"dictionaryCache"];
    [aCoder encodeObject:self.rybDataCache forKey:@"rybDataCache"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.stringCache = [aDecoder decodeObjectForKey:@"stringCache"];
        self.arrayCache = [aDecoder decodeObjectForKey:@"arrayCache"];
        self.dictionaryCache = [aDecoder decodeObjectForKey:@"dictionaryCache"];
        self.rybDataCache = [aDecoder decodeObjectForKey:@"rybDataCache"];
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
    MSZXCacheData* cache = [[[self class]allocWithZone:zone]init];
    cache.stringCache = [self.stringCache copyWithZone:zone];
    cache.arrayCache = [self.arrayCache copyWithZone:zone];
    cache.dictionaryCache = [self.dictionaryCache copyWithZone:zone];
    
    return cache;
}

@end


@interface MSZXLocalCache ()

@property (nonatomic,strong) MSZXCacheData *cacheData;

- (NSString *)localCachePath;

@end

@implementation MSZXLocalCache

+ (MSZXLocalCache *)sharedInstance
{
    static MSZXLocalCache *_localCacheInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _localCacheInstance = [[MSZXLocalCache alloc] init];
    });
    return _localCacheInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        id archive = [NSKeyedUnarchiver unarchiveObjectWithFile:[self localCachePath]];
        if (archive)
        {
            self.cacheData = (MSZXCacheData *)archive;
        }
    }
    
    return self;
}

- (NSString *)localCachePath
{
    NSString *cachePath = [[MSZXSandbox libCachePath] stringByAppendingPathComponent:CACHEFILE];
    return cachePath;
}

- (NSString *)getStringCache
{
    return self.cacheData.stringCache;
}

- (void)setStringCache:(NSString *)aStringCache
{
    self.cacheData.stringCache = aStringCache;
    [NSKeyedArchiver archiveRootObject:self.cacheData toFile:[self localCachePath]];
}

- (NSArray *)getArrayCache
{
    return self.cacheData.arrayCache;
}

- (void)setArrayCache:(NSArray *)aArrayCache
{
    self.cacheData.arrayCache = aArrayCache;
    [NSKeyedArchiver archiveRootObject:self.cacheData toFile:[self localCachePath]];
}

- (NSDictionary *)getDictionaryCache
{
    return self.cacheData.dictionaryCache;
}

- (void)setDictionaryCache:(NSDictionary *)aDictionaryCache
{
    self.cacheData.dictionaryCache = aDictionaryCache;
    [NSKeyedArchiver archiveRootObject:self.cacheData toFile:[self localCachePath]];
}

- (NSDictionary *)getRybCache
{
    return self.cacheData.rybDataCache;
}

- (void)setRybCache:(NSDictionary *)aRybCache
{
    self.cacheData.rybDataCache = aRybCache;
    [NSKeyedArchiver archiveRootObject:self.cacheData toFile:[self localCachePath]];
}

@end
