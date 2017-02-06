//
//  setPersonInfo.m
//  AppOne
//
//  Created by lile on 15/7/18.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "setPersonInfo.h"

@implementation setPersonInfo{

NSString *_username;
NSString *_token;
NSString *_nickname;
NSString *_sex;
NSString *_birthday;
NSString *_email;
NSString *_telphone;
NSString *_photo;
NSString *_examtime;
NSString *_examadd;

}

- (id)initWithPersonInfo:(NSString *)username token:(NSString *)token{
    self = [super init];
    
    
    if (self) {
        _username = username;
        _token = token;
        _birthday = [[Commondata sharedInstance]birthday];
        _email = [[Commondata sharedInstance]email];
        _nickname =[[Commondata sharedInstance]nickname];
        _telphone =[[Commondata sharedInstance]telphone];
        _examtime =[[Commondata sharedInstance]exam_time];
        _examadd =[[Commondata sharedInstance]district];
        _sex =[[Commondata sharedInstance]sex];
        
    }
    return self;
}

- (NSString *)requestUrl {
    //return @"/idservice/id";
    return @"/BESetUserMessage";
}

- (id)requestArgument {
    return @{ @"username": _username,
              @"deviceId":[SetDevieceUUID getDeviceUUID],
              @"token":_token,
              @"nickname":_nickname,
              @"sex":_sex,
              @"birthday":_birthday,
              @"email":_email,
              @"telphone":_telphone
              //@"examtime":_examtime,
              //@"examadd":_examadd
              };
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