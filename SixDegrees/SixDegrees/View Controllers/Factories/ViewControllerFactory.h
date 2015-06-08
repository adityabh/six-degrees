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
@class DreamViewController;
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

- (DreamViewController *)buildDreamVcWithInjector:(id<BSInjector>)injector;

- (DreamsMainViewController *)buildMainDreamVcWithInjector:(id <DreamViewControllerDelegate>)delegate
                                                                   injector:(id<BSInjector>)injector;

- (AllDreamsViewControllerTableViewController *) buildAllDreamVcWithInjector :(id<AllDreamsViewControllerTableViewControllerDelegate>)delegate
                                                                     injector:(id<BSInjector>)injector;

@end
