//
//  DreamsMainViewController.h
//  SixDegrees
//
//  Created by Bhalla, Aditya on 6/7/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllDreamsViewControllerTableViewController.h"
#import "SettingsPanelViewController.h"

@protocol DreamViewControllerDelegate <NSObject>
- (void)didLogout;
@end

@interface DreamsMainViewController : UIViewController

    @property (weak, nonatomic) id<DreamViewControllerDelegate> delegate;

    @property (nonatomic, strong) AllDreamsViewControllerTableViewController *centerViewController;
    @property (nonatomic, strong) SettingsPanelViewController *leftPanelViewController;

    @property (strong, nonatomic) NSString *segueReason;

@end


