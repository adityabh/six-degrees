//
//  ViewControllerFactory.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "ViewControllerFactory.h"
#import "HomeViewController.h"

//#import "SignInViewController.h"
//#import "SignUpViewController.h"

#import "LoginViewController.h"

#import "DreamViewController.h"
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

- (DreamViewController *)buildDreamVcWithInjector:(id<BSInjector>)injector {
    BlindsidedStoryboard *storyboard = [BlindsidedStoryboard storyboardWithName:DREAM_STORYBOARD bundle:nil injector:injector];
    DreamViewController *dreamViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([DreamViewController class])];
    return dreamViewController;
}

- (AllDreamsViewControllerTableViewController *)buildAllDreamVcWithInjector:(id<BSInjector>)injector {
    BlindsidedStoryboard *storyboard = [BlindsidedStoryboard storyboardWithName:DREAM_STORYBOARD bundle:nil injector:injector];
    AllDreamsViewControllerTableViewController *allDreamsViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([AllDreamsViewControllerTableViewController class])];
    return allDreamsViewController;
}


@end
