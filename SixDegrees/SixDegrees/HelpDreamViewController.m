//
//  HelpDreamViewController.m
//  SixDegrees
//
//  Created by Bhalla, Aditya on 5/26/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "HelpDreamViewController.h"
#import "User.h"

@interface HelpDreamViewController ()

    @property (weak, nonatomic) IBOutlet UITextField *helpDescription;
    @property (weak, nonatomic) IBOutlet UIBarButtonItem *helpButton;

@end

@implementation HelpDreamViewController

@synthesize descLabel;
@synthesize dream;

- (void)viewDidLoad {
    [super viewDidLoad];

    descLabel.text = [NSString stringWithFormat:@"%@ %@ %@", @"Send a message to", dream.user.firstName, @"(optional)"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender != self.helpButton) return;
    
}


@end
