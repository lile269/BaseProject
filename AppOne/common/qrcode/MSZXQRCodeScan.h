//
//  MSZXQRCodeScan.h
//  MSZXFramework
//
//  Created by wenyanjie on 15-2-6.
//  Copyright (c) 2015年 wenyanjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

/**
 *  只有iOS6.x的系统会用到,iOS7以上的也可以使用系统API
 */
@interface MSZXQRCodeScan : NSObject

/**
 *  扫描二维码,获取结果
 *
 *  @param qrImage 二维码图片
 *
 *  @return 二维码扫描结果
 */
+ (NSString *)decodeFromQRImage:(UIImage *)qrImage;

/**
 *  获取视屏扫描的image
 *
 *  @param sampleBuffer 视屏缓存
 *
 *  @return return value description
 */
+ (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer;

@end
