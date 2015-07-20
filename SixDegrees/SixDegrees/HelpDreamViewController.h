//
//  HelpDreamViewController.h
//  SixDegrees
//
//  Created by Bhalla, Aditya on 5/26/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDream.h"

@interface HelpDreamViewController : UIViewController

    @property (nonatomic, weak) IBOutlet UIBarButtonItem *leftBarButton;

    @property (nonatomic, weak) IBOutlet UILabel *nameLabel;
    @property (nonatomic, weak) IBOutlet UIImageView *profileImageView;

    @property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
    @property (weak, nonatomic) IBOutlet UIImageView *typeIcon;

    @property (weak, nonatomic) IBOutlet UITextField *helpMessage;
    @property (weak, nonatomic) IBOutlet UIButton *helpButton;

    @property (nonatomic, strong) UserDream *dream;

@end
