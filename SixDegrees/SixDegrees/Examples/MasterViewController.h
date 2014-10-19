//
//  MasterViewController.h
//  SixDegrees
//
//  Created by Steven Wu on 2014-10-17.
//  Copyright (c) 2014 Steven Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

