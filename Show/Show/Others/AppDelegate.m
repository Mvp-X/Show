//
//  AppDelegate.m
//  Show
//
//  Created by Colorful on 16/5/23.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "AppDelegate.h"
#import "MvpMainGuideController.h"
#import "MvpMainTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 创建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 设置根控制器
    self.window.rootViewController = [self pickViewController];
    
    // 显示window
    [self.window makeKeyAndVisible];
    
    // 把当前的版本号(info) 存到沙河
      [self saveAppVersion];
    
    return YES;
}

-(UIViewController *)pickViewController{
    
    // 获取当前程序的版本(info.plist里面的版本号)和沙盒之前保存的版本号对比
    if ([[self loadAppVersion] isEqualToString:[self loadSavedAppVersion]]) {
        // 如果 一样 显示tabbar
        MvpMainTabBarController* tabbarController = [[MvpMainTabBarController alloc]init];
        
        return tabbarController;
    }
    else {
        // 如果不一样 那么显示 新特性
        MvpMainGuideController* guideController = [[MvpMainGuideController alloc]init];
        
        return guideController;;
    }
    
    
    
}

//获取info的版本号
- (NSString *)loadAppVersion
{
    //获取info字典
    NSDictionary* dict = [NSBundle mainBundle].infoDictionary;
    
    return dict[@"CFBundleShortVersionString"];
}

// 把当前info中的版本号 保存到沙盒中
- (void)saveAppVersion
{
    // 获取info的版本号
    NSDictionary* dict = [NSBundle mainBundle].infoDictionary;
    
    // 保存到沙盒
    [[NSUserDefaults standardUserDefaults] setObject:dict[@"CFBundleShortVersionString"] forKey:@"appVersion"];
}


// 获取沙盒中保存的版本号
- (NSString*)loadSavedAppVersion
{
    // 获取单例
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"appVersion"];
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
