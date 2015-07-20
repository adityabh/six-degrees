//
//  LoginViewController.m
//  SixDegrees
//
//  Created by Bhalla, Aditya on 5/26/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "LoginViewController.h"

#import "SignupViewController.h"
#import "FacebookAccount.h"
#import "SDApiManager.h"
#import "Lockbox.h"
#import "User.h"

@interface LoginViewController () <FBSDKLoginButtonDelegate>

    @property (weak, nonatomic) IBOutlet UITextField *email;
    @property (weak, nonatomic) IBOutlet UITextField *password;
    @property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

    @property (strong, nonatomic) SDApiManager *apiManager;

@end

@implementation LoginViewController

+ (BSPropertySet *)bsProperties {
    BSPropertySet *propertySet = [BSPropertySet propertySetWithClass:self propertyNames:@"apiManager", nil];
    [propertySet bindProperty:@"apiManager" toKey:[SDApiManager class]];
    return propertySet;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    _loginButton.readPermissions = @[@"public_profile", @"email"];
    _loginButton.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

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
                               [self.delegate didLogin:user];
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

#pragma mark - Facebook login buttons

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 FacebookAccount *facebookAccount = [MTLJSONAdapter modelOfClass:FacebookAccount.class fromJSONDictionary:result error:nil];
                 NSString *provider = [Lockbox stringForKey:SD_PROVIDER_KEY];
                 if ([provider isEqualToString:SD_PROVIDER_FACEBOOK]) {
                     [self loginFacebookUser:facebookAccount.uid];
                 } else {
                     [self signupFacebookUser:facebookAccount];
                 }
             }
         }];
    }
}

- (void) signupFacebookUser:(FacebookAccount *) facebookAccount {
    [self.apiManager signupFacebookUser: facebookAccount.uid
                              firstName: facebookAccount.firstName
                               lastName: facebookAccount.lastName
                                  email: facebookAccount.email
                                   name: facebookAccount.name
                                 gender: facebookAccount.gender
                               timezone: facebookAccount.timezone
                                success:^(User *user) {
                                    // store user authentication token securely in keychain
                                    BOOL result = [Lockbox setString:user.authenticationToken forKey:AUTHN_TOKEN_KEY];
                                    [Lockbox setString:SD_PROVIDER_FACEBOOK forKey:SD_PROVIDER_KEY];
                                    
                                    if (result) {
                                        [self showAlertViewWithTitle:@"Success!" message:@"Authenticated against Six-Degrees API"];
                                        [self.delegate didLogin:user];
                                    } else {
                                        [self showAlertViewWithTitle:@"Failure!" message:@"Oops! Something went wrong, please try again"];
                                    }
                                } failure:^(NSString *error) {
                                    if ([error isEqualToString:DUPLICATE_EMAIL_ERROR]) {
                                        [self loginFacebookUser:facebookAccount.uid];
                                    } else {
                                        [self showAlertViewWithTitle:@"Failure!" message:error];
                                    }
                                }];
    
}

- (void) loginFacebookUser: (NSString *) uid {
    [self.apiManager loginFacebookUser: uid
                                success:^(User *user) {
                                    // store user authentication token securely in keychain
                                    BOOL result = [Lockbox setString:user.authenticationToken forKey:AUTHN_TOKEN_KEY];
                                    [Lockbox setString:SD_PROVIDER_FACEBOOK forKey:SD_PROVIDER_KEY];
                                    
                                    if (result) {
                                        [self.delegate didLogin:user];
                                    } else {
                                        [self showAlertViewWithTitle:@"Oops!" message:@"Something went wrong, please try again"];
                                    }
                                } failure:^(NSString *error) {
                                    if ([error isEqualToString:DUPLICATE_EMAIL_ERROR]) {
                                        
                                    } else {
                                        [self showAlertViewWithTitle:@"Failure!" message:error];
                                    }
                                }];
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    
}

#pragma mark - Navigation

- (IBAction)unwindToLogin:(UIStoryboardSegue *)segue {
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showSignupView"]) {
        UINavigationController *navController = segue.destinationViewController;
        SignupViewController *destViewController = (SignupViewController *)navController.topViewController;
        destViewController.delegate = (id<SignupViewControllerDelegate>)self.delegate;
    }
}

@end
