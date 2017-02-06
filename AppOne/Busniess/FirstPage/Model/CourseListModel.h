//
//  LoginModel.h
//  AppOne
//
//  Created by lile on 15/7/16.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKRequest.h"

@interface CourseListModel : YTKRequest

- (id)initWithUsername:(NSString *)username token:(NSString *)token;

@end