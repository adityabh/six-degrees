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

@protocol LoginViewControllerDelegate <NSObject>
- (void)didLogin;
@end

@interface LoginViewController : SDViewController

    @property (weak, nonatomic) id<LoginViewControllerDelegate> delegate;

@end
