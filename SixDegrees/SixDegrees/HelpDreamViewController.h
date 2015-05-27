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

    @property (nonatomic, weak) IBOutlet UILabel *descLabel;
    @property (nonatomic, strong) UserDream *dream;

@end
