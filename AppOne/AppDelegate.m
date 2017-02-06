//
//  AppDelegate.m
//  AppOne
//
//  Created by lile on 15/7/14.
//  Copyright (c) 2015年 lile. All rights reserved.
//
#define XcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define UMENG_APPKEY @"5695ecb267e58e343c00144e"

#import "AppDelegate.h"
#import "IntroductionViewController.h"
#import "YTKNetworkConfig.h"
#import "LoginInfoVC.h"
#import "GetUserInfo.h"
#import "CourseListModel.h"
#import "CourseIntroductionVC.h"
#import "LaunchViewController.h"
#import "MobClick.h"
#import "UMCheckUpdate.h"

@interface AppDelegate ()
@property (nonatomic, strong) IntroductionViewController *introductionView;
@property (nonatomic, assign) NSInteger userID;
@end

@implementation AppDelegate

- (void)umengTrack {
    //    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) BATCH channelId:nil];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //  友盟的方法本身是异步执行，所以不需要再异步调用
    [self umengTrack];
    [UMCheckUpdate checkUpdateWithAppkey:UMENG_APPKEY channel:nil];
    // Override point for customization after application launch.
    
    //[NSThread sleepForTimeInterval:1.0];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [_window makeKeyAndVisible];
    
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    //config.baseUrl = @"http://apis.baidu.com/apistore";
    config.baseUrl = @"http://211.101.20.203/api";
    
    
    
    //CourseIntroductionVC *vc = [[CourseIntroductionVC alloc]init];
    //LaunchViewController *vc =[[LaunchViewController alloc]init];
   // UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    //self.window.rootViewController = vc;
    
    UIViewController *rootViewController = [self setRootVC];
    [[self window] setRootViewController:rootViewController];
    
    /*
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    if(token !=nil){
        UIViewController *rootViewController = [self setRootVC];
        [[self window] setRootViewController:rootViewController];
    }else{
        LoginInfoVC *vc = [[LoginInfoVC alloc] init];
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = nav;
    }
     */
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.cmbc.AppOne" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"AppOne" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"AppOne.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


- (UITabBarController*)setRootVC
{
    LaunchViewController *homeVC =[[LaunchViewController alloc]init];
    //homeVC.hidesBottomBarWhenPushed = YES;
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    UIImage *unselectedImage = [UIImage imageNamed:@"tab_home_icon"];
    UIImage *selectedImage = [UIImage imageNamed:@"tab_home_icon_s"];
    
    //unselectedImage= [unselectedImage TransformtoSize:CGSizeMake(27, 26) ];
    //selectedImage =  [selectedImage TransformtoSize:CGSizeMake(27, 26) ];
    
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"主页"
                                                      image:[unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                              selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    homeVC.tabBarItem.tag = 0;
    
    
   TabMainVC *contentsVC = [[TabMainVC alloc] init];
    UINavigationController *contentsNav = [[UINavigationController alloc] initWithRootViewController:contentsVC];
    unselectedImage = [UIImage imageNamed:@"ico_menu"];
    selectedImage = [UIImage imageNamed:@"ico_menu_s"];
    
    //unselectedImage= [unselectedImage TransformtoSize:CGSizeMake(27, 26) ];
    //selectedImage =  [selectedImage TransformtoSize:CGSizeMake(27, 26) ];
    
    contentsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"目录"
                                                      image:[unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                              selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    contentsVC.tabBarItem.tag = 1;
    
    
    
    TabFarvoriteVC *proVC = [[TabFarvoriteVC alloc] init];
    UINavigationController *proNav = [[UINavigationController alloc] initWithRootViewController:proVC];
    unselectedImage = [UIImage imageNamed:@"ico_collection"];
    selectedImage = [UIImage imageNamed:@"ico_collection_s"];
    
    //unselectedImage= [unselectedImage TransformtoSize:CGSizeMake(27, 26) ];
    //selectedImage =  [selectedImage TransformtoSize:CGSizeMake(27, 26) ];
    
    proNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"收藏"
                                                      image:[unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                              selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    proNav.tabBarItem.tag = 2;
    
    TabPersonInfoVC * newVc = [[TabPersonInfoVC alloc] init];
    UINavigationController * newNav = [[UINavigationController alloc] initWithRootViewController:newVc];
    unselectedImage = [UIImage imageNamed:@"ico_me"];
    selectedImage = [UIImage imageNamed:@"ico_me_s"];
    //unselectedImage= [unselectedImage TransformtoSize:CGSizeMake(27, 26) ];
    //selectedImage =  [selectedImage TransformtoSize:CGSizeMake(27, 26) ];
    
    newNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人中心"
                                                      image:[unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                              selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    newNav.tabBarItem.tag = 3;
    
    


    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
   
    tabBarController.viewControllers = @[homeNav,contentsNav,proNav,newNav];
    tabBarController.delegate = self;

  //  tabBarController.delegate = self;
    
    
    // customise TabBar UI Effect
    [UITabBar appearance].tintColor = BG_COLOR;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:TABBAR_TEXT_NOR_COLOR} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:NAVBAR_COLOR} forState:UIControlStateSelected];
    
    // customise NavigationBar UI Effect
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithRenderColor:NAVBAR_COLOR renderSize:CGSizeMake(10., 10.)] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16.],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    
    UITabBar *tabBar = tabBarController.tabBar;
    tabBar.backgroundColor = BG_COLOR;
    
    return tabBarController;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"test add");
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    if(token ==nil){
        LoginInfoVC *vc = [[LoginInfoVC alloc] init];
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = nav;
        NSLog(@"%i",tabBarController.selectedIndex);
        [[Commondata sharedInstance]setSelectedIndex:tabBarController.selectedIndex];
    }
    
    // NSLog(@"%i",tabBarController.selectedIndex);
}

@end
