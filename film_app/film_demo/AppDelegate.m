//
//  AppDelegate.m
//  film_demo
//
//  Created by rejoin on 15/5/29.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstController.h"
#import "LoginController.h"
#import "GuideController.h"
#import "User.h"
#import "UserTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    
    NSString *key = (NSString *)kCFBundleVersionKey;
    //1.从Info.plist中取出版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    //2.从沙盒中取出版本号
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //3.页面跳转
    if ([version isEqualToString:saveVersion])
    {
       // *************（登录一次记住账号和密码）**************
        
        NSString * phoneNumber=[UserTool sharedUserTool].user.phoneNumber;
        NSString * password=[UserTool sharedUserTool].user.password;
        NSString * token=[UserTool sharedUserTool].user.token;
        
        if ((phoneNumber==nil) || (password==nil) || (token==nil)) {
            
        LoginController * login=[[LoginController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        self.window.rootViewController = nav;
        }
        else
        {
          FirstController * scan=[[FirstController alloc]init];
          UINavigationController * nav=[[UINavigationController alloc] initWithRootViewController:scan];
          self.window.rootViewController=nav;
        }
    }
    else
    {
        //如果没有版本号，就把版本号储存，立即储存
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.window.rootViewController = [GuideController new];
    }
    
    //延长启动图的持续时间
    [NSThread sleepForTimeInterval:1.0];
    
    [self.window makeKeyAndVisible];
    
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
}

@end
