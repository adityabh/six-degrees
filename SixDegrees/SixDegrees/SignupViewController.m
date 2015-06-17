//
//  SignupViewController.m
//  SixDegrees
//
//  Created by Bhalla, Aditya on 5/31/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "SignupViewController.h"
#import "SDApiManager.h"
#import "User.h"
#import "Lockbox.h"

@interface SignupViewController ()

    @property (weak, nonatomic) IBOutlet UITextField *firstName;
    @property (weak, nonatomic) IBOutlet UITextField *lastName;
    @property (weak, nonatomic) IBOutlet UITextField *email;
    @property (weak, nonatomic) IBOutlet UITextField *password;

    @property (weak, nonatomic) IBOutlet UILabel *errorMessage;

    @property (strong, nonatomic) SDApiManager *apiManager;

@end

@implementation SignupViewController

+ (BSPropertySet *)bsProperties {
    BSPropertySet *propertySet = [BSPropertySet propertySetWithClass:self propertyNames:@"apiManager", nil];
    [propertySet bindProperty:@"apiManager" toKey:[SDApiManager class]];
    return propertySet;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signupTapped:(id)sender {
    [self resetInputs];
    
    if (![self validateInput]) {
        self.errorMessage.textColor = [UIColor redColor];
        self.errorMessage.hidden = NO;
        return;
    }
    
    NSString *firstName = self.firstName.text;
    NSString *lastName = self.lastName.text;
    NSString * email = self.email.text;
    NSString * password = self.password.text;
    
    [self.apiManager signupUser:firstName
                       lastName:lastName
                          email:email
                      password:password
                       success:^(User *user) {
                           // store user authentication token securely in keychain
                           [Lockbox setString:user.authenticationToken forKey:AUTHN_TOKEN_KEY];
                           
                           [self showAlertViewWithTitle:@"Success!" message:@"Authenticated against Six-Degrees API"];
                           [self.delegate didSignup:user];
                       } failure:^(NSError *error) {
                           [self showAlertViewWithTitle:@"Failure!" message:error.description];
                       }];
}

- (BOOL)validateInput {
    BOOL returnValue = YES;
    if ([self.firstName.text length] == 0) {
        [self showMissingTextInput:self.firstName];
        returnValue = NO;
    }
    if ([self.lastName.text length] == 0) {
        [self showMissingTextInput:self.lastName];
        returnValue = NO;
    }
    if ([self.email.text length] == 0) {
        [self showMissingTextInput:self.email];
        returnValue = NO;
    }
    if ([self.password.text length] == 0) {
        [self showMissingTextInput:self.password];
        returnValue = NO;
    }
    return returnValue;
}

-(void)showMissingTextInput:(UITextField *) field {
    field.layer.cornerRadius=8.0f;
    field.layer.masksToBounds=YES;
    field.layer.borderColor=[[UIColor redColor]CGColor];
    field.layer.borderWidth= 1.0f;
}

-(void)resetInputs {
    self.errorMessage.hidden = YES;
    self.firstName.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    self.lastName.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    self.email.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    self.password.layer.borderColor=[[UIColor lightGrayColor]CGColor];
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
