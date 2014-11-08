//
//  ViewControllerFactory.h
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeViewController;
@class SignInViewController;
@class DreamViewController;
@protocol HomeViewControllerDelegate;

@interface ViewControllerFactory : NSObject

- (HomeViewController *)buildHomeVcWithDelegate:(id <HomeViewControllerDelegate>)delegate
                                       injector:(id<BSInjector>)injector;
- (SignInViewController *)buildSignInVcWithInjector:(id<BSInjector>)injector;
- (DreamViewController *)buildDreamVcWithInjector:(id<BSInjector>)injector;

@end
