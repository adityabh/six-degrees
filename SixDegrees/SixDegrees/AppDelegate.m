//
//  AppDelegate.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-17.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "AppDelegate.h"
#import "SDConstants.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "SDModule.h"

#import "MainNavigationRouter.h"
#import "SDNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupMainRouter];
    
    // Change the background color of navigation bar
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x903193)];
    
    // Change the font style of the navigation bar
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 0);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor],NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"LaoUI" size:24.0], NSFontAttributeName, nil]];
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

#pragma mark - Navigation

- (void)setupMainRouter {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MainNavigationRouter *mainRouter = (MainNavigationRouter *)[self.injector getInstance:[MainNavigationRouter class]];
    [mainRouter setWindow:self.window];
    self.window.rootViewController = [mainRouter defaultNavStack];
    [self.window makeKeyAndVisible];
}

#pragma mark - Dependency Injection

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
