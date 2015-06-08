//
//  SignupViewController.h
//  SixDegrees
//
//  Created by Bhalla, Aditya on 5/31/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "SDViewController.h"

@protocol SignupViewControllerDelegate <NSObject>
- (void)didCancelSignup;
- (void)didSignup;
@end

@interface SignupViewController : SDViewController

    @property (weak, nonatomic) id<SignupViewControllerDelegate> delegate;

@end
