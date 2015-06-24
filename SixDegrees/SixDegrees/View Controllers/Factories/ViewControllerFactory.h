//
//  ViewControllerFactory.h
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeViewController;
@class LoginViewController;
@class SWRevealViewController;
@class DreamsMainViewController;
@class SettingsPanelViewController;
@class AllDreamsViewControllerTableViewController;

@protocol SignInViewControllerDelegate;
@protocol DreamViewControllerDelegate;
@protocol HomeViewControllerDelegate;
@protocol AllDreamsViewControllerTableViewControllerDelegate;

@interface ViewControllerFactory : NSObject

- (HomeViewController *)buildHomeVcWithDelegate:(id <HomeViewControllerDelegate>)delegate
                                       injector:(id<BSInjector>)injector;

- (LoginViewController *)buildSignInVcWithDelegate:(id<SignInViewControllerDelegate>)delegate
                                           injector:(id<BSInjector>)injector;

- (SWRevealViewController *) buildDreamVcWithInjector :(id<BSInjector>)injector;

@end
