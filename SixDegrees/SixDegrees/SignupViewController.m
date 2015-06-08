//
//  SignupViewController.m
//  SixDegrees
//
//  Created by Bhalla, Aditya on 5/31/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "SignupViewController.h"
#import "SDApiManager.h"

@interface SignupViewController ()

    @property (weak, nonatomic) IBOutlet UITextField *firstName;
    @property (weak, nonatomic) IBOutlet UITextField *lastName;
    @property (weak, nonatomic) IBOutlet UITextField *email;
    @property (weak, nonatomic) IBOutlet UITextField *password;

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
    //TODO: add input validation
    NSString *firstName = self.firstName.text;
    NSString *lastName = self.lastName.text;
    NSString * email = self.email.text;
    NSString * password = self.password.text;
    
    [self.apiManager signupUser:firstName
                       lastName:lastName
                          email:email
                      password:password
                       success:^{
                           [self showAlertViewWithTitle:@"Success!" message:@"Authenticated against Six-Degrees API"];
                           [self.delegate didSignup];
                       } failure:^(NSError *error) {
                           [self showAlertViewWithTitle:@"Failure!" message:error.description];
                       }];
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
