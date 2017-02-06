//
//  SelectControlCellTableViewCell.m
//  AppOne
//
//  Created by lile on 15/8/3.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "SelectControlCell.h"

@implementation SelectControlCell

- (void)awakeFromNib {
    // Initialization code
    
    [self setNeedsDisplay];

}

-(void)drawRect:(CGRect)rect
{
    UIImageView* imgLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-3, self.frame.size.width, 1)];
    imgLine.backgroundColor = [UIColor hexFloatColor:@"dedede"];
    [self addSubview:imgLine];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selfDefinePractice:(UIButton *)sender {
    NSLog(@"self define");
    if ([_delegate respondsToSelector:@selector(choseTerm:course_id:)]) {
        sender.tag = 0;
        [_delegate choseTerm:sender course_id:self.courseID];
    }
    
}
- (IBAction)OrderPractice:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(choseTerm:course_id:)]) {
        sender.tag = 1;
        [_delegate choseTerm:sender course_id:self.courseID];
    }
}
- (IBAction)createExam:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(choseTerm:course_id:)]) {
        sender.tag = 2;
        [_delegate choseTerm:sender course_id:self.courseID];
    }
}

@end
