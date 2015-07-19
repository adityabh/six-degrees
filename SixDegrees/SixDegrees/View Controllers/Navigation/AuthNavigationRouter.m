//
//  AuthNavigationRouter.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "AuthNavigationRouter.h"
#import "DreamNavigationRouter.h"
#import "SDNavigationController.h"
#import "EditUserViewController.h"
#import "ViewControllerFactory.h"
#import "LoginViewController.h"
#import "SignupViewController.h"
#import "AppDelegate.h"


@interface AuthNavigationRouter () <LoginViewControllerDelegate, SignupViewControllerDelegate, EditUserViewControllerDelegate>

    @property (strong, nonatomic) id<BSInjector> injector;
    @property (strong, nonatomic) ViewControllerFactory *vcFactory;
    @property (strong, nonatomic) UIWindow *window;

    @property (strong, nonatomic) SDNavigationController *authNavStack;
    @property (strong, nonatomic) DreamNavigationRouter *dreamRouter;

@end

@implementation AuthNavigationRouter

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithViewControllerFactory:dreamNavigationRouter:)
                                  argumentKeys:[ViewControllerFactory class], [DreamNavigationRouter class], nil];
}

- (instancetype)initWithViewControllerFactory:(ViewControllerFactory *)viewControllerFactory
                        dreamNavigationRouter:(DreamNavigationRouter *)dreamNavigationRouter{
    self = [super init];
    if (self) {
        _vcFactory = viewControllerFactory;
        _dreamRouter = dreamNavigationRouter;
    }
    return self;
}

- (void)setWindow:(UIWindow *)window {
    _window = window;
}

- (SDNavigationController *)defaultAuthNavStack {
    AppDelegate *appDel = (AppDelegate*) [UIApplication sharedApplication].delegate;
    if (appDel.user == nil) {
        LoginViewController *loginViewController = [self.vcFactory buildSignInVcWithDelegate:self
                                                                                        injector:self.injector];
        self.authNavStack = [[SDNavigationController alloc] initWithRootViewController:loginViewController];
    } else {
        EditUserViewController *editUserViewController = [self.vcFactory buildEditUserVc:self
                                                                                    injector:self.injector];
        self.authNavStack = [[SDNavigationController alloc] initWithRootViewController:editUserViewController];
    }
    return self.authNavStack;
}

#pragma mark - LogViewControllerDelegate

- (void)didLogin:(User *)user {
    AppDelegate *appDel = (AppDelegate*) [UIApplication sharedApplication].delegate;
    appDel.user = user;
    [self.dreamRouter setWindow:self.window];
    self.window.rootViewController = [self.dreamRouter defaultNavStack];
}

- (void)didSignup:(User *)user {
    AppDelegate *appDel = (AppDelegate*) [UIApplication sharedApplication].delegate;
    appDel.user = user;
    [self.dreamRouter setWindow:self.window];
    self.window.rootViewController = [self.dreamRouter defaultNavStack];
}

- (void)didUpdateUser:(User *)user {
    // TODO: add app delegate logic after API
    [self.dreamRouter setWindow:self.window];
    self.window.rootViewController = [self.dreamRouter defaultNavStack];
}

- (void)didCancelUpdate {
    [self.dreamRouter setWindow:self.window];
    self.window.rootViewController = [self.dreamRouter defaultNavStack];
}

- (void)didCancelSignIn {
    
}

@end
