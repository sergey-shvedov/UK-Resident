//
//  UKTripTableVC.h
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "CoreDataTableViewController.h"

@interface UKTripTableVC : CoreDataTableViewController

@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;

@end
