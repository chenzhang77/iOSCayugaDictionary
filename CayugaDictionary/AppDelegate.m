//
//  AppDelegate.m
//  CayugaDictionary
//
//  Created by cz5670 on 2017-09-27.
//  Copyright © 2017 winemocol. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "MenuViewController.h"
#import "DictionaryViewController.h"
#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"

@interface AppDelegate ()
@property (nonatomic,strong) MMDrawerController * drawerController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    MenuViewController *menuVC = [[MenuViewController alloc] init];
    UINavigationController *dictionaryNav = [[UINavigationController alloc] initWithRootViewController:[[DictionaryViewController alloc] init]];
    dictionaryNav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    dictionaryNav.navigationBar.tintColor = [UIColor whiteColor];
    dictionaryNav.navigationBar.barTintColor = [UIColor colorWithRed:204/255.0 green:153/255.0 blue:255/255.0 alpha:1];
    //dictionaryNav.navigationBar.image
    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:dictionaryNav leftDrawerViewController:menuVC];
    [self.drawerController setShowsShadow:YES];
    [self.drawerController setMaximumLeftDrawerWidth:kScreenWidth-100];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self.drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMExampleDrawerVisualStateManager sharedManager]
                 drawerVisualStateBlockForDrawerSide:drawerSide];
        if(block){
            block(drawerController, drawerSide, percentVisible);
        }
    }];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:self.drawerController];
    

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
