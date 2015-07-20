//
//  HelpCellTableViewCell.h
//  SixDegrees
//
//  Created by Bhalla, Aditya on 7/19/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpCellTableViewCell : UITableViewCell

    @property (nonatomic, weak) IBOutlet UIImageView *profileImage;
    @property (nonatomic, weak) IBOutlet UILabel *profileName;
    @property (nonatomic, weak) IBOutlet UILabel *message;

@end
