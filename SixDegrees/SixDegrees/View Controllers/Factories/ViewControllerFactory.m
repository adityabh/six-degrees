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
#import "EditUserViewController.h"
#import "SWRevealViewController.h"
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

- (LoginViewController *)buildSignInVcWithDelegate:(id<LoginViewControllerDelegate>)delegate
                                           injector:(id<BSInjector>)injector {
    BlindsidedStoryboard *storyboard = [BlindsidedStoryboard storyboardWithName:AUTHN_STORYBOARD bundle:nil injector:injector];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([LoginViewController class])];
    loginViewController.delegate = delegate;
    return loginViewController;
}

- (EditUserViewController *)buildEditUserVc:(id<EditUserViewControllerDelegate>)delegate
                                   injector:(id<BSInjector>)injector {
    BlindsidedStoryboard *storyboard = [BlindsidedStoryboard storyboardWithName:AUTHN_STORYBOARD bundle:nil injector:injector];
    EditUserViewController *editUserViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([EditUserViewController class])];
    editUserViewController.delegate = delegate;
    return editUserViewController;
}

- (SWRevealViewController *) buildDreamVcWithInjector :(id<BSInjector>)injector {
    BlindsidedStoryboard *storyboard = [BlindsidedStoryboard storyboardWithName:DREAM_STORYBOARD bundle:nil injector:injector];
    SWRevealViewController *revealViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SWRevealViewController class])];
    return revealViewController;
}

@end
