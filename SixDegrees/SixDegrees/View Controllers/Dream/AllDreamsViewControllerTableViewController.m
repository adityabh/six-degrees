//
//  AllDreamsViewControllerTableViewController.m
//  SixDegrees
//
//  Created by Bhalla, Aditya on 5/8/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "AllDreamsViewControllerTableViewController.h"

#import "NSString+FontAwesome.h"
#import "UIImage+FontAwesome.h"

#import "ViewControllerFactory.h"
#import "DreamManager.h"
#import "SignInViewController.h"
#import "DreamNavigationRouter.h"
#import "HelpDreamViewController.h"

#import "UserDream.h"
#import "Dream.h"
#import "User.h"
#import "DreamCellTableViewCell.h"

#define SYSTEM_VERSION                              ([[UIDevice currentDevice] systemVersion])
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([SYSTEM_VERSION compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IS_IOS8_OR_ABOVE                            (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))


@interface AllDreamsViewControllerTableViewController ()

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
    BSPropertySet *propertySet = [BSPropertySet propertySetWithClass:self propertyNames:@"vcFactory", @"dreamManager", @"dreamRouter", nil];
    [propertySet bindProperty:@"vcFactory" toKey:[ViewControllerFactory class]];
    [propertySet bindProperty:@"dreamManager" toKey:[DreamManager class]];
    [propertySet bindProperty:@"dreamRouter" toKey:[DreamNavigationRouter class]];
    return propertySet;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *leftIcon = [UIImage imageWithIcon:@"fa-bars" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] andSize:CGSizeMake(25, 25)];
    [_leftBarButton setImage:leftIcon forState:UIControlStateNormal];
    [_leftBarButton addTarget:self action:@selector(btnMovePanelRight:) forControlEvents:UIControlEventTouchUpInside];
    _leftBarButton.tag = 1;
    
    UIImage *rightIcon = [UIImage imageWithIcon:@"fa-pencil-square-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] andSize:CGSizeMake(25, 25)];
    [_rightBarButton setImage:rightIcon forState:UIControlStateNormal];
    
    [[self.dreamManager fetchDreamsPromise] then:^id(NSArray *dreams) {
        self.dreams = dreams;
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

    cell.profileImageView.profileID = dream.user.uid;
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", dream.user.firstName, dream.user.lastName];
    cell.descriptionLabel.text = dream.content.dreamDescription;
    [cell.descriptionLabel sizeToFit];
    
    cell.helpButton.tag = index;
    [cell.helpButton addTarget:self action:@selector(helpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    cell = [self updateTypeIcon:[dream.content dreamTypeEnum] cell:cell];
    
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
        cell.typeIcon.image = [UIImage imageNamed:@"briefcase"];
    } else {
        cell.typeIcon.image = [UIImage imageNamed:@"heart"];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    
}

-(void)helpButtonClicked:(UIButton*)sender {
    UINavigationController *navController = (UINavigationController *) [self.storyboard instantiateViewControllerWithIdentifier:@"HelpDreamViewController"];
    
    HelpDreamViewController *destViewController = (HelpDreamViewController *)navController.topViewController;
    
    destViewController.dream = self.dreams[sender.tag];
    
    [self.navigationController pushViewController:destViewController animated:YES];
}

- (void)optionSelected:(NSString *)option {
    [_delegate optionSelected:option];
}

#pragma mark -
#pragma mark Button Actions

- (IBAction)btnMovePanelRight:(id)sender {
    UIButton *button = sender;
    switch (button.tag) {
        case 0: {
            [self.delegate movePanelToOriginalPosition];
            break;
        }
            
        case 1: {
            [self.delegate movePanelRight];
            break;
        }
            
        default:
            break;
    }
}

@end
