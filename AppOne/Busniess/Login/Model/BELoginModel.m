//
//  BELoginModel.m
//  AppOne
//
//  Created by lile on 15/9/11.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "BELoginModel.h"

@implementation BELoginModel{
    NSString *_username;
    NSString *_password;
    NSString *_deviceId;
}

- (id)initWithUsername:(NSString *)username password:(NSString *)password deviceId:(NSString *)deviceId{
    self = [super init];
    if (self) {
        _username = username;
        _password = password;
        _deviceId = deviceId;
    }
    return self;
}

- (NSString *)requestUrl {
    //return @"/idservice/id";
    return @"/BELogon";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}
- (id)requestArgument {
    return @{ @"username": _username,
              @"password":_password,
              @"deviceId":_deviceId};
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
