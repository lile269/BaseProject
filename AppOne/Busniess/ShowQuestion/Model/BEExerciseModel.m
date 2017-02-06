//
//  BEExerciseModel.m
//  AppOne
//
//  Created by lile on 15/9/15.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "BEExerciseModel.h"

@implementation BEExerciseModel{
    
    NSString *_username;
    NSString *_token;
    NSString *_syllabusId;
    NSString *_course_id;
    NSNumber *_pageIndex;
    NSNumber *_pageSize;
    NSString *_deviceId;
    NSString *_quest_type;
}

- (id)initWithUsername:(NSString *)username token:(NSString *)token course_id:(NSString *)course_id syllabusId:(NSString*)syllabusId quest_type:(NSString*)quest_type pageIndex:(NSNumber *)pageIndex pageSize:(NSNumber *)pageSize deviceId:(NSString*)deviceId{
    self = [super init];
    if (self) {
        _username = username;
        _token = token;
        _course_id = course_id;
         _pageIndex= pageIndex;
        _pageSize = pageSize;
        _syllabusId = syllabusId;
        _deviceId = deviceId;
        _quest_type = quest_type;
    }
    return self;
}

- (NSString *)requestUrl {
    //return @"/idservice/id";
    return @"/BEExercise";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}
- (id)requestArgument {
    return @{ @"username": _username,
              @"courseId":_course_id,
              @"syllabusId":_syllabusId,
              @"quest_type":_quest_type,
              @"pageIndex":_pageIndex,
              @"pageSize":_pageSize,
              @"deviceId":_deviceId,
               @"token":_token,};
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
