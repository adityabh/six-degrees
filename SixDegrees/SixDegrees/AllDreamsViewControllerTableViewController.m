//
//  AllDreamsViewControllerTableViewController.m
//  SixDegrees
//
//  Created by Bhalla, Aditya on 5/8/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "AllDreamsViewControllerTableViewController.h"

#import "DreamManager.h"
#import "SignInViewController.h"
#import "AuthNavigationRouter.h"

#import "UserDream.h"
#import "Dream.h"
#import "User.h"
#import "DreamCellTableViewCell.h"


@interface AllDreamsViewControllerTableViewController ()

    @property (strong, nonatomic) NSArray *dreams;

    @property (strong, nonatomic) DreamManager *dreamManager;
    @property (strong, nonatomic) AuthNavigationRouter *authNavRouter;
    @property (strong, nonatomic) id<BSInjector> injector;

@end

@implementation AllDreamsViewControllerTableViewController

#pragma mark - Blindside

+ (BSPropertySet *)bsProperties {
    BSPropertySet *propertySet = [BSPropertySet propertySetWithClass:self propertyNames:@"dreamManager", @"authNavRouter", nil];
    [propertySet bindProperty:@"dreamManager" toKey:[DreamManager class]];
    [propertySet bindProperty:@"authNavRouter" toKey:[AuthNavigationRouter class]];
    return propertySet;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DreamCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DreamPrototypeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    int index = (int)indexPath.section;
    UserDream *dream = self.dreams[index];
    
    cell.profileImageView.profileID = dream.user.uid;
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", dream.user.firstName, dream.user.lastName];
    cell.descriptionLabel.text = dream.content.dreamDescription;
    
    cell = [self updateTypeIcon:[dream.content dreamTypeEnum] cell:cell];
    
    [cell.contentView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [cell.contentView.layer setBorderWidth:1.0f];
    cell.contentView.layer.cornerRadius = 5;
    cell.contentView.layer.masksToBounds = YES;
    
    cell.imageView.frame = CGRectOffset(cell.frame, 5, 5);
    
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

- (IBAction)unwindToAllDreams:(UIStoryboardSegue *)segue {
    
}

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
