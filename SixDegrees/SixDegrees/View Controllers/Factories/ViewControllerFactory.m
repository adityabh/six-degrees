//
//  ViewControllerFactory.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "ViewControllerFactory.h"

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "DreamsMainViewController.h"
#import "AllDreamsViewControllerTableViewController.h"

#import "BlindsidedStoryboard.h"

@implementation ViewControllerFactory

- (HomeViewController *)buildHomeVcWithDelegate:(id <HomeViewControllerDelegate>)delegate
                                       injector:(id<BSInjector>)injector {
    BlindsidedStoryboard *storyboard = [BlindsidedStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil injector:injector];
    HomeViewController *homeViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([HomeViewController class])];
    homeViewController.delegate = delegate;
    return homeViewController;
}

- (LoginViewController *)buildSignInVcWithDelegate:(id<SignInViewControllerDelegate>)delegate
                                           injector:(id<BSInjector>)injector {
    BlindsidedStoryboard *storyboard = [BlindsidedStoryboard storyboardWithName:AUTHN_STORYBOARD bundle:nil injector:injector];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([LoginViewController class])];
    loginViewController.delegate = delegate;
    return loginViewController;
}

- (DreamsMainViewController *)buildMainDreamVcWithInjector:(id <DreamViewControllerDelegate>)delegate
                                                                   injector:(id<BSInjector>)injector {
    BlindsidedStoryboard *storyboard = [BlindsidedStoryboard storyboardWithName:DREAM_STORYBOARD bundle:nil injector:injector];
    DreamsMainViewController *dreamMainViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([DreamsMainViewController class])];
    dreamMainViewController.delegate = delegate;
    return dreamMainViewController;
}

- (AllDreamsViewControllerTableViewController *) buildAllDreamVcWithInjector :(id<AllDreamsViewControllerTableViewControllerDelegate>)delegate
                                                                     injector:(id<BSInjector>)injector {
    BlindsidedStoryboard *storyboard = [BlindsidedStoryboard storyboardWithName:DREAM_STORYBOARD bundle:nil injector:injector];
    AllDreamsViewControllerTableViewController *allDreamVc = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([AllDreamsViewControllerTableViewController class])];
    allDreamVc.delegate = delegate;
    return allDreamVc;
}



@end
