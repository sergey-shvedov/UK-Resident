//
//  CoreDataTableViewController.h
//  MultiTest
//
//  Created by Administrator on 29.04.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;

@interface CoreDataTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong,nonatomic) NSFetchedResultsController *fetchedResultsController;
@property BOOL debug;

- (void)performFetch;

@end
