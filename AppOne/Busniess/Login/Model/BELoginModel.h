//
//  BELoginModel.h
//  AppOne
//
//  Created by lile on 15/9/11.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "YTKRequest.h"

@interface BELoginModel : YTKRequest

- (id)initWithUsername:(NSString *)username password:(NSString *)password deviceId:(NSString *)deviceId;

@end