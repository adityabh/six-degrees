//
//  EditUserViewController.m
//  SixDegrees
//
//  Created by Bhalla, Aditya on 6/25/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "EditUserViewController.h"

#import "SWRevealViewController.h"
#import "UIImage+FontAwesome.h"
#import "SDApiManager.h"
#import "AppDelegate.h"

@interface EditUserViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UISwitch *enableEmails;

@property (weak, nonatomic) IBOutlet UILabel *errorMessage;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;

@property (strong, nonatomic) SDApiManager *apiManager;
@property (nonatomic, strong) User *user;

@end

@implementation EditUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //assign user
    AppDelegate *appDel = (AppDelegate*) [UIApplication sharedApplication].delegate;
    _user = appDel.user;
    
    // init fields
    self.firstName.text = _user.firstName;
    self.lastName.text = _user.lastName;
    self.email.text = _user.email;
    
    if (_user.smallAvatar != nil) {
        NSURL *url = [NSURL URLWithString:appDel.user.largeAvatar];
        NSData  *data = [NSData dataWithContentsOfURL:url];
        self.profileImage.image = [UIImage imageWithData:data];
    } else if ([PROVIDER_FB isEqualToString:_user.provider]) {
        // TODO : remove hardcoded url here
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",_user.uid]];
        NSData  *data = [NSData dataWithContentsOfURL:url];
        self.profileImage.image = [UIImage imageWithData:data];
    } else {
        self.profileImage.image = [UIImage imageNamed:@"no_profile"];
    }
    
    // configure bar button items
    UIImage *leftIcon = [UIImage imageWithIcon:@"fa-chevron-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] andSize:CGSizeMake(25, 25)];
    [_leftBarButton setImage:leftIcon];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (BSPropertySet *)bsProperties {
    BSPropertySet *propertySet = [BSPropertySet propertySetWithClass:self propertyNames:@"apiManager", nil];
    [propertySet bindProperty:@"apiManager" toKey:[SDApiManager class]];
    return propertySet;
}

#pragma mark - Navigation

- (BOOL)shouldUpdateUser {
    self.errorMessage.textColor = [UIColor redColor];
    self.errorMessage.hidden = YES;
    self.errorMessage.frame = CGRectMake(
                                         self.errorMessage.frame.origin.x,
                                         self.errorMessage.frame.origin.y,
                                         self.errorMessage.frame.size.width,
                                         0
                                         );
    
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
    
    if (returnValue == NO) {
        self.errorMessage.textColor = [UIColor redColor];
        self.errorMessage.hidden = NO;
        self.errorMessage.frame = CGRectMake(
                self.errorMessage.frame.origin.x,
                self.errorMessage.frame.origin.y,
                self.errorMessage.frame.size.width,
                21
        );
    }
    return returnValue;
}

-(void)showMissingTextInput:(UITextField *) field {
    field.layer.cornerRadius=8.0f;
    field.layer.masksToBounds=YES;
    field.layer.borderColor=[[UIColor redColor]CGColor];
    field.layer.borderWidth= 1.0f;
}

- (IBAction)updateUser:(id)sender {
    if(sender == self.updateButton) {
        if ([self shouldUpdateUser]) {
            //TODO: add API to actualy update and get user
            [self.delegate didUpdateUser:nil];
        }
    } else {
        [self.delegate didCancelUpdate];
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
