//
//  UKTripAddFormViewController.h
//  UK Resident
//
//  Created by Sergey Shvedov on 02.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header UKTripAddFormViewController.h
	@abstract Declares interface for UKTripAddFormViewController.
	@copyright 2015 Sergey Shvedov
*/

#import <UIKit/UIKit.h>
#import "FormButton.h"
#import "Trip.h"
#import "TempTrip.h"

/*!
	@abstract The class provides the functionality to present a trip card.
*/
@interface UKTripAddFormViewController : UIViewController

@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (strong,nonatomic) User *userEditingTrip;
@property (strong,nonatomic) Trip *trip;
@property (strong,nonatomic) TempTrip *editingTrip;

@property BOOL isCreating;
@property (strong,nonatomic) FormButton *buttonOk;
@property (strong,nonatomic) FormButton *buttonCancel;

@end
