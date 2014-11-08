//
//  ViewControllerFactory.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "ViewControllerFactory.h"
#import "HomeViewController.h"

#import "SignInViewController.h"
//#import "SignUpViewController.h"

#import "DreamViewController.h"

#import "BlindsidedStoryboard.h"

@implementation ViewControllerFactory

- (HomeViewController *)buildHomeVcWithDelegate:(id <HomeViewControllerDelegate>)delegate
                                       injector:(id<BSInjector>)injector {
    BlindsidedStoryboard *storyboard = [BlindsidedStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil injector:injector];
    HomeViewController *homeViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([HomeViewController class])];
    homeViewController.delegate = delegate;
    return homeViewController;
}

- (SignInViewController *)buildSignInVcWithInjector:(id<BSInjector>)injector {
    BlindsidedStoryboard *storyboard = [BlindsidedStoryboard storyboardWithName:MAIN_STORYBOARD bundle:nil injector:injector];
    SignInViewController *signInViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SignInViewController class])];
    return signInViewController;
}

- (DreamViewController *)buildDreamVcWithInjector:(id<BSInjector>)injector {
    BlindsidedStoryboard *storyboard = [BlindsidedStoryboard storyboardWithName:DREAM_STORYBOARD bundle:nil injector:injector];
    DreamViewController *dreamViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([DreamViewController class])];
    return dreamViewController;
}

@end
