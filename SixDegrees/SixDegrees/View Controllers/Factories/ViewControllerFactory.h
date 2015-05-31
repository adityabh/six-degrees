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
@class AllDreamsViewControllerTableViewController;
@protocol SignInViewControllerDelegate;
@protocol HomeViewControllerDelegate;

@interface ViewControllerFactory : NSObject

- (HomeViewController *)buildHomeVcWithDelegate:(id <HomeViewControllerDelegate>)delegate
                                       injector:(id<BSInjector>)injector;

- (LoginViewController *)buildSignInVcWithDelegate:(id<SignInViewControllerDelegate>)delegate
                                           injector:(id<BSInjector>)injector;

- (DreamViewController *)buildDreamVcWithInjector:(id<BSInjector>)injector;

- (AllDreamsViewControllerTableViewController *)buildAllDreamVcWithInjector:(id<BSInjector>)injector;

@end
