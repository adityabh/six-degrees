//
//  DreamNavigationRouter.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "DreamNavigationRouter.h"
#import "SDNavigationController.h"
#import "ViewControllerFactory.h"

#import "DreamViewController.h"

@interface DreamNavigationRouter ()

@property (strong, nonatomic) id<BSInjector> injector;
@property (strong, nonatomic) ViewControllerFactory *vcFactory;

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
        DreamViewController *dreamViewController = [self.vcFactory buildDreamVcWithInjector:self.injector];
        self.dreamNavStack = [[SDNavigationController alloc] initWithRootViewController:dreamViewController];
    }
    return self.dreamNavStack;
}

@end
