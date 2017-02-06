//
//  getPracticeByYouInfoModel.h
//  AppOne
//
//  Created by lile on 15/7/21.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "YTKRequest.h"

@interface getPracticeByYouInfoModel : YTKRequest
- (id)initWithUsername:(NSString *)username token:(NSString *)token course_id:(NSString *)course_id ;
@end
