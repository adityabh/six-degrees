//
//  AllDreamsViewControllerTableViewController.h
//  SixDegrees
//
//  Created by Bhalla, Aditya on 5/8/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DreamViewControllerDelegate <NSObject>
- (void)didLogout;
@end

@interface AllDreamsViewControllerTableViewController : UITableViewController

    @property (weak, nonatomic) id<DreamViewControllerDelegate> delegate;
    @property (strong, nonatomic) NSString *segueReason;

@end
