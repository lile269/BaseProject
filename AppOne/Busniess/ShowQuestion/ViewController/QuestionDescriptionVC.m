//
//  QuestionDescriptionVC.m
//  AppOne
//
//  Created by lile on 15/10/21.
//  Copyright © 2015年 lile. All rights reserved.
//

#import "QuestionDescriptionVC.h"
#import "ShowQuestionListVC.h"

@interface QuestionDescriptionVC ()

@end

@implementation QuestionDescriptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    UILabel *tittlelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    tittlelabel.text = @"题型说明:";
    [self.view addSubview: tittlelabel];
    
    
    NSDictionary *commonQuestionHead =[[Commondata sharedInstance]commonQuestionHead];
    NSString * descripttion = [commonQuestionHead objectForKey:@"Descripttion"];
    
   // content = [content stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
    
    UILabel *contentLabel  = [[UILabel alloc] init];
    contentLabel.text          = descripttion;
    contentLabel.numberOfLines = 0;// 需要把显示行数设置成无限制
    contentLabel.font          = [UIFont systemFontOfSize:17];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    CGSize size                = [self sizeWithString:contentLabel.text font:contentLabel.font cotentType:@"01"];
    contentLabel.frame         = CGRectMake(10, 30, size.width, size.height);

    [self.view addSubview:contentLabel];
    
    UIButton *startQuestionBtn = [[UIButton alloc] initWithFrame:CGRectMake(mainWidth-170, mainHeight-170, 150,47)];
    [startQuestionBtn setBackgroundImage:[UIImage imageNamed: @"btn_ksdt"] forState:UIControlStateNormal];
    [startQuestionBtn setTitle:@"           开始答题" forState:UIControlStateNormal];
    [startQuestionBtn setTintColor:[UIColor whiteColor]];
    [startQuestionBtn addTarget:self action:@selector(startQuestionAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:startQuestionBtn];
    
    
    __weak typeof (self) wSelf = self;
    [self actionCustomLeftBtnWithNrlImage:@"btnback" htlImage:@"btnback" title:@"" action:^{
        // [wSelf.navigationController popViewControllerAnimated:YES];
        
        [wSelf.navigationController popViewControllerAnimated:YES];
       // [wSelf.navigationController popToViewController:wSelf.navigationController.viewControllers[1] animated:YES];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:16], NSFontAttributeName,nil]];
     self.title = self.tittleName;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:22], NSFontAttributeName,nil]];
    self.title = @"";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    AVAudioPlayer *player =[[Commondata sharedInstance]player];
    if (player&&[player isPlaying]) {
        [player pause];
    }
    
    [[Commondata sharedInstance]setPlayer:nil];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)startQuestionAction{
    ShowQuestionListVC *vc = [[ShowQuestionListVC alloc]init];
    vc.showType =@"01"; //练习
    vc.tittleName = self.tittleName;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Navigation

- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font cotentType:(NSString *)cotentType
{
    //题干
    if([cotentType isEqualToString:@"01"]){
        CGRect rect = [string boundingRectWithSize:CGSizeMake(mainWidth-15, 400)//限制最大的宽度和高度
                                           options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                        attributes:@{NSFontAttributeName: font}//传人的字体字典
                                           context:nil];
        
        return rect.size;}
    else{//问题选项
        CGRect rect = [string boundingRectWithSize:CGSizeMake(mainWidth-40, 400)//限制最大的宽度和高度
                                           options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                        attributes:@{NSFontAttributeName: font}//传人的字体字典
                                           context:nil];
        return rect.size;
    }
}
@end
