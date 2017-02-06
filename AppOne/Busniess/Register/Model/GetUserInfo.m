//
//  GetUserInfo.m
//  AppOne
//
//  Created by lile on 15/7/17.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "GetUserInfo.h"

@implementation GetUserInfo{
    
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
    return @"/getPersonalInfo";
}

- (id)requestArgument {
    return @{ @"username": _username,
              @"token":_token};
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
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
