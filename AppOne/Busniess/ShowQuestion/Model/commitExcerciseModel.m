//
//  commitExcerciseModel.m
//  AppOne
//
//  Created by lile on 15/7/28.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "commitExcerciseModel.h"

@implementation commitExcerciseModel{
    NSString *_username;
    NSString *_token;
    NSString *_course_id;
    NSString *_answers;
}

- (id)initWithUsername:(NSString *)username token:(NSString *)token course_id:(NSString *)course_id answers:(NSArray*)answers{
    self = [super init];
    if (self) {
        _username = username;
        _token = token;
        _course_id = course_id;
         NSError *error = nil;
        
        NSData * jsondata =[NSJSONSerialization dataWithJSONObject:answers
                                        options:NSJSONWritingPrettyPrinted
                                          error:&error];
        _answers = [[NSString alloc] initWithData:jsondata
                                       encoding:NSUTF8StringEncoding];
        
        //NSLog(@"answer==%@",ttanswers);
        
        
      //  _answers = jsondata;
        
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/BECommitQuest";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}
- (id)requestArgument {
    return @{ @"username": _username,
              @"token":_token,
              @"courseId":_course_id,
              //@"cardid":_cardid,
              @"deviceId":[SetDevieceUUID getDeviceUUID],
              @"answers":_answers};
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
