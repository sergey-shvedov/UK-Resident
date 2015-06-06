//
//  Trip+Create.h
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header Trip+Create.h
	@abstract Declares interface for Trip+Create.
	@copyright 2015 Sergey Shvedov
*/

#import "Trip.h"

/*!
	@abstract The category provides the functionality to edit a Trip element.
*/
@interface Trip (Create)

+ (Trip *)firstTripInContext:(NSManagedObjectContext *)context;

@end
