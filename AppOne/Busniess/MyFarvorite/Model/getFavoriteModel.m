//
//  getFavoriteModel.m
//  AppOne
//
//  Created by lile on 15/7/30.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "getFavoriteModel.h"

@implementation getFavoriteModel{
    NSString *_username;
    NSString *_token;
    NSString *_course_id;
    NSNumber *_course_offset;
    NSNumber *_course_num;
}

- (id)initWithUsername:(NSString *)username token:(NSString *)token course_id:(NSString *)course_id  course_offset:(NSNumber*)course_offset course_num:(NSNumber *)course_num{
    self = [super init];
    if (self) {
        _username = username;
        _token = token;
        _course_id = course_id;
        _course_offset = course_offset;
        _course_num = course_num;
        
    }
    return self;
}

- (NSString *)requestUrl {
    //return @"/idservice/id";
    return @"/BEGetFavourite";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}
- (id)requestArgument {
    return @{ @"username": _username,
              @"token":_token,
              @"deviceId":[SetDevieceUUID getDeviceUUID],
              @"courseId":_course_id,
              @"pageIndex":_course_offset,
              @"pageSize":_course_num};
}

- (NSDictionary *)requestHeaderFieldValueDictionary{
    //NSDictionary *parameters = @{@"apikey": @"b5c4ac135cb0b0ec55abbccca7ee265f"};
    //return parameters;
    return nil;
}
/*
 - (id)jsonValidator {
 return @{
 @"nick": [NSString class],
 @"level": [NSNumber class]
 };
 }*/
- (NSInteger)cacheTimeInSeconds {
    return -1;
}

@end
