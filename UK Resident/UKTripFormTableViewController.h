//
//  UKTripFormTableViewController.h
//  UK Resident
//
//  Created by Sergey Shvedov on 02.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header UKTripFormTableViewController.h
	@abstract Declares interface for UKTripFormTableViewController.
	@copyright 2015 Sergey Shvedov
*/

#import <UIKit/UIKit.h>
#import "Trip.h"
#import "TempTrip.h"

@protocol UKTripFormTVCDelegate <NSObject>

- (void)appearButtons;
- (void)dismissButtons;
- (void)changeNeedEditStatusTo:(BOOL)isNeedEdit;

@end

/*!
	@abstract The class provides the functionality to operate with table elements of a trip card.
*/
@interface UKTripFormTableViewController : UITableViewController

@property (nonatomic, weak) id<UKTripFormTVCDelegate> delegate;

@property (strong,nonatomic) Trip *trip;
@property (strong,nonatomic) TempTrip *editingTrip;
@property (strong,nonatomic) NSManagedObjectContext *managedObjectContect;
@property BOOL isCreating;

@end
