//
//  SignInViewController.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "SignInViewController.h"
#import "SDApiManager.h"
#import "FacebookManager.h"
#import "FacebookAccount.h"

@interface SignInViewController ()

@property (weak, nonatomic) IBOutlet FBProfilePictureView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *facebookSignInButton;

@property (strong, nonatomic) SDApiManager *apiManager;
@property (strong, nonatomic) FacebookManager *facebookManager;

@end

@implementation SignInViewController

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
                                                [self.delegate didSignIn];
                                            } failure:^(NSError *error) {
                                                [self showAlertViewWithTitle:@"Failure!" message:error.description];
                                            }];
    } failure:^(ApiError *apiError) {
        [self showAlertViewWithTitle:@"Oops!" message:apiError.userMessage];
    }];
}

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
