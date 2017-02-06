//
//  setPhoto.h
//  AppOne
//
//  Created by lile on 15/7/19.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "YTKRequest.h"

@interface setPhotoModel : YTKRequest
- (id)initWithUsername:(NSString *)username token:(NSString *)token photo:(NSString *)photo;
@end
