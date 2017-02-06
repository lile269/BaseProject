//
//  commitExcerciseModel.h
//  AppOne
//
//  Created by lile on 15/7/28.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "YTKRequest.h"

@interface commitExcerciseModel : YTKRequest
- (id)initWithUsername:(NSString *)username token:(NSString *)token course_id:(NSString *)course_id  answers:(NSArray*)anwers;

@end
