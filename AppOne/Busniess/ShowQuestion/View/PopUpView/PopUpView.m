//
//  PopUpView.m
//  模态跳转下滑返回
//
//  Created by GXY on 15/8/3.
//  Copyright (c) 2015年 Tangxianhai. All rights reserved.
//

#import "PopUpView.h"

@implementation PopUpView {
    CGPoint beginPoint;
    CGPoint currentPoint;
    CGPoint endPoint;
    CGFloat distanceY;
}

#pragma mark - private method

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    beginPoint = [touch locationInView:self.superview];
}

//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    // 1.计算两点之间的距离偏移高度。
//    UITouch *touch = [touches anyObject];
//    currentPoint = [touch locationInView:self.superview];
//    distanceY = currentPoint.y - beginPoint.y;
//    // 2.判断视图y值是否超出屏幕范围。
//    if (distanceY >= 0 && distanceY <= self.height) {
//        // 3.移动视图的y值。
//        self.y = distanceY;
//        self.height = self.height - distanceY;
//    }
//}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.y = 80.f;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    endPoint = [[touches anyObject] locationInView:self.superview];
    // 4.判断上下滑动，作相应调整
    if (endPoint.y - currentPoint.y > 0) {
        // 下滑
        [UIView animateWithDuration:0.3f animations:^{
            self.y = self.height-50;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    else {
        // 上滑
        [UIView animateWithDuration:0.3f animations:^{
            self.y = 80.f;
        }];
    }
}

@end
