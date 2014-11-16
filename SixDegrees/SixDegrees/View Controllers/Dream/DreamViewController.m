//
//  DreamViewController.m
//  SixDegrees
//
//  Created by Steven Wu on 2014-11-01.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import "DreamViewController.h"
#import "SDApiManager.h"

@interface DreamViewController ()

@property (weak, nonatomic) IBOutlet FBProfilePictureView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dreamLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeIcon;
@property (strong, nonatomic) NSArray *dreams;
@property (assign) int currentDreamIndex;

@property (strong, nonatomic) SDApiManager *apiManager;

@end

@implementation DreamViewController

+ (BSPropertySet *)bsProperties {
    BSPropertySet *propertySet = [BSPropertySet propertySetWithClass:self propertyNames:@"apiManager", nil];
    [propertySet bindProperty:@"apiManager" toKey:[SDApiManager class]];
    return propertySet;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchDreams];
}

#pragma mark - IBAction

- (void)fetchDreams {
    [self.apiManager fetchDreams:@"Dream"
                        success:^(NSArray *responseObject){
                            self.dreams = responseObject;
                            self.currentDreamIndex = 0;
                            [self updateDreamLabels:self.dreams[self.currentDreamIndex]];
                            [self updateTypeIcon:self.dreams[self.currentDreamIndex][@"content"][@"dream_type"]];
                            NSLog(@"Response: %@", responseObject);
                        } failure:^(NSError *error) {
                            [self showAlertViewWithTitle:@"Failure!" message:error.description];
                        }];
}

- (void)updateDreamLabels:(NSDictionary *)dream {
    self.nameLabel.text = dream[@"user"][@"name"];
    self.dreamLabel.text = dream[@"content"][@"description"];
    self.profileImageView.profileID = dream[@"user"][@"uid"];
}

- (IBAction)nextDream:(id)sender {
    [self incrementCurrentDream];
    NSDictionary *currentDream = self.dreams[self.currentDreamIndex];
    [self updateDreamLabels:currentDream];
    [self updateTypeIcon:currentDream[@"content"][@"dream_type"]];
}

- (void)incrementCurrentDream {
    int numDreams = [self.dreams count] - 1;
    if (self.currentDreamIndex == numDreams) {
        self.currentDreamIndex = 0;
    } else {
        self.currentDreamIndex += 1;
    }
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

@end
