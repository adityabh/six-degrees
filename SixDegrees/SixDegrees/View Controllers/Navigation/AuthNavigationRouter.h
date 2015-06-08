//
//  AuthNavigationRouter.h
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SDNavigationController;

@interface AuthNavigationRouter : NSObject

- (void)setWindow:(UIWindow *)window;
- (SDNavigationController *)defaultAuthNavStack;

@end
