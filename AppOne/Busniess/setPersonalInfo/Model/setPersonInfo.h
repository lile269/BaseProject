//
//  setPersonInfo.h
//  AppOne
//
//  Created by lile on 15/7/18.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "YTKRequest.h"

@interface setPersonInfo : YTKRequest

- (id)initWithPersonInfo:(NSString *)username token:(NSString *)token;
@end
