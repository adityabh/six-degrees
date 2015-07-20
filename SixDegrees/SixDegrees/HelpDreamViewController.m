//
//  HelpDreamViewController.m
//  SixDegrees
//
//  Created by Bhalla, Aditya on 5/26/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "HelpDreamViewController.h"
#import "HelpCellTableViewCell.h"
#import "SDApiManager.h"

#import "UserDream.h"
#import "Message.h"
#import "User.h"

#import "UIImage+FontAwesome.h"

#define SYSTEM_VERSION                              ([[UIDevice currentDevice] systemVersion])
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([SYSTEM_VERSION compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IS_IOS8_OR_ABOVE                            (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))


@interface HelpDreamViewController ()

    @property (strong, nonatomic) SDApiManager *apiManager;

    @property (nonatomic, weak) IBOutlet UITableView *myTableView;
    @property (nonatomic, strong) HelpCellTableViewCell *prototypeCell;

    @property (nonatomic, strong) User *user;

@end

@implementation HelpDreamViewController

#pragma mark - Blindside

+ (BSPropertySet *)bsProperties {
    BSPropertySet *propertySet = [BSPropertySet propertySetWithClass:self propertyNames:@"apiManager", nil];
    [propertySet bindProperty:@"apiManager" toKey:[SDApiManager class]];
    return propertySet;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // configure bar button items
    UIImage *leftIcon = [UIImage imageWithIcon:@"fa-chevron-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] andSize:CGSizeMake(25, 25)];
    [_leftBarButton setImage:leftIcon];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.dream.user.firstName, self.dream.user.lastName];

    if (self.dream.user.smallAvatar != nil) {
        NSURL *url = [NSURL URLWithString:self.dream.user.smallAvatar];
        NSData  *data = [NSData dataWithContentsOfURL:url];
        self.profileImageView.image = [UIImage imageWithData:data];
    } else if ([PROVIDER_FB isEqualToString:self.dream.user.provider]) {
        // TODO : remove hardcoded url here
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=square",self.dream.user.uid]];
        NSData  *data = [NSData dataWithContentsOfURL:url];
        self.profileImageView.image = [UIImage imageWithData:data];
    } else {
        self.profileImageView.image = [UIImage imageNamed:@"no_profile"];
    }
    
    self.descriptionLabel.text = self.dream.content.dream.dreamDescription;
    [self.descriptionLabel sizeToFit];
    
    if (self.dream.content.dream.dreamType == DreamTypePersonal) {
        self.typeIcon.image = [UIImage imageNamed:@"heart"];
    } else {
        self.typeIcon.image = [UIImage imageNamed:@"briefcase"];
    }
    
    [self.helpButton addTarget:self action:@selector(helpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.myTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of rows in the section.
    NSInteger count = [self.dream.content.messages count];
    return count;
}

#pragma mark - PrototypeCell
//The prototype cell is never displayed, it is used to layout a cell and determine the required height
- (HelpCellTableViewCell *)prototypeCell {
    if (!_prototypeCell) {
        _prototypeCell = [self.myTableView dequeueReusableCellWithIdentifier:NSStringFromClass([HelpCellTableViewCell class])];
    }
    
    return _prototypeCell;
}

#pragma mark - Configure

- (void)configureCell:(HelpCellTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    int index = (int)indexPath.section;
    Message *message = self.dream.content.messages[index];
    
    /*
    if (dream.user.smallAvatar != nil) {
        NSURL *url = [NSURL URLWithString:dream.user.smallAvatar];
        NSData  *data = [NSData dataWithContentsOfURL:url];
        cell.profileImageView.image = [UIImage imageWithData:data];
    } else if ([PROVIDER_FB isEqualToString:dream.user.provider]) {
        // TODO : remove hardcoded url here
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=square",dream.user.uid]];
        NSData  *data = [NSData dataWithContentsOfURL:url];
        cell.profileImageView.image = [UIImage imageWithData:data];
    } else {
        cell.profileImageView.image = [UIImage imageNamed:@"no_profile"];
    } */
    
    cell.profileImage.image = [UIImage imageNamed:@"no_profile"];
    cell.profileName.text = [NSString stringWithFormat:@"%@", message.userId];
    cell.message.text = message.content;
    [cell.message sizeToFit];
    
    [cell.contentView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [cell.contentView.layer setBorderWidth:1.0f];
    cell.contentView.layer.cornerRadius = 5;
    cell.contentView.layer.masksToBounds = YES;
    
    cell.imageView.frame = CGRectOffset(cell.frame, 5, 5);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HelpCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HelpCellTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

/*
- (DreamCellTableViewCell *)updateTypeIcon:(DreamType)dreamType cell:(DreamCellTableViewCell *) cell {
    if (dreamType == DreamTypePersonal) {
        cell.typeIcon.image = [UIImage imageNamed:@"briefcase"];
    } else {
        cell.typeIcon.image = [UIImage imageNamed:@"heart"];
    }
    return cell;
} */

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //iOS 8 Auto sizing cell feature needs UITableViewAutomaticDimension
    if (IS_IOS8_OR_ABOVE) {
        return UITableViewAutomaticDimension;
    }
    
    //If there are some reasons that you make changes to some constraint (for example, make the quote label bottom constraint to 5), you need to call [self.contentView updateConstraintsIfNeeded]
    [self configureCell:self.prototypeCell forRowAtIndexPath:indexPath];
    
    // You must call it on the contentView
    [self.prototypeCell updateConstraintsIfNeeded];
    [self.prototypeCell layoutIfNeeded];
    
    return [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

-(void)helpButtonClicked:(UIButton*)sender {
    [self.apiManager helpDream:self.helpMessage.text
                       dreamId:self.dream.content.dream.dreamId
                    recipientId:self.dream.user.userId
                        success:^(NSString *status) {
                            long statusValue = [status longLongValue];
                            if (statusValue == 200l) {
                                [self showAlertViewWithTitle:@"Success!" message:@"Message successfully sent!"];
                            } else {
                                [self showAlertViewWithTitle:@"Oops!" message:@"Something went wrong, please try again"];
                            }
                        } failure:^(NSString *error) {
                            [self showAlertViewWithTitle:@"Oops!" message:@"Something   went wrong, please try again"];
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
