//
//  RegisterModel.m
//  AppOne
//
//  Created by lile on 15/7/17.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "RegisterModel.h"

@implementation RegisterModel{

NSString *_username;
NSString *_password;
NSString *_email;
}

- (id)initWithUsername:(NSString *)username password:(NSString *)password email:(NSString *)email {
    self = [super init];
    if (self) {
        _username = username;
        _password = password;
        _email = email;
    }
    return self;
}

- (NSString *)requestUrl {
    //return @"/idservice/id";
    return @"/Register";
}

- (id)requestArgument {
    return @{ @"username": _username,
              @"password":_password,
              @"email":_email};
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

