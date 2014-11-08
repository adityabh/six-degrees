//
//  HomeViewController.h
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-18.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "SDViewController.h"

@protocol HomeViewControllerDelegate <NSObject>
- (void)didSwipeRightToContinue;
@end

@interface HomeViewController : SDViewController

@property (weak, nonatomic) id <HomeViewControllerDelegate> delegate;

@end
