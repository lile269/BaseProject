//
//  QuestionResultVC.m
//  AppOne
//
//  Created by lile on 15/9/28.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "QuestionResultVC.h"
#import "ShowQuestionListVC.h"

@interface QuestionResultVC ()

@end

@implementation QuestionResultVC
@synthesize completeQuestNum;
@synthesize allQuestNum;
@synthesize wrongQuestNum;
@synthesize counterTime;
@synthesize donotNumber;
@synthesize rightQuestNum;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"考试结果";
    self.view.backgroundColor =[UIColor hexFloatColor:@"f8f8f8"];
    __weak typeof (self) wSelf = self;
    [self actionCustomLeftBtnWithNrlImage:@"btnback" htlImage:@"btnback" title:@"" action:^{
       // [wSelf.navigationController popViewControllerAnimated:YES];
        
        [wSelf.navigationController popToViewController:wSelf.navigationController.viewControllers[1] animated:YES];
    }];
    [self initContentView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [[[Commondata sharedInstance]userAnswerArray]removeAllObjects];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma view初始化
-(void) initContentView{
   // UIImage *image = [UIImage imageNamed:@""];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(mainWidth/2-50, 50, 100, 150)];
    imageView.image = [UIImage imageNamed:@"statistics_icon_water"];
    [self.view addSubview:imageView];
    
    //答题结果
    
    UILabel *resultLabel = [[UILabel alloc]initWithFrame:CGRectMake(mainWidth/2-150, 240, 300, 20)];
    
    NSString *resultString = [NSString stringWithFormat:@"答对%i题, 答错%i题, 未答%i题",rightQuestNum,wrongQuestNum,donotNumber];
    
    NSInteger completeQuestNumPostion = [NSString stringWithFormat:@"%i",rightQuestNum].length;
    NSInteger wrongQuestNumPositon =  [NSString stringWithFormat:@"%i",wrongQuestNum].length;
    
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIFont systemFontOfSize:19.0],NSFontAttributeName, nil];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:resultString attributes:attributeDict];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor hexFloatColor:@"00aeef"]
                range:NSMakeRange(2,completeQuestNumPostion)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor hexFloatColor:@"f0664a"]
                range:NSMakeRange(7+completeQuestNumPostion,wrongQuestNumPositon)];
    
    
   // [str addAttribute:NSForegroundColorAttributeName value:[UIColor hexFloatColor:@""] range:NSMakeRange(19,6)];
    resultLabel.attributedText = str;
    resultLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:resultLabel];
    
    

    UIView *scoreView = [[UIView alloc] initWithFrame:CGRectMake(0, 280, mainWidth, 45)];
    scoreView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scoreView];
    
    UIImageView *score = [[UIImageView alloc] initWithFrame:CGRectMake(85*widthRation,11, 27, 24)];
    score.image = [UIImage imageNamed:@"statistics_icon_fraction"];
    [scoreView addSubview:score];
    
    UILabel *leftScoreResult = [[UILabel alloc] initWithFrame:CGRectMake(mainWidth/2-80, 13, 80, 20)];
    leftScoreResult.font = [UIFont systemFontOfSize:19];
    leftScoreResult.textAlignment = NSTextAlignmentRight;
    
    leftScoreResult.text = [NSString stringWithFormat:@"正确率:"];
    
    [scoreView addSubview:leftScoreResult];
    

    UILabel *scoreResult = [[UILabel alloc] initWithFrame:CGRectMake(mainWidth/2, 13, 100, 20)];
    scoreResult.font = [UIFont systemFontOfSize:19];
    scoreResult.textAlignment = NSTextAlignmentLeft;
    
    scoreResult.text = [NSString stringWithFormat:@" %i％",self.correctRate];
    
    [scoreView addSubview:scoreResult];
    
    
    
    UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(0, 325, mainWidth, 45)];
    timeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:timeView];
    
    UIImageView *time = [[UIImageView alloc] initWithFrame:CGRectMake(85*widthRation-3,11, 27, 24)];
    time.image = [UIImage imageNamed:@"statistics_icon_time"];
    [timeView addSubview:time];
    
    
    
    UILabel *leftTimeResult = [[UILabel alloc] initWithFrame:CGRectMake(mainWidth/2-50, 13, 50, 20)];
    leftTimeResult.font = [UIFont systemFontOfSize:19];
    leftTimeResult.textAlignment = NSTextAlignmentRight;
    
    leftTimeResult.text = [NSString stringWithFormat:@"用时:"];
    
    [timeView addSubview:leftTimeResult];
    
    UILabel *timeResult = [[UILabel alloc] initWithFrame:CGRectMake(mainWidth/2, 13, 180, 20)];
    timeResult.font = [UIFont systemFontOfSize:19];
    timeResult.textAlignment = NSTextAlignmentLeft;
    
    timeResult.text = [NSString stringWithFormat:@" %@",counterTime];
    
    [timeView addSubview:timeResult];
 

    UIImageView* line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 280, mainWidth, 0.5)];
    line1.backgroundColor = [UIColor hexFloatColor:@"dfdfdf"];
    [self.view addSubview:line1];
    
    UIImageView* line2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 325, mainWidth, 0.5)];
    line2.backgroundColor = [UIColor hexFloatColor:@"dfdfdf"];
    [self.view addSubview:line2];
    
    UIImageView* line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 370, mainWidth, 0.5)];
    line3.backgroundColor = [UIColor hexFloatColor:@"dfdfdf"];
    [self.view addSubview:line3];
    
    UIButton *showExpalin = [[UIButton alloc]initWithFrame:CGRectMake(mainWidth/2-121, 410, 242, 54)];
    [showExpalin setBackgroundImage:[UIImage imageNamed:@"statistics_btn_answer"] forState:UIControlStateNormal];
    [showExpalin addTarget:self action:@selector(showExplainDetail) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:showExpalin];
    
}


#pragma 查看详解
-(void)showExplainDetail{
    ShowQuestionListVC *vc = [[ShowQuestionListVC alloc]init];
    vc.showType = @"04";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
