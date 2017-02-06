//
//  addFavoriteModel.m
//  AppOne
//
//  Created by lile on 15/7/27.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "addFavoriteModel.h"

@interface addFavoriteModel ()

@end

@implementation addFavoriteModel{
NSString *_username;
NSString *_token;
NSString *_course_id;
NSNumber *_id;
NSNumber *_do_favorite;
}

- (id)initWithUsername:(NSString *)username token:(NSString *)token course_id:(NSString *)course_id  id:(NSNumber*)qid do_favorite:(NSNumber *)do_favorite{
    self = [super init];
    if (self) {
        _username = username;
        _token = token;
        _course_id = course_id;
        _id = qid;
        _do_favorite = do_favorite;
        
    }
    return self;
}

- (NSString *)requestUrl {
    //return @"/idservice/id";
    return @"/BEFavourite";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}
- (id)requestArgument {
    return @{ @"username": _username,
              @"token":_token,
              @"courseId":_course_id,
              @"id":_id,
              @"ostype":@"1",
              @"version":@"1",
              @"deviceId":[SetDevieceUUID getDeviceUUID],
              @"is_favorite":_do_favorite};
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
