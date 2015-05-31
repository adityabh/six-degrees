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
#import "LoginViewController.h"


@interface AuthNavigationRouter () <SignInViewControllerDelegate>

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
    if (!self.authNavStack) {
        LoginViewController *loginViewController = [self.vcFactory buildSignInVcWithDelegate:self
                                                                   injector:self.injector];
        
        self.authNavStack = [[SDNavigationController alloc] initWithRootViewController:loginViewController];
    }
    return self.authNavStack;
}

#pragma mark - SignInViewControllerDelegate

- (void)didSignIn {
//    BOOL userHasDream = [self.accountManager userHasDream];
//    if (userHasDream) {
//        [self.delegate completedAuthenticationFlow];
//    } else {
        [self showCreateDreamForm];
//    }
}

- (void)didCancelSignIn {
    
}

- (void)showCreateDreamForm {
    // 1. create a create-dream-form vc using the factory
    // 2. push onto the nav stack
    UIViewController *vc = [[UIViewController alloc] init];
    vc.title = @"create a dream";
    [self.authNavStack pushViewController:vc animated:YES];
}

@end
