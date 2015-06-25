//
//  UserProfileViewController.m
//  SixDegrees
//
//  Created by Bhalla, Aditya on 6/24/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "UserProfileViewController.h"
#import "DreamCellTableViewCell.h"

#import "UserDream.h"
#import "Dream.h"
#import "User.h"

#define SYSTEM_VERSION                              ([[UIDevice currentDevice] systemVersion])
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([SYSTEM_VERSION compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IS_IOS8_OR_ABOVE                            (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))

@interface UserProfileViewController ()

@property (nonatomic, weak) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) DreamCellTableViewCell *prototypeCell;

@property (strong, nonatomic) NSArray *dreams;
@property (strong, nonatomic) NSArray *userDreams;
@property (strong, nonatomic) NSArray *helpedDreams;

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.user.firstName, self.user.lastName];
    
    if (self.user.smallAvatar != nil) {
        NSURL *url = [NSURL URLWithString:self.user.smallAvatar];
        NSData  *data = [NSData dataWithContentsOfURL:url];
        self.profileImage.image = [UIImage imageWithData:data];
    } else if ([PROVIDER_FB isEqualToString:self.user.provider]) {
        // TODO : remove hardcoded url here
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=70&height=70",self.user.uid]];
        NSData  *data = [NSData dataWithContentsOfURL:url];
        self.profileImage.image = [UIImage imageWithData:data];
    } else {
        self.profileImage.image = [UIImage imageNamed:@"no_profile"];
    }
    
    // predicates for filtering
    NSPredicate *userDreamsPredicate = [NSPredicate predicateWithFormat:@"self.user.userId ==[c] %@", self.user.userId];
    _userDreams = [self.allDreams filteredArrayUsingPredicate:userDreamsPredicate];
    
    _dreams = _userDreams;
    
    //disable dreams button
    [self.showDreams setEnabled:NO];
    [self.showDreams setBackgroundColor:[UIColor lightGrayColor]];
    
    // add actions to button clicks
    [self.showDreams addTarget:self action:@selector(showUserDreams:) forControlEvents:UIControlEventTouchUpInside];
    [self.showHelpGiven addTarget:self action:@selector(showHelpedDreams:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.myTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button actions

- (void)showUserDreams:(UIButton*)sender {
    self.dreams = self.userDreams;
    
    //disable dreams button
    [self.showDreams setEnabled:NO];
    [self.showDreams setBackgroundColor:[UIColor lightGrayColor]];
    
    //enable showHelpGiven button
    [self.showHelpGiven setEnabled:YES];
    [self.showHelpGiven setBackgroundColor:UIColorFromRGB(0x53B2DA)];

    [self.myTableView reloadData];
}

- (void)showHelpedDreams:(UIButton*)sender {
    // TODO: change to helpedDreams after new API
    self.dreams = self.allDreams;
    
    //disable showHelpGiven button
    [self.showHelpGiven setEnabled:NO];
    [self.showHelpGiven setBackgroundColor:[UIColor lightGrayColor]];
    
    //enable dreams button
    [self.showDreams setEnabled:YES];
    [self.showDreams setBackgroundColor:UIColorFromRGB(0x53B2DA)];
    
    [self.myTableView reloadData];
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
        _prototypeCell = [self.myTableView dequeueReusableCellWithIdentifier:NSStringFromClass([DreamCellTableViewCell class])];
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
    cell.descriptionLabel.text = dream.content.dreamDescription;
    [cell.descriptionLabel sizeToFit];
    
    cell.helpButton.tag = index;
    //[cell.helpButton addTarget:self action:@selector(helpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
