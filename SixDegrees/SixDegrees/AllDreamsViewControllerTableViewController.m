//
//  AllDreamsViewControllerTableViewController.m
//  SixDegrees
//
//  Created by Bhalla, Aditya on 5/8/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "AllDreamsViewControllerTableViewController.h"
#import "UserProfileViewController.h"
#import "HelpDreamViewController.h"
#import "SWRevealViewController.h"
#import "DreamCellTableViewCell.h"
#import "ViewControllerFactory.h"
#import "DreamNavigationRouter.h"
#import "SignInViewController.h"
#import "SDConstants.h"

#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"
#import "SDApiManager.h"

#import "DreamManager.h"
#import "UserDream.h"
#import "Dream.h"
#import "User.h"

#define SYSTEM_VERSION                              ([[UIDevice currentDevice] systemVersion])
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([SYSTEM_VERSION compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IS_IOS8_OR_ABOVE                            (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))


@interface AllDreamsViewControllerTableViewController ()

    @property (strong, nonatomic) SDApiManager *apiManager;

    @property (strong, nonatomic) NSArray *dreams;
    @property (nonatomic, strong) DreamCellTableViewCell *prototypeCell;

    @property (strong, nonatomic) ViewControllerFactory *vcFactory;
    @property (strong, nonatomic) DreamManager *dreamManager;
    @property (strong, nonatomic) DreamNavigationRouter *dreamRouter;
    @property (strong, nonatomic) id<BSInjector> injector;

@end

@implementation AllDreamsViewControllerTableViewController

#pragma mark - Blindside

+ (BSPropertySet *)bsProperties {
    BSPropertySet *propertySet = [BSPropertySet propertySetWithClass:self propertyNames:@"vcFactory", @"dreamManager", @"dreamRouter", @"apiManager", nil];
    [propertySet bindProperty:@"vcFactory" toKey:[ViewControllerFactory class]];
    [propertySet bindProperty:@"dreamManager" toKey:[DreamManager class]];
    [propertySet bindProperty:@"dreamRouter" toKey:[DreamNavigationRouter class]];
    [propertySet bindProperty:@"apiManager" toKey:[SDApiManager class]];
    return propertySet;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //show activity spinner
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]
                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    spinner.center=self.view.center;
    [spinner startAnimating];
    [self.view addSubview:spinner];
    
    UIImage *leftIcon = [UIImage imageWithIcon:@"fa-bars" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] andSize:CGSizeMake(25, 25)];
    [_leftBarButton setImage:leftIcon];
    
    UIImage *rightIcon = [UIImage imageWithIcon:@"fa-pencil-square-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] andSize:CGSizeMake(25, 25)];
    [_rightBarButton setImage:rightIcon];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ) {
        [self.leftBarButton setTarget: self.revealViewController];
        [self.leftBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    self.title = @"All Dreams";
    
    [[self.dreamManager fetchDreamsPromise] then:^id(NSArray *dreams) {
        self.dreams = dreams;
        
        // stop activity spinner
        [spinner stopAnimating];
        [spinner removeFromSuperview];
        
        [self.tableView reloadData];
        return dreams;
    } error:^id(NSError *error) {
        return error;
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of rows in the section.
    NSInteger count = [self.dreams count];
    return count;
}

#pragma mark - PrototypeCell
//The prototype cell is never displayed, it is used to layout a cell and determine the required height
- (DreamCellTableViewCell *)prototypeCell
{
    if (!_prototypeCell) {
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DreamCellTableViewCell class])];
    }
    
    return _prototypeCell;
}

#pragma mark - Configure

- (void)configureCell:(DreamCellTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = (int)indexPath.section;
    UserDream *dream = self.dreams[index];
    
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
    }
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", dream.user.firstName, dream.user.lastName];
    cell.descriptionLabel.text = dream.content.dream.dreamDescription;
    [cell.descriptionLabel sizeToFit];
    
    if (dream.content.messages != nil && [dream.content.messages count] > 0) {
        cell.helpLabelHeight.constant = 0.f;
        cell.helpMessageHeight.constant = 0.f;
        NSString *buttonMessage = [NSString stringWithFormat:@"%ld Help Messages", [dream.content.messages count]];
        [cell.helpButton setTitle:buttonMessage forState:UIControlStateNormal];
    } else {
        [cell.helpButton setTitle:@"Help" forState:UIControlStateNormal];
        cell.helpLabel.text = [NSString stringWithFormat:@"Messages below are private between you and %@", dream.user.firstName];
        cell.helpMessage.placeholder = [NSString stringWithFormat:@"How can you help %@?", dream.user.firstName];
    }
    cell.helpButton.tag = index;
    cell.profileView.tag = index;
    
    [cell.helpButton addTarget:self action:@selector(helpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    cell = [self updateTypeIcon:[dream.content.dream dreamTypeEnum] cell:cell];
    
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
    DreamCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DreamPrototypeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (DreamCellTableViewCell *)updateTypeIcon:(DreamType)dreamType cell:(DreamCellTableViewCell *) cell {
    if (dreamType == DreamTypePersonal) {
        cell.typeIcon.image = [UIImage imageNamed:@"heart"];
    } else {
        cell.typeIcon.image = [UIImage imageNamed:@"briefcase"];
    }
    return cell;
}

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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"show_user_profile"]) {
        UINavigationController *navController = segue.destinationViewController;
        UserProfileViewController *userProfileViewController = (UserProfileViewController *)navController.topViewController;
        
        
        UIButton *senderButton = (UIButton *)sender;
        userProfileViewController.allDreams = self.dreams;
        UserDream *selectedDream = [self.dreams objectAtIndex:senderButton.tag];
        userProfileViewController.user = selectedDream.user ;
    }
}

- (IBAction)unwindToAllDreams:(UIStoryboardSegue *)segue {
    
}

-(void)helpButtonClicked:(UIButton*)sender {
    UserDream *dream = self.dreams[sender.tag];
    
    DreamCellTableViewCell *cell = (DreamCellTableViewCell *)[[self tableView] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:sender.tag]];
    
    if (dream.content.messages != nil && [dream.content.messages count] > 0) {
        UINavigationController *navController = (UINavigationController *) [self.storyboard instantiateViewControllerWithIdentifier:@"HelpDreamViewController"];
        
        HelpDreamViewController *destViewController = (HelpDreamViewController *)navController.topViewController;
        
        destViewController.dream = self.dreams[sender.tag];
        
        [self.navigationController pushViewController:destViewController animated:YES];
    } else {
        [self.apiManager helpDream:cell.helpMessage.text
                           dreamId:dream.content.dream.dreamId
                       recipientId:dream.user.userId
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
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

@end
