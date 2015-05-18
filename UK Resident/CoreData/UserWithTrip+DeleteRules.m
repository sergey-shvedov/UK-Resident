//
//  UserWithTrip+DeleteRules.m
//  UK Resident
//
//  Created by Sergey Shvedov on 14.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UserWithTrip+DeleteRules.h"
#import "Trip.h"


@implementation UserWithTrip (DeleteRules)

- (void)prepareForDeletion
{
	Trip *trip = self.inTrip;
	if (1 == [trip.tripsByUser count])
	{
		[self.managedObjectContext deleteObject:trip];
	}
}


@end
