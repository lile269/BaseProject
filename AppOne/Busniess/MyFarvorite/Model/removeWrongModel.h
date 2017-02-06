//
//  removeWrongModel.h
//  AppOne
//
//  Created by lile on 15/8/20.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "YTKRequest.h"

@interface removeWrongModel : YTKRequest
- (id)initWithUsername:(NSString *)username token:(NSString *)token course_id:(NSString *)course_id id:(NSString*)qid;
@end
