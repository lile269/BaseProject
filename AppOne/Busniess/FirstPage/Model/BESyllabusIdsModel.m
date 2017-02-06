//
//  BESyllabusIdsModel.m
//  AppOne
//
//  Created by lile on 15/9/11.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "BESyllabusIdsModel.h"

@implementation BESyllabusIdsModel{
    NSString *_username;
    NSString *_courseId;
    NSString *_deviceId;
    NSString *_token;
}

- (id)initWithUsername:(NSString *)username courserId:(NSString*)courseId deviceId:(NSString*)deviceId token:(NSString *)token {
    self = [super init];
    if (self) {
        _username = username;
        _token = token;
        _courseId = courseId;
        _deviceId = deviceId;
    }
    return self;
}

- (NSString *)requestUrl {
    //return @"/idservice/id";
    return @"/BESyllabusIds";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}
- (id)requestArgument {
    return @{ @"username": _username,
              @"courseId": _courseId,
              @"deviceId": _deviceId,
              @"token":_token};
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


@end