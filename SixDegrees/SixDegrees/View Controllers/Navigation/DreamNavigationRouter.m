//
//  DreamNavigationRouter.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "SWRevealViewController.h"
#import "SDNavigationController.h"
#import "DreamNavigationRouter.h"
#import "ViewControllerFactory.h"
#import "AuthNavigationRouter.h"
#import "MainNavigationRouter.h"
#import "SDModule.h"
#import "Lockbox.h"

@interface DreamNavigationRouter () <SWRevealViewControllerDelegate>

    @property (strong, nonatomic) id<BSInjector> injector;
    @property (strong, nonatomic) ViewControllerFactory *vcFactory;
    @property (strong, nonatomic) UIWindow *window;

    @property (strong, nonatomic) SWRevealViewController *dreamNavStack;

@end

@implementation DreamNavigationRouter

+ (BSInitializer *)bsInitializer {
    return [BSInitializer initializerWithClass:self
                                      selector:@selector(initWithViewControllerFactory:)
                                  argumentKeys:[ViewControllerFactory class], nil];
}

- (instancetype)initWithViewControllerFactory:(ViewControllerFactory *)viewControllerFactory {
    self = [super init];
    if (self) {
        _vcFactory = viewControllerFactory;
    }
    return self;
}

- (SWRevealViewController *)defaultNavStack {
    if (!self.dreamNavStack) {
        
        SWRevealViewController *revealViewController = [self.vcFactory buildDreamVcWithInjector:self.injector];
        revealViewController.delegate = self;
        self.dreamNavStack = revealViewController;
    }
    return self.dreamNavStack;
}

- (void)setWindow:(UIWindow *)window {
    _window = window;
}

#pragma mark - DreamViewControllerDelegate

- (void)didLogout {
    [Lockbox setString:@"" forKey:AUTHN_TOKEN_KEY];
    AuthNavigationRouter *authRouter = (AuthNavigationRouter *)[self.injector getInstance:[AuthNavigationRouter class]];
    [authRouter setWindow:self.window];
    self.window.rootViewController = [authRouter defaultAuthNavStack];
}

- (void)showHowItWorks {
    MainNavigationRouter *mainRouter = (MainNavigationRouter *)[self.injector getInstance:[MainNavigationRouter class]];
    [mainRouter setWindow:self.window];
    self.window.rootViewController = [mainRouter defaultNavStack];
}

- (void)showSettings {
    AuthNavigationRouter *authRouter = (AuthNavigationRouter *)[self.injector getInstance:[AuthNavigationRouter class]];
    [authRouter setWindow:self.window];
    self.window.rootViewController = [authRouter defaultAuthNavStack];
}

#pragma mark - Dependency Injection

- (id<BSModule>)module {
    if (!_module) {
        _module = [[SDModule alloc] init];
    }
    return _module;
}

- (id<BSInjector>)injector {
    if (!_injector) {
        _injector = [Blindside injectorWithModule:self.module];
    }
    return _injector;
}

@end
