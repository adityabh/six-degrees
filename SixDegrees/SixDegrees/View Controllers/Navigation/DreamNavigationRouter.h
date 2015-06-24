//
//  DreamNavigationRouter.h
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@class SDNavigationController;
@class SWRevealViewController;

@interface DreamNavigationRouter : NSObject

@property (strong, nonatomic) id<BSModule> module;

- (void)setWindow:(UIWindow *)window;
- (SWRevealViewController *)defaultNavStack;

@end
