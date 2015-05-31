//
//  MainNavigationRouter.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "MainNavigationRouter.h"
#import "SDNavigationController.h"
#import "ViewControllerFactory.h"

#import "AuthNavigationRouter.h"
#import "DreamNavigationRouter.h"

#import "HomeViewController.h"

@interface MainNavigationRouter () <HomeViewControllerDelegate>

@property (strong, nonatomic) id<BSInjector> injector;
@property (strong, nonatomic) ViewControllerFactory *vcFactory;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SDNavigationController *mainNavStack;
@property (strong, nonatomic) AuthNavigationRouter *authRouter;
@property (strong, nonatomic) DreamNavigationRouter *dreamRouter;

@end

@implementation MainNavigationRouter

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithViewControllerFactory:authNavigationRouter:dreamNavigationRouter:)
                                  argumentKeys:[ViewControllerFactory class], [AuthNavigationRouter class], [DreamNavigationRouter class],nil];
}

- (instancetype)initWithViewControllerFactory:(ViewControllerFactory *)viewControllerFactory
                         authNavigationRouter:(AuthNavigationRouter *)authNavigationRouter
                        dreamNavigationRouter:(DreamNavigationRouter *)dreamNavigationRouter {
    self = [super init];
    if (self) {
        _vcFactory = viewControllerFactory;
        _authRouter = authNavigationRouter;
        _dreamRouter = dreamNavigationRouter;
    }
    return self;
}

- (void)setWindow:(UIWindow *)window {
    _window = window;
}

- (SDNavigationController *)defaultNavStack {
    if (!self.mainNavStack) {
        HomeViewController *homeViewController = [self.vcFactory buildHomeVcWithDelegate:self injector:self.injector];
        self.mainNavStack = [[SDNavigationController alloc] initWithRootViewController:homeViewController];
    }
    return self.mainNavStack;
}

#pragma mark - HomeViewControllerDelegate

- (void)didSwipeRightToContinue {
    //self.window.rootViewController = [self.authRouter defaultAuthNavStack];
    self.window.rootViewController = [self.dreamRouter defaultNavStack];
}

@end
