//
//  AppDelegate.m
//  PMTabBarControllerDemo
//
//  Created by apollo on 21/11/2016.
//  Copyright © 2016 projm. All rights reserved.
//

#import "AppDelegate.h"
#import "PMTabBarController.h"

@interface AppDelegate ()
@property (nonatomic, strong) PMTabBarController *rootVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _rootVC = [PMTabBarController new];
    UIViewController *v1 = [UIViewController new];
    v1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"one" image:[UIImage imageNamed:@"pic"] tag:1];
    [v1.view setBackgroundColor:[UIColor redColor]];
    UIViewController *v2 = [UIViewController new];
    v2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"two" image:[UIImage imageNamed:@"pic"] tag:2];
    [v2.view setBackgroundColor:[UIColor blueColor]];
    _rootVC.viewControllers = @[v1, v2];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [_rootVC insertView:btn atIndex:1];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [_rootVC insertView:btn2 atIndex:2];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = _rootVC;
    [self.window makeKeyAndVisible]; // Should Add This in OC
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
