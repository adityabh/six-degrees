//
//  HomeViewController.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-18.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "HomeViewController.h"
#import "SDApiManager.h"
#import "FacebookManager.h"
#import "FacebookAccount.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *facebookSignInButton;
@property (weak, nonatomic) IBOutlet FBProfilePictureView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (strong, nonatomic) SDApiManager *apiManager;
@property (strong, nonatomic) FacebookManager *facebookManager;

@end

@implementation HomeViewController

+ (BSPropertySet *)bsProperties {
    BSPropertySet *propertySet = [BSPropertySet propertySetWithClass:self propertyNames:@"apiManager", @"facebookManager", nil];
    [propertySet bindProperty:@"apiManager" toKey:[SDApiManager class]];
    [propertySet bindProperty:@"facebookManager" toKey:[FacebookManager class]];
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

- (IBAction)facebookSignInTapped:(id)sender {
    [self.facebookManager fetchFbUserWithSuccess:^{
        self.statusLabel.text = @"SIGNED IN AS";
        self.nameLabel.text = self.facebookManager.facebookAccount.name;
#warning TODO:  Move this to user manager
        [self.apiManager authenticateWithFacebookId:self.facebookManager.facebookAccount.sdFacebookUserId
                                      facebookToken:self.facebookManager.accessToken
                                          userEmail:self.facebookManager.facebookAccount.email
                                            success:^{
                                                [self showAlertViewWithTitle:@"Success!" message:@"Authenticated against Six-Degrees API"];
                                            } failure:^(NSError *error) {
                                                [self showAlertViewWithTitle:@"Failure!" message:error.description];
                                            }];
    } failure:^(ApiError *apiError) {
        [self showAlertViewWithTitle:@"Oops!" message:apiError.userMessage];
    }];
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

@end
