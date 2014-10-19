//
//  AppDelegate.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-17.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SDModule.h"
#import "BlindsidedStoryboard.h"
#import "SDNavigationController.h"
#import "HomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIStoryboard *mainstoryBoard = [BlindsidedStoryboard storyboardWithName:@"Main" bundle:nil injector:self.injector];
    HomeViewController *homeViewController = [mainstoryBoard instantiateViewControllerWithIdentifier:NSStringFromClass([HomeViewController class])];
    SDNavigationController *navController = [[SDNavigationController alloc] initWithRootViewController:homeViewController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    return wasHandled;
}

#pragma mark -

- (id<BSModule>)module {
    if (!_module) {
        _module = [[SDModule alloc] init];
    }
    return _module;
}

- (id<BSInjector>)injector {
    if (!_injector) {
        _injector = [Blindside injectorWithModule:self.module];
    }
    return _injector;
}


@end
