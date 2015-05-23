//
//  UserWithTrip+DeleteRules.m
//  UK Resident
//
//  Created by Sergey Shvedov on 14.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UserWithTrip+DeleteRules.h"
#import "Trip.h"
#import "AttachPhoto.h"
#import "NSString+UKResident.h"


@implementation UserWithTrip (DeleteRules)

- (void)prepareForDeletion
{
	Trip *trip = self.inTrip;
	if (1 == [trip.tripsByUser count])
	{
		for (AttachPhoto *attachPhoto in trip.attachedPhotos)
		{
			NSError *error;
			[[NSFileManager defaultManager] removeItemAtPath:[attachPhoto.storePath pathToDocumentDirectory] error:&error];
		}
		[self.managedObjectContext deleteObject:trip];
	}
}


@end
