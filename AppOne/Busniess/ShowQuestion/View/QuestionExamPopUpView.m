//
//  QuestionExamPopUpView.m
//  AppOne
//
//  Created by lile on 15/8/11.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "QuestionExamPopUpView.h"

@implementation QuestionExamPopUpView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self drawExamQuesitonResult];
    }
    return self;
}

-(void) drawExamQuesitonResult{
   NSArray *answerArray = [[Commondata sharedInstance]questionArray];
    CGFloat buttonWidith = (mainWidth - 6*35)/7;;
    NSInteger groupNum = [answerArray count]/6;
    CGFloat startY = 40;
    NSInteger num = 0;
    for (NSInteger i = 0; i<=groupNum; i++) {
        NSInteger lineNum =6;
        CGFloat startX = buttonWidith;
        if (i==groupNum) {
            lineNum = [answerArray count]%6;
        }
        for (NSInteger k=0; k<lineNum; k++) {
            UIButton *button = [[UIButton alloc]init];
            button.tag = num;
            //button.backgroundColor = [UIColor redColor];
            [button setTitle:[NSString stringWithFormat:@"%d",num+1] forState:UIControlStateNormal];
            [button setTintColor:[UIColor blackColor]];
            button.frame = CGRectMake(startX, startY+i*50, 35, 35);
            if (lineNum>3) {
                [button setBackgroundImage:[UIImage imageNamed:@"BetRedBall.png"] forState:UIControlStateNormal];
            }else
                [button setBackgroundImage:[UIImage imageNamed:@"BetGrayBall.png"] forState:UIControlStateNormal];
            
          //  button.clipsToBounds = YES;
            startX = startX+35+buttonWidith;
            [button addTarget:self action:@selector(ButtonClicked:)forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            num++;
        }
        
    }
    [self setContentSize:CGSizeMake(mainWidth, startY+groupNum*50)];
}

-(void) ButtonClicked:(id)sender{
    UIButton *button = (UIButton *)sender;
    NSLog(@"button=%ld",(long)button.tag);
    
    if([self.selectDelegate respondsToSelector:@selector(buttonClicked:)])
    {
        
        //send the delegate function with the amount entered by the user
        [self.selectDelegate buttonClicked:(long)button.tag];
    }
}


@end
