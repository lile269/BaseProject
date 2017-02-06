//
//  BEGetQuestTypeModel.h
//  AppOne
//
//  Created by lile on 15/9/21.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "YTKRequest.h"

@interface BEGetQuestTypeModel : YTKRequest
- (id)initWithUsername:(NSString *)username syllabusId:(NSString*)syllabusId token:(NSString *)token;
@end
