//
//  removeWrongModel.m
//  AppOne
//
//  Created by lile on 15/8/20.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "removeWrongModel.h"

@implementation removeWrongModel{
    NSString *_username;
    NSString *_token;
    NSString *_course_id;
    NSString *_qid;

}

- (id)initWithUsername:(NSString *)username token:(NSString *)token course_id:(NSString *)course_id id:(NSString*)qid{
    self = [super init];
    if (self) {
        _username = username;
        _token = token;
        _course_id = course_id;
        _qid = qid;
    }
    return self;
}

- (NSString *)requestUrl {
    //return @"/idservice/id";
    return @"/RemoveWrong";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}
- (id)requestArgument {
    return @{ @"username": _username,
              @"token":_token,
              @"course_id":_course_id,
              @"id":_qid};
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
