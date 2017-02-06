//
//  IntroductionViewController.h
//  AppOne
//
//  Created by lile on 15/7/15.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidSelectedEnter)();

@interface IntroductionViewController : UIViewController

@property (nonatomic, strong) UIScrollView *pagingScrollView;
@property (nonatomic, strong) UIButton *enterButton;

@property (nonatomic, copy) DidSelectedEnter didSelectedEnter;

/**
 @[@"image1", @"image2"]
 */
@property (nonatomic, strong) NSArray *backgroundImageNames;

/**
 @[@"coverImage1", @"coverImage2"]
 */
@property (nonatomic, strong) NSArray *coverImageNames;


- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames;


- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames button:(UIButton*)button;

@end
