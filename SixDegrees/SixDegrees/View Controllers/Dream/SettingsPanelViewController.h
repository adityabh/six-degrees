//
//  SettingsPanelViewController.h
//  SixDegrees
//
//  Created by Bhalla, Aditya on 6/3/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsPanelViewControllerDelegate <NSObject>

@required
- (void)optionSelected:(NSString *)option;

@end

@interface SettingsPanelViewController : UITableViewController

@property (nonatomic, assign) id<SettingsPanelViewControllerDelegate> delegate;

@end
