//
//  QuestionExamPopUpView.h
//  AppOne
//
//  Created by lile on 15/8/11.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "PopUpView.h"
@protocol SelectQuestionViewDelegate <NSObject>

- (void) buttonClicked:(long)num;

@end

@interface QuestionExamPopUpView : UIScrollView

@property (nonatomic,weak) id<SelectQuestionViewDelegate> selectDelegate;
@end
