//
//  LoginViewController.h
//  SixDegrees
//
//  Created by Bhalla, Aditya on 5/26/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "SDViewController.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@protocol SignInViewControllerDelegate <NSObject>
- (void)didCancelSignIn;
- (void)didSignIn;
@end

@interface LoginViewController : SDViewController

    @property (weak, nonatomic) id<SignInViewControllerDelegate> delegate;

@end
