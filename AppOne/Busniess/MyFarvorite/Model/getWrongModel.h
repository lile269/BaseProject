//
//  getWrongModel.h
//  AppOne
//
//  Created by lile on 15/8/1.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "YTKRequest.h"

@interface getWrongModel : YTKRequest
- (id)initWithUsername:(NSString *)username token:(NSString *)token course_id:(NSString *)course_id  course_offset:(NSNumber*)course_offset course_num:(NSNumber *)course_num;
@end
