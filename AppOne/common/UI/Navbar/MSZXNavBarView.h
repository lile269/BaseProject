//
//  MSZXNavBarView.h
//  MSZXFramework
//
//  Created by wenyanjie on 14-12-12.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSZXNavBarModel.h"
#import "MSZXBarButtonItem.h"

@interface MSZXNavBarView : UIView

@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) UIImageView *backgroundImageView;
@property(nonatomic, strong) UILabel * navLabel;
@property(nonatomic, strong) MSZXButton *leftBarButton;
@property(nonatomic, strong) MSZXButton *rightBarButton;
@property(nonatomic, strong) MSZXBarButtonItem *leftButtonItem;
@property(nonatomic, strong) MSZXBarButtonItem *rightButtonItem;
@property(nonatomic, copy) NSString *leftButtonState;

@end
