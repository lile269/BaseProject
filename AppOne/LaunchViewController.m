//
//  LaunchViewController.m
//  AppOne
//
//  Created by lile on 15/11/25.
//  Copyright © 2015年 lile. All rights reserved.
//

#import "LaunchViewController.h"
#import "CourseDescriptionVC.h"
#import "LoginInfoVC.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController
@synthesize player;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:YES];
  //  [self makeTabBarHidden:YES];
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainWidth, mainHeight)];
    iconImageView.image = [UIImage imageNamed:@"backgroundImage"];
    [self.view addSubview:iconImageView];
    
    

    UIButton *courseDescButton = [[UIButton alloc]initWithFrame:CGRectMake(0, mainHeight-51, mainWidth/2, 51)];
    courseDescButton.backgroundColor = [UIColor hexFloatColor:@"5fc7db"];
    
    UIImageView *courseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(mainWidth/4-50, 13, 32, 25)];
    courseImageView.image = [UIImage imageNamed:@"icon_kcsm"];
    
    UILabel *courseDescLabel = [[UILabel alloc]initWithFrame:CGRectMake(mainWidth/4, 15, 70, 20)];
    courseDescLabel.text = @"课程介绍";
    courseDescLabel.textColor = [UIColor whiteColor];
    courseDescLabel.font = [UIFont systemFontOfSize:15];
    
    [courseDescButton addSubview:courseImageView];
    [courseDescButton addSubview:courseDescLabel];
    
    [courseDescButton addTarget:self
                         action:@selector(courseDescAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:courseDescButton];
    
    
    UIButton *startCourseButton = [[UIButton alloc]initWithFrame:CGRectMake(mainWidth/2, mainHeight-51, mainWidth/2, 51)];
    startCourseButton.backgroundColor = [UIColor hexFloatColor:@"8ac033"];
    
    UIImageView *startCourseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(mainWidth/4-50, 13, 32, 25)];
    startCourseImageView.image = [UIImage imageNamed:@"icon_ksxx"];
    [startCourseButton addSubview:startCourseImageView];
    
    UILabel *startCourseDescLabel = [[UILabel alloc]initWithFrame:CGRectMake(mainWidth/4, 15, 70, 20)];
    startCourseDescLabel.text = @"开始练习";
    startCourseDescLabel.textColor = [UIColor whiteColor];
    startCourseDescLabel.font = [UIFont systemFontOfSize:15];
    [startCourseButton addSubview: startCourseDescLabel];
    
    [startCourseButton addTarget:self
                         action:@selector(startCourseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startCourseButton];
   [self playHeadAudio];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
     [self.tabBarController.tabBar setHidden:NO];
}



-(void)playHeadAudio{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"head" ofType:@"mp3"];
    //UIImage *appleImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
    NSError * error;
    NSURL * url = [NSURL fileURLWithPath:filePath];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [player prepareToPlay];
    if(error){
         NSLog(@"%@",[error localizedDescription]);
    }
    [player play];
    //player.delegate = self;
}
-(void)courseDescAction{
   // UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    CourseDescriptionVC *vc = [[CourseDescriptionVC alloc] init];
//    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    // UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    window.rootViewController = nav;
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)startCourseAction{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    if(token ==nil){
        LoginInfoVC *vc = [[LoginInfoVC alloc] init];
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
        window.rootViewController = nav;
        //NSLog(@"%i",tabBarController.selectedIndex);
        [[Commondata sharedInstance]setSelectedIndex:1];
    }else
    self.tabBarController.selectedIndex = 1;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
