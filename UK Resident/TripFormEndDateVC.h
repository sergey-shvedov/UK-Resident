//
//  TripFormEndDateVC.h
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header TripFormEndDateVC.h
	@abstract Declares interface for TripFormEndDateVC.
	@copyright 2015 Sergey Shvedov
*/

#import <UIKit/UIKit.h>
#import "TempTrip.h"

/*!
	@abstract The class provides the functionality to present required data.
*/
@interface TripFormEndDateVC : UIViewController

@property (nonatomic, strong) TempTrip *editingTrip;

@end
