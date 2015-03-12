//
//  AppDelegate.m
//  CoreHamburgerNavVC
//
//  Created by Charlin on 15-2-18.
//  Copyright (c) 2015年 Charlin. All rights reserved.
//
#import "AppDelegate.h"
#import "MyNavVC.h"
#import "IndexVC.h"
#import "LeftVC.h"
#import "CoreHamburgerManagerVC.h"
#import "NewsVC.h"
#import "AboutVC.h"
#import "MyTabbarVC.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    //首页
    IndexVC *indexVC=[[IndexVC alloc] init];
    
    //新闻
    NewsVC *newsVC=[[NewsVC alloc] init];
    
    //关于
    AboutVC *aboutVC=[[AboutVC alloc] init];
    MyTabbarVC *tabVC=[[MyTabbarVC alloc] init];
    tabVC.viewControllers=@[indexVC,newsVC,aboutVC];

    MyNavVC *navVC=[[MyNavVC alloc] initWithRootViewController:tabVC];

    
   //leftVC
    LeftVC *leftVC=[[LeftVC alloc] init];
    
    //bgView
    UIView *bgView=[[UIView alloc] init];
    bgView.backgroundColor=[UIColor brownColor];
    
    CoreHamburgerManagerVC *hamburgerManagerVC=[CoreHamburgerManagerVC hamburgerManagerVCWithMainVC:navVC bgView:bgView leftVC:leftVC scale:.8f leftMargin:280.0f];
    
    self.window.rootViewController=hamburgerManagerVC;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
