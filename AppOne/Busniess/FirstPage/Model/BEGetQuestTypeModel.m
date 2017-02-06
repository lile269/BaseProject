//
//  BEGetQuestTypeModel.m
//  AppOne
//
//  Created by lile on 15/9/21.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "BEGetQuestTypeModel.h"

@implementation BEGetQuestTypeModel{
    NSString *_username;
    NSString *_syllabusId;
   
    NSString *_token;
}

- (id)initWithUsername:(NSString *)username syllabusId:(NSString*)syllabusId token:(NSString *)token {
    self = [super init];
    if (self) {
        _username = username;
        _token = token;
        _syllabusId = syllabusId;
    }
    return self;
}

- (NSString *)requestUrl {
    //return @"/idservice/id";
    return @"/BEGetQuestType";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}
- (id)requestArgument {
    return @{ @"username": _username,
              @"syllabusId": _syllabusId,
              @"deviceId": [SetDevieceUUID getDeviceUUID],
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