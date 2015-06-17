//
//  MainNavigationRouter.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "MainNavigationRouter.h"
#import "AuthNavigationRouter.h"
#import "DreamNavigationRouter.h"

#import "SDNavigationController.h"
#import "ViewControllerFactory.h"
#import "HomeViewController.h"
#import "SDApiManager.h"
#import "User.h"

#import "Lockbox.h"

@interface MainNavigationRouter () <HomeViewControllerDelegate>

    @property (strong, nonatomic) id<BSInjector> injector;
    @property (strong, nonatomic) ViewControllerFactory *vcFactory;
    @property (strong, nonatomic) UIWindow *window;

    @property (strong, nonatomic) SDNavigationController *mainNavStack;
    @property (strong, nonatomic) AuthNavigationRouter *authRouter;
    @property (strong, nonatomic) DreamNavigationRouter *dreamRouter;
     @property (strong, nonatomic) SDApiManager *apiManager;

@end

@implementation MainNavigationRouter

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithViewControllerFactory:authNavigationRouter:dreamNavigationRouter:apiManager:)
                                  argumentKeys:[ViewControllerFactory class], [AuthNavigationRouter class], [DreamNavigationRouter class],[SDApiManager class], nil];
}

- (instancetype)initWithViewControllerFactory:(ViewControllerFactory *)viewControllerFactory
                         authNavigationRouter:(AuthNavigationRouter *)authNavigationRouter
                        dreamNavigationRouter:(DreamNavigationRouter *)dreamNavigationRouter
                                   apiManager:(SDApiManager *)apiManager {
    self = [super init];
    if (self) {
        _vcFactory = viewControllerFactory;
        _authRouter = authNavigationRouter;
        _dreamRouter = dreamNavigationRouter;
        _apiManager = apiManager;
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
    NSString *authNToken = [Lockbox stringForKey:AUTHN_TOKEN_KEY];
    [self.apiManager getUser:authNToken
                       success:^(User *user) {
                           if (user != nil) {
                               [self.dreamRouter setWindow:self.window];
                               self.window.rootViewController = [self.dreamRouter defaultNavStack:user];
                           } else {
                               [self.authRouter setWindow:self.window];
                               self.window.rootViewController = [self.authRouter defaultAuthNavStack];
                           }
                       } failure:^(NSString *error) {
                           [self.authRouter setWindow:self.window];
                           self.window.rootViewController = [self.authRouter defaultAuthNavStack];
                       }];
}

@end
