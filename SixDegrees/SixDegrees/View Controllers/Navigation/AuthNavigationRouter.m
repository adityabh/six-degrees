//
//  AuthNavigationRouter.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "AuthNavigationRouter.h"
#import "SDNavigationController.h"
#import "ViewControllerFactory.h"

#import "SignInViewController.h"

@interface AuthNavigationRouter ()

@property (strong, nonatomic) id<BSInjector> injector;
@property (strong, nonatomic) ViewControllerFactory *vcFactory;

@property (strong, nonatomic) SDNavigationController *authNavStack;

@end

@implementation AuthNavigationRouter

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

- (SDNavigationController *)defaultAuthNavStack {
#warning If auth persisted, do something else here
    if (!self.authNavStack) {
        SignInViewController *signInViewController = [self.vcFactory buildSignInVcWithInjector:self.injector];
        self.authNavStack = [[SDNavigationController alloc] initWithRootViewController:signInViewController];
    }
    return self.authNavStack;
}

@end
