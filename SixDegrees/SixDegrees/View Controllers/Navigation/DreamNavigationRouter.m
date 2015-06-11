//
//  DreamNavigationRouter.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "DreamNavigationRouter.h"

#import "AuthNavigationRouter.h"
#import "MainNavigationRouter.h"
#import "SDNavigationController.h"
#import "ViewControllerFactory.h"

#import "DreamsMainViewController.h"

#import "Lockbox.h"
#import "SDModule.h"

@interface DreamNavigationRouter () <DreamViewControllerDelegate>

    @property (strong, nonatomic) id<BSInjector> injector;
    @property (strong, nonatomic) ViewControllerFactory *vcFactory;
    @property (strong, nonatomic) UIWindow *window;

    @property (strong, nonatomic) SDNavigationController *dreamNavStack;

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

- (SDNavigationController *)defaultNavStack {
    if (!self.dreamNavStack) {
        
        DreamsMainViewController *dreamsMainViewController = [self.vcFactory buildMainDreamVcWithInjector:self injector:self.injector];
        
        AllDreamsViewControllerTableViewController *allDreamsVc = [self.vcFactory buildAllDreamVcWithInjector:dreamsMainViewController injector:self.injector];
        
        dreamsMainViewController.centerViewController = allDreamsVc;
        
        self.dreamNavStack = [[SDNavigationController alloc] initWithRootViewController:dreamsMainViewController];
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
