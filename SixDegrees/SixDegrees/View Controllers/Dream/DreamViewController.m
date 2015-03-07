//
//  DreamViewController.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "DreamViewController.h"
#import "SignInViewController.h"
#import "AuthNavigationRouter.h"

#import "DreamManager.h"

#import "UserDream.h"
#import "Dream.h"
#import "User.h"

@interface DreamViewController ()

@property (weak, nonatomic) IBOutlet FBProfilePictureView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dreamLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeIcon;
@property (assign) int currentDreamIndex;

@property (strong, nonatomic) DreamManager *dreamManager;
@property (strong, nonatomic) AuthNavigationRouter *authNavRouter;
@property (strong, nonatomic) id<BSInjector> injector;

@end

@implementation DreamViewController

+ (BSPropertySet *)bsProperties {
    BSPropertySet *propertySet = [BSPropertySet propertySetWithClass:self propertyNames:@"dreamManager", @"authNavRouter", nil];
    [propertySet bindProperty:@"dreamManager" toKey:[DreamManager class]];
    [propertySet bindProperty:@"authNavRouter" toKey:[AuthNavigationRouter class]];
    return propertySet;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self.dreamManager fetchDreamsPromise] then:^id(NSArray *dreams) {
        [self updateWithUserDream:dreams[0]];
        return dreams;
    } error:^id(NSError *error) {
        [self showAlertViewWithTitle:@"Oops!" message:error.description];
        return error;
    }];
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (void)updateWithUserDream:(UserDream *)userDream {
    self.nameLabel.text = userDream.user.name;
    self.dreamLabel.text = userDream.content.dreamDescription;
    self.profileImageView.profileID = userDream.user.uid;
    [self updateTypeIcon:userDream.content.dreamType];
}

- (void)updateTypeIcon:(NSString *)dreamType {
    if ([dreamType isEqual: @"Professional"]) {
        self.typeIcon.image = [UIImage imageNamed:@"briefcase"];
    } else {
        self.typeIcon.image = [UIImage imageNamed:@"heart"];
    }
}

#pragma mark - IBAction

- (IBAction)nextDream:(id)sender {
//    NSDictionary *dream = [self.dreamManager nextDream];
//    [self updateWithUserDream:dream];
//    [self showSignInViewController];
}

- (void)showSignInViewController {
//    BlindsidedStoryboard *storyboard = [BlindsidedStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle] injector:self.injector];
//    SignInViewController *signInVc = [sto ryboard instantiateViewControllerWithIdentifier:NSStringFromClass([SignInViewController class])];
////    [self.navigationController pushViewController:signInVc animated:YES]
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:signInVc];
//    [self presentViewController:nav animated:YES completion:nil];
    
    UINavigationController *nav = [self.authNavRouter defaultAuthNavStack];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
