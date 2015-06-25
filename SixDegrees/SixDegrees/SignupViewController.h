//
//  SignupViewController.h
//  SixDegrees
//
//  Created by Bhalla, Aditya on 5/31/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "SDViewController.h"
#import "User.h"

@protocol SignupViewControllerDelegate <NSObject>
- (void)didSignup:(User *)user;
@end

@interface SignupViewController : SDViewController

    @property (weak, nonatomic) id<SignupViewControllerDelegate> delegate;
    @property (nonatomic, weak) IBOutlet UIBarButtonItem *leftBarButton;

@end
