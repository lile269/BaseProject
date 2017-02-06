//
//  MSZXJSONKit.h
//  MSZX
//
//  Created by wenyanjie on 14-4-12.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  NSString和JSONData的相互转换
 */
@interface NSString(JSONCategories)

+(NSString *)stringFromJSONData:(NSData *)jsonData;
+(NSString *)stringFromJSONData:(NSData *)jsonData options:(NSJSONReadingOptions)opt error:(NSError **)error;

-(NSData *)toJSON;
-(NSData *)toJSONWithoptions:(NSJSONWritingOptions)opt error:(NSError **)error;

@end

/**
 *  NSArray和JSONData的相互转换
 */
@interface NSArray(JSONCategories)

+(NSArray *)arrayFromJSONData:(NSData *)jsonData;
+(NSArray *)arrayFromJSONData:(NSData *)jsonData options:(NSJSONReadingOptions)opt error:(NSError **)error;

-(NSData *)toJSON;
-(NSData *)toJSONWithoptions:(NSJSONWritingOptions)opt error:(NSError **)error;

@end

/**
 *  NSDictionary和JSONData的相互转换
 */
@interface NSDictionary(JSONCategories)

+(NSDictionary *)dictionaryFromJSONData:(NSData *)jsonData;
+(NSDictionary *)dictionaryFromJSONData:(NSData *)jsonData options:(NSJSONReadingOptions)opt error:(NSError **)error;

-(NSData *)toJSON;
-(NSData *)toJSONWithoptions:(NSJSONWritingOptions)opt error:(NSError **)error;

@end

