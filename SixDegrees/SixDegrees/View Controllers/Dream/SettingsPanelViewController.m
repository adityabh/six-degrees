//
//  SettingsPanelViewController.m
//  SixDegrees
//
//  Created by Bhalla, Aditya on 6/3/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "AllDreamsViewControllerTableViewController.h"
#import "SettingsPanelViewController.h"
#import "Lockbox.h"

@interface SettingsPanelViewController ()

    @property (nonatomic, weak) IBOutlet FBProfilePictureView *profileImageView;
    @property (nonatomic, strong) NSMutableArray *arrayOfSettings;

@end

@implementation SettingsPanelViewController

+ (BSPropertySet *)bsProperties {
    BSPropertySet *propertySet = [BSPropertySet propertySetWithClass:self propertyNames:nil];
    return propertySet;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSettingsArray];
}

- (void)setupSettingsArray {
    NSArray *settings = @[
                         @"How it works",
                         @"Logout",
    ];
    
    self.arrayOfSettings = [NSMutableArray arrayWithArray:settings];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_arrayOfSettings count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsPanelPrototypeCell" forIndexPath:indexPath];
    NSString *setting = [self.arrayOfSettings objectAtIndex:indexPath.row];
    cell.textLabel.text = setting;
    cell.tag = setting;
    return cell;
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    AllDreamsViewControllerTableViewController *allDreamsViewControllerTableVc = [segue destinationViewController];
    allDreamsViewControllerTableVc.segueReason = [self.arrayOfSettings objectAtIndex:indexPath.row];;
}

@end
