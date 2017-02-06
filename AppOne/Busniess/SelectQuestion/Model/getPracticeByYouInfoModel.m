//
//  getPracticeByYouInfoModel.m
//  AppOne
//
//  Created by lile on 15/7/21.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "getPracticeByYouInfoModel.h"

@implementation getPracticeByYouInfoModel{

NSString *_username;
NSString *_token;
NSString *_course_id;
}

- (id)initWithUsername:(NSString *)username token:(NSString *)token course_id:(NSString *)course_id {
    self = [super init];
    if (self) {
        _username = username;
        _token = token;
        _course_id = course_id;
    }
    return self;
}

- (NSString *)requestUrl {
    //return @"/idservice/id";
    return @"/getpracticebyyouinfo";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}
- (id)requestArgument {
    return @{ @"username": _username,
              @"token":_token,
              @"course_id":_course_id};
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
    return 3600;
}

@end