//
//  SignInViewController.h
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "SDViewController.h"

@protocol SignInViewControllerDelegate <NSObject>
- (void)didCancelSignIn;
- (void)didSignIn;
@end

@interface SignInViewController : SDViewController

@property (weak, nonatomic) id<SignInViewControllerDelegate> delegate;

@end