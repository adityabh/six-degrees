//
//  SignInViewController.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "SignInViewController.h"
#import "SDApiManager.h"
#import "FacebookAccount.h"

@interface SignInViewController ()


@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *facebookSignInButton;

@property (strong, nonatomic) SDApiManager *apiManager;

@end

@implementation SignInViewController

+ (BSPropertySet *)bsProperties {
    BSPropertySet *propertySet = [BSPropertySet propertySetWithClass:self propertyNames:@"apiManager", nil];
    [propertySet bindProperty:@"apiManager" toKey:[SDApiManager class]];
    return propertySet;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self styleView];
}

- (void)styleView {
    self.statusLabel.text = @"NOT SIGNED IN";
    self.nameLabel.text = @"";
}

#pragma mark - IBAction

//- (void)showCreateDreamForm {
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.title = @"create a dream";
//    [self.navigationController pushViewController:vc animated:YES];
//}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

@end
