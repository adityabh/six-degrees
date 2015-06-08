//
//  AllDreamsViewControllerTableViewController.h
//  SixDegrees
//
//  Created by Bhalla, Aditya on 5/8/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsPanelViewController.h"

@protocol AllDreamsViewControllerTableViewControllerDelegate <NSObject>

@optional
- (void)movePanelLeft;
- (void)movePanelRight;

@required
- (void)movePanelToOriginalPosition;
- (void)didLogout;

@end

@interface AllDreamsViewControllerTableViewController : UITableViewController <SettingsPanelViewControllerDelegate>

@property (nonatomic, assign) id<AllDreamsViewControllerTableViewControllerDelegate> delegate;

@property (nonatomic, weak) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) NSString *segueReason;

@end
