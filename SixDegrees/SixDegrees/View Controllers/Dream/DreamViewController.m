//
//  DreamViewController.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "DreamViewController.h"
#import "SignInViewController.h"
#import "SDApiManager.h"
#import "DreamManager.h"
#import "AuthNavigationRouter.h"

@interface DreamViewController ()

@property (weak, nonatomic) IBOutlet FBProfilePictureView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dreamLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeIcon;
@property (strong, nonatomic) NSArray *dreams;
@property (assign) int currentDreamIndex;

@property (strong, nonatomic) SDApiManager *apiManager;
@property (strong, nonatomic) DreamManager *dreamManager;
@property (strong, nonatomic) AuthNavigationRouter *authNavRouter;
@property (strong, nonatomic) id<BSInjector> injector;

@end

@implementation DreamViewController

+ (BSPropertySet *)bsProperties {
    BSPropertySet *propertySet = [BSPropertySet propertySetWithClass:self propertyNames:@"apiManager", @"dreamManager", @"authNavRouter", nil];
    [propertySet bindProperty:@"apiManager" toKey:[SDApiManager class]];
    [propertySet bindProperty:@"dreamManager" toKey:[DreamManager class]];
    [propertySet bindProperty:@"authNavRouter" toKey:[AuthNavigationRouter class]];
    return propertySet;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.dreamManager fetchDreamsWithSuccess:^{
        NSDictionary *dream = self.dreamManager.dreams[0];
        [self updateDream:dream];
    } failure:^(NSError *error) {
        [self showAlertViewWithTitle:@"Oops!" message:error.description];
    }];
    
    NSDictionary *dream = self.dreamManager.dreams[0];
    [self updateDream:dream];
}

- (void)updateDreamLabels:(NSDictionary *)dream {
    self.nameLabel.text = dream[@"user"][@"name"];
    self.dreamLabel.text = dream[@"content"][@"description"];
    self.profileImageView.profileID = dream[@"user"][@"uid"];
}

- (void)updateTypeIcon:(NSString *)dreamType {
    if ([dreamType isEqual: @"Professional"]) {
        self.typeIcon.image = [UIImage imageNamed:@"briefcase"];
    } else {
        self.typeIcon.image = [UIImage imageNamed:@"heart"];
    }
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (void)updateDream:(NSDictionary *)dream {
    [self updateDreamLabels:dream];
    [self updateTypeIcon:dream[@"content"][@"dream_type"]];
}

#pragma mark - IBAction

- (IBAction)nextDream:(id)sender {
    NSDictionary *dream = [self.dreamManager nextDream];
    [self updateDream:dream];
    [self showSignInViewController];
}

- (void)showSignInViewController {
//    BlindsidedStoryboard *storyboard = [BlindsidedStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle] injector:self.injector];
//    SignInViewController *signInVc = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SignInViewController class])];
////    [self.navigationController pushViewController:signInVc animated:YES]
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:signInVc];
//    [self presentViewController:nav animated:YES completion:nil];
    
    UINavigationController *nav = [self.authNavRouter defaultAuthNavStack];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
