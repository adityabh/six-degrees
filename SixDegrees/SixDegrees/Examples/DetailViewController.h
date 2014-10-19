//
//  DetailViewController.h
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-17.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

