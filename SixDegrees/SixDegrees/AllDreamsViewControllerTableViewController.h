//
//  AllDreamsViewControllerTableViewController.h
//  SixDegrees
//
//  Created by Bhalla, Aditya on 5/8/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftPanelViewController.h"

/*
@protocol AllDreamsViewControllerTableViewControllerDelegate <NSObject>

@optional
- (void)movePanelRight;

@required
- (void)movePanelToOriginalPosition;
- (void)optionSelected:(NSString *)option;

@end
*/
@protocol DreamViewControllerDelegate <NSObject>
- (void)didLogout;
- (void)showHowItWorks;
@end

@interface AllDreamsViewControllerTableViewController : UITableViewController

@property (nonatomic, assign) id<DreamViewControllerDelegate> delegate;

@property (nonatomic, weak) IBOutlet UIBarButtonItem *leftBarButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *rightBarButton;
@property (strong, nonatomic) NSString *segueReason;

@end
