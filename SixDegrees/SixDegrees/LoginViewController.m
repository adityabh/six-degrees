//
//  LoginViewController.m
//  SixDegrees
//
//  Created by Bhalla, Aditya on 5/26/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "LoginViewController.h"

#import "SDApiManager.h"
#import "FacebookManager.h"
#import "FacebookAccount.h"
#import "Lockbox.h"

#import "User.h"

@interface LoginViewController ()

    @property (weak, nonatomic) IBOutlet FBProfilePictureView *profileImageView;
    @property (weak, nonatomic) IBOutlet UILabel *statusLabel;
    @property (weak, nonatomic) IBOutlet UILabel *nameLabel;
    @property (weak, nonatomic) IBOutlet FBSDKLoginButton *facebookSignInButton;

    @property (weak, nonatomic) IBOutlet UITextField *email;
    @property (weak, nonatomic) IBOutlet UITextField *password;

    @property (strong, nonatomic) SDApiManager *apiManager;
    @property (strong, nonatomic) FacebookManager *facebookManager;

@end

@implementation LoginViewController

+ (BSPropertySet *)bsProperties {
    BSPropertySet *propertySet = [BSPropertySet propertySetWithClass:self propertyNames:@"apiManager", @"facebookManager", nil];
    [propertySet bindProperty:@"apiManager" toKey:[SDApiManager class]];
    [propertySet bindProperty:@"facebookManager" toKey:[FacebookManager class]];
    return propertySet;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)facebookSignInTapped:(id)sender {
    [self.facebookManager fetchFbUserWithSuccess:^{
        //self.statusLabel.text = @"SIGNED IN AS";
        //self.nameLabel.text = self.facebookManager.facebookAccount.name;

        [self.apiManager authenticateWithFacebookId:self.facebookManager.facebookAccount.sdFacebookUserId
                                      facebookToken:self.facebookManager.accessToken
                                          userEmail:self.facebookManager.facebookAccount.email
                                            success:^{
                                                [self showAlertViewWithTitle:@"Success!" message:@"Authenticated against Six-Degrees API"];
                                                [self.delegate didLogin];
                                            } failure:^(NSError *error) {
                                                [self showAlertViewWithTitle:@"Failure!" message:error.description];
                                            }];
    } failure:^(ApiError *apiError) {
        [self showAlertViewWithTitle:@"Oops!" message:apiError.userMessage];
    }];
}

- (IBAction)loginTapped:(id)sender {
    //TODO: Add check for not null and red border
    NSString * email = self.email.text;
    NSString * password = self.password.text;
    
    [self.apiManager loginUser:email
                      password:password
                       success:^(User *user) {
                           // store user authentication token securely in keychain
                           BOOL result = [Lockbox setString:user.authenticationToken forKey:AUTHN_TOKEN_KEY];
                           
                           if (result) {
                               [self showAlertViewWithTitle:@"Success!" message:@"Authenticated against Six-Degrees API"];
                               [self.delegate didLogin];
                           } else {
                               [self showAlertViewWithTitle:@"Failure!" message:@"Oops! Something went wrong, please try again"];
                           }
                       } failure:^(NSString *error) {
                           [self showAlertViewWithTitle:@"Failure!" message:error];
                       }];
}


- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}


#pragma mark - Navigation

- (IBAction)unwindToLogin:(UIStoryboardSegue *)segue {
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
