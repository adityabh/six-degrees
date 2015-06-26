//
//  EditUserViewController.h
//  SixDegrees
//
//  Created by Bhalla, Aditya on 6/25/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@protocol EditUserViewControllerDelegate <NSObject>
- (void)didUpdateUser:(User *)user;
- (void)didCancelUpdate;
@end

@interface EditUserViewController : UIViewController

    @property (weak, nonatomic) id<EditUserViewControllerDelegate> delegate;
    @property (nonatomic, weak) IBOutlet UIBarButtonItem *leftBarButton;

@end
