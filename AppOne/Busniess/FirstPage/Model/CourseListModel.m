//
//  LoginModel.m
//  AppOne
//
//  Created by lile on 15/7/16.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "CourseListModel.h"


@implementation CourseListModel{
    NSString *_username;
    NSString *_token;
}

- (id)initWithUsername:(NSString *)username token:(NSString *)token {
    self = [super init];
    if (self) {
        _username = username;
        _token = token;
    }
    return self;
}

- (NSString *)requestUrl {
    //return @"/idservice/id";
    return @"/CourseList";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}
- (id)requestArgument {
    return @{ @"username": _username,
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
