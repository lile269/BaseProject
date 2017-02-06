//
//  LoginModel.m
//  AppOne
//
//  Created by lile on 15/7/16.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "LoginModel.h"


@implementation LoginMode{
    NSString *_username;
    NSString *_password;
}

- (id)initWithUsername:(NSString *)username password:(NSString *)password {
    self = [super init];
    if (self) {
        _username = username;
        _password = password;
    }
    return self;
}

- (NSString *)requestUrl {
    //return @"/idservice/id";
    return @"/Login";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}
- (id)requestArgument {
    return @{ @"username": _username,
              @"password":_password};
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
