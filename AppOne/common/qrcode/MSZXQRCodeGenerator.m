//
//  MSZXQRCodeGenerator.m
//  MSZXFramework
//
//  Created by wenyanjie on 15-2-4.
//  Copyright (c) 2015年 wenyanjie. All rights reserved.
//

#import "MSZXQRCodeGenerator.h"
#import "qrencode.h"

#define qr_margin 3

@interface MSZXQRCodeGenerator ()

+ (void)drawQRCode:(QRcode *)code context:(CGContextRef)ctx size:(CGFloat)size;

@end

@implementation MSZXQRCodeGenerator

+ (void)drawQRCode:(QRcode *)code context:(CGContextRef)ctx size:(CGFloat)size
{
    unsigned char *data = 0;
    int width;
    data = code->data;
    width = code->width;
    float zoom = (double)size / (code->width + 2.0 * qr_margin);
    CGRect rectDraw = CGRectMake(0, 0, zoom, zoom);
    
    CGContextSetFillColor(ctx, CGColorGetComponents([UIColor blackColor].CGColor));
    for(int i = 0; i < width; ++i) {
        for(int j = 0; j < width; ++j) {
            if(*data & 1) {
                rectDraw.origin = CGPointMake((j + qr_margin) * zoom,(i + qr_margin) * zoom);
                CGContextAddRect(ctx, rectDraw);
            }
            ++data;
        }
    }
    CGContextFillPath(ctx);
}

+ (UIImage *)qrImageForString:(NSString *)aString imageSize:(CGFloat)aSize
{
    if (![aString length])
    {
        return nil;
    }
    
    QRcode *code = QRcode_encodeString([aString UTF8String], 0, QR_ECLEVEL_L, QR_MODE_8, 1);
    if (!code) {
        return nil;
    }
    
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(0, aSize, aSize, 8, aSize * 4, colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast);
    
    CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(0, -aSize);
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
    CGContextConcatCTM(ctx, CGAffineTransformConcat(translateTransform, scaleTransform));
    
    // draw QR on this context
    [[self class] drawQRCode:code context:ctx size:aSize];
    
    // get image
    CGImageRef qrCGImage = CGBitmapContextCreateImage(ctx);
    UIImage *qrImage = [UIImage imageWithCGImage:qrCGImage];
    
    // some releases
    CGContextRelease(ctx);
    CGImageRelease(qrCGImage);
    CGColorSpaceRelease(colorSpace);
    QRcode_free(code);
    
    return qrImage;
}

@end
