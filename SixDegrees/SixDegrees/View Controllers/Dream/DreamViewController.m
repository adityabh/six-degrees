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

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *personalDreamLabel;
@property (weak, nonatomic) IBOutlet UILabel *careerDreamLabel;
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
                            [self updateDream:responseObject[0]];
                            NSLog(@"JSON: %@", responseObject);
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

@end
