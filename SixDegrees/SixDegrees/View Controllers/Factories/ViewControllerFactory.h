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
@class EditUserViewController;
@class DreamsMainViewController;
@class SettingsPanelViewController;
@class AllDreamsViewControllerTableViewController;

@protocol AllDreamsViewControllerTableViewControllerDelegate;
@protocol EditUserViewControllerDelegate;
@protocol LoginViewControllerDelegate;
@protocol DreamViewControllerDelegate;
@protocol HomeViewControllerDelegate;

@interface ViewControllerFactory : NSObject

- (HomeViewController *)buildHomeVcWithDelegate:(id <HomeViewControllerDelegate>)delegate
                                       injector:(id<BSInjector>)injector;

- (LoginViewController *)buildSignInVcWithDelegate:(id<LoginViewControllerDelegate>)delegate
                                           injector:(id<BSInjector>)injector;

- (EditUserViewController *)buildEditUserVc:(id<EditUserViewControllerDelegate>)delegate
                                   injector:(id<BSInjector>)injector;

- (SWRevealViewController *) buildDreamVcWithInjector :(id<BSInjector>)injector;

@end
