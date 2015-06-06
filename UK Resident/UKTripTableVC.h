//
//  UKTripTableVC.h
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header UKTripTableVC.h
	@abstract Declares interface for UKTripTableVC.
	@copyright 2015 Sergey Shvedov
*/

#import "CoreDataTableViewController.h"

/*!
	@abstract The class provides the functionality to present trips in the table view.
*/
@interface UKTripTableVC : CoreDataTableViewController

@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;

@end
