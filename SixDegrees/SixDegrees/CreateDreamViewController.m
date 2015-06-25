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
#import "Lockbox.h"

#import "UIImage+FontAwesome.h"

@interface CreateDreamViewController ()

@property (strong, nonatomic) SDApiManager *apiManager;

@property (strong, nonatomic) IBOutlet RadioButton *dreamTypePersonal;
@property (strong, nonatomic) IBOutlet RadioButton *dreamTypeProfessional;


@property (weak, nonatomic) IBOutlet UITextField *dreamDescription;
@property (weak, nonatomic) IBOutlet UILabel *errorMessage;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

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
    
    // configure bar button items
    UIImage *leftIcon = [UIImage imageWithIcon:@"fa-chevron-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] andSize:CGSizeMake(25, 25)];
    [_leftBarButton setImage:leftIcon];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if (sender != self.saveButton) return YES;
    
    self.errorMessage.textColor = [UIColor redColor];
    self.errorMessage.hidden = YES;
    self.dreamDescription.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    
    if (self.dreamDescription.text.length == 0) {
        [self showMissingTextInput:self.dreamDescription];
        self.errorMessage.hidden = NO;
        return NO;
    }
    return YES;
}

-(void)showMissingTextInput:(UITextField *) field {
    field.layer.cornerRadius=8.0f;
    field.layer.masksToBounds=YES;
    field.layer.borderColor=[[UIColor redColor]CGColor];
    field.layer.borderWidth= 1.0f;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender != self.saveButton) return;
    
    RadioButton *selectedButton = [self.dreamTypePersonal selectedButton];
    NSString *dreamType = [selectedButton.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (self.dreamDescription.text.length > 0) {
        NSString *authNToken = [Lockbox stringForKey:AUTHN_TOKEN_KEY];
        
        [[self.apiManager createDreamForUser:authNToken dreamType:dreamType dreamDescription:self.dreamDescription.text] then:^id(DreamResponse *dreamResponse)
        {
            self.dreamResponse = dreamResponse;
            return dreamResponse;
        } error:^id(NSError *error) {
            return error;
        }];
    }
}

@end
