//
//  AppDelegate.m
//  MusicPro
//
//  Created by apple  on 14-3-21.
//  Copyright (c) 2014年 zdzhong. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "MenuVIewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) TWTSideMenuViewController *sideMenuViewController;
@property (nonatomic, strong) MainViewController *mainViewController;
@property (nonatomic, strong) MenuViewController *menuViewController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.menuViewController = [[MenuViewController alloc] initWithNibName:nil bundle:nil];
    self.mainViewController = [[MainViewController alloc] initWithNibName:nil bundle:nil];
    
    self.sideMenuViewController =
                [[TWTSideMenuViewController alloc]
                initWithMenuViewController:self.menuViewController
                        mainViewController:[[UINavigationController alloc]initWithRootViewController:
                                            self.mainViewController]
                 ];
    self.sideMenuViewController.shadowColor = [UIColor blackColor];
    self.sideMenuViewController.edgeOffset = (UIOffset) { .horizontal = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 18.0f : 0.0f };
    self.sideMenuViewController.zoomScale = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 0.5634f : 0.85f;
    self.sideMenuViewController.delegate = self;
    self.window.rootViewController = self.sideMenuViewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
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

#pragma -mark TWTSideMenuViewControllerDelegate

- (void)sideMenuViewControllerWillOpenMenu:(TWTSideMenuViewController *)sideMenuViewController
{
    if ([self.mainViewController respondsToSelector:@selector(sideMenuViewControllerWillOpenMenu:)]) {
        [self.mainViewController sideMenuViewControllerWillOpenMenu:self.sideMenuViewController];
    }
    if ([self.menuViewController respondsToSelector:@selector(sideMenuViewControllerWillOpenMenu:)]) {
        [self.menuViewController sideMenuViewControllerWillOpenMenu:self.sideMenuViewController];
    }
}
- (void)sideMenuViewControllerDidOpenMenu:(TWTSideMenuViewController *)sideMenuViewController
{
    if ([self.mainViewController respondsToSelector:@selector(sideMenuViewControllerDidOpenMenu:)]) {
        [self.mainViewController sideMenuViewControllerDidOpenMenu:self.sideMenuViewController];
    }
    if ([self.menuViewController respondsToSelector:@selector(sideMenuViewControllerDidOpenMenu:)]) {
        [self.menuViewController sideMenuViewControllerDidOpenMenu:self.sideMenuViewController];
    }
}
- (void)sideMenuViewControllerWillCloseMenu:(TWTSideMenuViewController *)sideMenuViewController
{
    if ([self.mainViewController respondsToSelector:@selector(sideMenuViewControllerWillCloseMenu:)]) {
        [self.mainViewController sideMenuViewControllerWillCloseMenu:self.sideMenuViewController];
    }
    if ([self.menuViewController respondsToSelector:@selector(sideMenuViewControllerWillCloseMenu:)]) {
        [self.menuViewController sideMenuViewControllerWillCloseMenu:self.sideMenuViewController];
    }
}
- (void)sideMenuViewControllerDidCloseMenu:(TWTSideMenuViewController *)sideMenuViewController
{
    if ([self.mainViewController respondsToSelector:@selector(sideMenuViewControllerDidCloseMenu:)]) {
        [self.mainViewController sideMenuViewControllerDidCloseMenu:self.sideMenuViewController];
    }
    if ([self.menuViewController respondsToSelector:@selector(sideMenuViewControllerDidCloseMenu:)]) {
        [self.menuViewController sideMenuViewControllerDidCloseMenu:self.sideMenuViewController];
    }
}

@end
