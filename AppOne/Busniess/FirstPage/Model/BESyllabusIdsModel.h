//
//  BESyllabusIdsModel.h
//  AppOne
//
//  Created by lile on 15/9/11.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "YTKRequest.h"

@interface BESyllabusIdsModel : YTKRequest
- (id)initWithUsername:(NSString *)username courserId:(NSString*)courseId deviceId:(NSString*)deviceId token:(NSString *)token;
@end
