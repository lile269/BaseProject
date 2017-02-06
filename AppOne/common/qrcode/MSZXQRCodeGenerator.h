//
//  MSZXQRCodeGenerator.h
//  MSZXFramework
//
//  Created by wenyanjie on 15-2-4.
//  Copyright (c) 2015年 wenyanjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSZXQRCodeGenerator : NSObject

/**
 *  通过字符串和size生成二维码图片
 *
 *  @param string 生成二维码的字符串
 *  @param size   二维码图片的尺寸 size*size
 *
 *  @return 二维码image
 */
+ (UIImage *)qrImageForString:(NSString *)aString imageSize:(CGFloat)aSize;

@end
