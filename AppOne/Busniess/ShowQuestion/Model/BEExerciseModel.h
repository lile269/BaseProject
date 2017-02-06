//
//  BEExerciseModel.h
//  AppOne
//
//  Created by lile on 15/9/15.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "YTKRequest.h"

@interface BEExerciseModel : YTKRequest
- (id)initWithUsername:(NSString *)username token:(NSString *)token course_id:(NSString *)course_id syllabusId:(NSString*)syllabusId quest_type:(NSString*)quest_type pageIndex:( NSNumber *)pageIndex pageSize:(NSNumber *)pageSize deviceId:(NSString*)deviceId;
@end
