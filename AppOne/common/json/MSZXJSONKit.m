//
//  MSZXJSONKit.m
//  MSZX
//
//  Created by wenyanjie on 14-4-12.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "MSZXJSONKit.h"

@implementation NSString(JSONCategories)

+(NSString *)stringFromJSONData:(NSData *)jsonData
{
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

+(NSString *)stringFromJSONData:(NSData *)jsonData options:(NSJSONReadingOptions)opt error:(NSError **)error
{
    id result = [NSJSONSerialization JSONObjectWithData:jsonData options:opt error:error];
    if (error != nil) return nil;
    return result;
}

-(NSData *)toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

-(NSData *)toJSONWithoptions:(NSJSONWritingOptions)opt error:(NSError **)error
{
    id result = [NSJSONSerialization dataWithJSONObject:self options:opt error:error];
    if (error != nil) return nil;
    return result;
}

@end

@implementation NSArray(JSONCategories)

+(NSArray *)arrayFromJSONData:(NSData *)jsonData
{
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
+(NSArray *)arrayFromJSONData:(NSData *)jsonData options:(NSJSONReadingOptions)opt error:(NSError **)error
{
    id result = [NSJSONSerialization JSONObjectWithData:jsonData options:opt error:error];
    if (error != nil) return nil;
    return result;
}

-(NSData *)toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

-(NSData *)toJSONWithoptions:(NSJSONWritingOptions)opt error:(NSError **)error
{
    id result = [NSJSONSerialization dataWithJSONObject:self options:opt error:error];
    if (error != nil) return nil;
    return result;
}

@end

@implementation NSDictionary(JSONCategories)

+(NSDictionary *)dictionaryFromJSONData:(NSData *)jsonData
{
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

+(NSDictionary *)dictionaryFromJSONData:(NSData *)jsonData options:(NSJSONReadingOptions)opt error:(NSError **)error
{
    id result = [NSJSONSerialization JSONObjectWithData:jsonData options:opt error:error];
    if (error != nil) return nil;
    return result;
}

-(NSData *)toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

-(NSData *)toJSONWithoptions:(NSJSONWritingOptions)opt error:(NSError **)error
{
    id result = [NSJSONSerialization dataWithJSONObject:self options:opt error:error];
    if (error != nil) return nil;
    return result;
}

@end

