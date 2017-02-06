//
//  GetUserInfo.h
//  AppOne
//
//  Created by lile on 15/7/17.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "YTKRequest.h"

@interface GetUserInfo : YTKRequest
- (id)initWithUsername:(NSString *)username token:(NSString *)token;
@end
