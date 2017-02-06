//
//  BEGetUserMessageModel.h
//  AppOne
//
//  Created by lile on 15/9/17.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "YTKRequest.h"

@interface BEGetUserMessageModel : YTKRequest
- (id)initWithUsername:(NSString *)username token:(NSString *)token;
@end
