//
//  CreateDreamViewController.m
//  SixDegrees
//
//  Created by Bhalla, Aditya on 5/14/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "CreateDreamViewController.h"
#import "RadioButton.h"
#import "SDApiManager.h"
#import "DreamResponse.h"

@interface CreateDreamViewController ()

@property (strong, nonatomic) SDApiManager *apiManager;

@property (strong, nonatomic) IBOutlet RadioButton *dreamTypePersonal;
@property (strong, nonatomic) IBOutlet RadioButton *dreamTypeProfessional;


@property (weak, nonatomic) IBOutlet UITextField *dreamDescription;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property DreamResponse *dreamResponse;

@end

@implementation CreateDreamViewController

+ (BSPropertySet *)bsProperties {
    BSPropertySet *propertySet = [BSPropertySet propertySetWithClass:self propertyNames:@"apiManager", nil];
    [propertySet bindProperty:@"apiManager" toKey:[SDApiManager class]];
    return propertySet;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dreamTypePersonal.groupButtons = @[_dreamTypePersonal,_dreamTypeProfessional];
    _dreamTypePersonal.selected = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if (sender != self.saveButton) return YES;
    
    if (self.dreamDescription.text.length == 0) {
        return NO;
    }
    return YES;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender != self.saveButton) return;
    
    RadioButton *selectedButton = [self.dreamTypePersonal selectedButton];
    NSString *dreamType = [selectedButton.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (self.dreamDescription.text.length > 0) {
        
        [[self.apiManager createDreamForUser:@"56" dreamType:dreamType dreamDescription:self.dreamDescription.text] then:^id(DreamResponse *dreamResponse)
        {
            self.dreamResponse = dreamResponse;
            return dreamResponse;
        } error:^id(NSError *error) {
            return error;
        }];
    }
}

@end
