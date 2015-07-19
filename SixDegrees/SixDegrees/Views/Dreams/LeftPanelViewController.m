//
//  LeftPanelViewController.m
//  SlideoutNavigation
//
//  Created by Tammy Coron on 1/10/13.
//  Copyright (c) 2013 Tammy L Coron. All rights reserved.
//

#import "LeftPanelViewController.h"
#import "UIImage+FontAwesome.h"
#import "AppDelegate.h"


@interface LeftPanelViewController ()

@property (nonatomic, weak) IBOutlet UITableView *myTableView;
@property (nonatomic, weak) IBOutlet UITableViewCell *cellMain;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (nonatomic, weak) IBOutlet UILabel *profileName;

@property (nonatomic, strong) NSArray *arrayOfSettings;
@property (nonatomic, strong) NSDictionary *settingsToIconMapping;

@end

@implementation LeftPanelViewController

#pragma mark -
#pragma mark View Did Load/Unload

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupOptionsArray];
    
    AppDelegate *appDel = (AppDelegate*) [UIApplication sharedApplication].delegate;
    if (appDel.user.smallAvatar != nil) {
        NSURL *url = [NSURL URLWithString:appDel.user.smallAvatar];
        NSData  *data = [NSData dataWithContentsOfURL:url];
        self.profileImage.image = [UIImage imageWithData:data];
    } else if ([PROVIDER_FB isEqualToString:appDel.user.provider]) {
        // TODO : remove hardcoded url here
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",appDel.user.uid]];
        NSData  *data = [NSData dataWithContentsOfURL:url];
        self.profileImage.image = [UIImage imageWithData:data];
    } else {
        self.profileImage.image = [UIImage imageNamed:@"no_profile"];
    }
    
    self.profileName.text = [NSString stringWithFormat:@"%@ %@", appDel.user.firstName, appDel.user.lastName];
    
    // This will remove extra separators from tableview
    self.myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark -
#pragma mark View Will/Did Appear

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

#pragma mark -
#pragma mark View Will/Did Disappear

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark Array Setup

- (void)setupOptionsArray {
    self.arrayOfSettings = @[@"Logout", @"How it works", @"Settings"];
    
    self.settingsToIconMapping = @{
      @"Logout" : @"fa-sign-out",
      @"How it works" : @"fa-info-circle",
      @"Settings" : @"fa-cog"
      };
    
    [self.myTableView reloadData];
}

#pragma mark -
#pragma mark UITableView Datasource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_arrayOfSettings count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellMainNibID = @"cellMain";
    
    _cellMain = [tableView dequeueReusableCellWithIdentifier:cellMainNibID];
    if (_cellMain == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"MainCellLeft" owner:self options:nil];
    }
    
    UIImageView *optionImage = (UIImageView *)[_cellMain viewWithTag:1];
    
    UILabel *optionTitle = (UILabel *)[_cellMain viewWithTag:2];
    
    if ([_arrayOfSettings count] > 0) {
        NSString *currentRecord = [self.arrayOfSettings objectAtIndex:indexPath.row];
        optionTitle.text = currentRecord;
        
        NSString *iconName = [self.settingsToIconMapping objectForKey:currentRecord];
        
        optionImage.image = [UIImage imageWithIcon:iconName backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] andSize:CGSizeMake(25, 25)];
    }
    
    return _cellMain;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *currentRecord = [self.arrayOfSettings objectAtIndex:indexPath.row];
    [self.delegate optionSelected:currentRecord];
}

#pragma mark -
#pragma mark Default System Code

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
