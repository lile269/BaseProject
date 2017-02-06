//
//  setPhoto.m
//  AppOne
//
//  Created by lile on 15/7/19.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "setPhotoModel.h"

@implementation setPhotoModel{
    NSString *_username;
    NSString *_token;
    NSString *_photo;
}

- (id)initWithUsername:(NSString *)username token:(NSString *)token photo:(NSString *)photo {
    self = [super init];
    if (self) {
        _username = username;
        _token = token;
        _photo = photo;
    }
    return self;
}
- (NSTimeInterval)requestTimeoutInterval {
    return 60*2;
}

- (NSString *)requestUrl {
    //return @"/idservice/id";
    return @"/BESetPhoto";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}
- (id)requestArgument {
    return @{ @"username": _username,
              @"token":_token,
              @"deviceId":[SetDevieceUUID getDeviceUUID],
              @"photo":_photo};
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