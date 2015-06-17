//
//  DreamCellTableViewCell.h
//  SixDegrees
//
//  Created by Bhalla, Aditya on 5/12/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface DreamCellTableViewCell : UITableViewCell

    @property (nonatomic, weak) IBOutlet UILabel *nameLabel;
    @property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
    @property (nonatomic, weak) IBOutlet UIImageView *profileImageView;
    @property (weak, nonatomic) IBOutlet UIImageView *typeIcon;
    @property (weak, nonatomic) IBOutlet UIButton *helpButton;

@end
