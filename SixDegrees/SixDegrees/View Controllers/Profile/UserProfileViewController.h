//
//  UserProfileViewController.h
//  SixDegrees
//
//  Created by Bhalla, Aditya on 6/24/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface UserProfileViewController : UIViewController

@property (nonatomic, strong) User *user;
@property (strong, nonatomic) NSArray *allDreams;

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *leftBarButton;

@property (nonatomic, weak) IBOutlet UIButton *showDreams;
@property (nonatomic, weak) IBOutlet UIButton *showHelpGiven;

@end
