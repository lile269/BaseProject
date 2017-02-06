//
//  LoginModel.h
//  AppOne
//
//  Created by lile on 15/7/16.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKRequest.h"

@interface LoginMode : YTKRequest

- (id)initWithUsername:(NSString *)username password:(NSString *)password;

@end