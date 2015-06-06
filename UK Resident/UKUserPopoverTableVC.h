//
//  UKUserPopoverTableVC.h
//  UK Resident
//
//  Created by Sergey Shvedov on 20.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header UKUserPopoverTableVC.h
	@abstract Declares interface for UKUserPopoverTableVC.
	@copyright 2015 Sergey Shvedov
*/

#import "CoreDataTableViewController.h"

/*!
	@abstract The class provides the functionality to present a user popover.
*/
@interface UKUserPopoverTableVC : CoreDataTableViewController

@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;

@end
