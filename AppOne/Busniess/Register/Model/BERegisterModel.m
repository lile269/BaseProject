//
//  BERegisterModel.m
//  AppOne
//
//  Created by lile on 15/9/11.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "BERegisterModel.h"

@implementation BERegisterModel{
    NSString *_username;
    NSString *_password;
    NSString *_email;
    NSString *_regCode;
    NSString *_regPassword;
    NSString *_deviceId;
}

- (id)initWithUsername:(NSString *)username password:(NSString *)password email:(NSString *)email regCode:(NSString*)regCode regPassword:(NSString*)regPassword deviceId:(NSString*)deviceId {
    self = [super init];
    if (self) {
        _username = username;
        _password = password;
        _email = email;
        _regCode = regCode;
        _regPassword = regPassword;
        _deviceId = deviceId;
    }
    return self;
}

- (NSString *)requestUrl {
    //return @"/idservice/id";
    return @"/BERegister";
}

- (id)requestArgument {
    return @{ @"username": _username,
              @"password":_password,
             @"regCode":_regCode,
              @"regPassword":_regPassword,
              @"deviceId":_deviceId,
               @"email":_email,
              @"courseID":@"224"};
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
    return 0 * 3;
}

@end

