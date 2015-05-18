//
//  Trip+Create.m
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "Trip+Create.h"

@implementation Trip (Create)

+ (Trip *)firstTripInContext:(NSManagedObjectContext *)context
{
	int counter = 1;
	for (int i = -2; i < 5; i++)
	{
		Trip *trip = [NSEntityDescription insertNewObjectForEntityForName:@"Trip" inManagedObjectContext:context];
		trip.startDate = [NSDate dateWithTimeIntervalSinceNow:(i * 24 * 60 * 60)];
		trip.endDate = [NSDate dateWithTimeIntervalSinceNow:((i + 7) * 24 * 60 * 60)];
		trip.destination = [NSString stringWithFormat:@"Поездка №%i", counter];
		counter++;
	}
	return nil;
	
	
//	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Trip"];
//	request.predicate = [NSPredicate predicateWithFormat:@"name = %@", @"User#1"];
//	NSError *error;
//	NSArray *users=  [context executeFetchRequest:request error:&error];
//	
//	if (0 == [users count])
//	{
//		User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
//		user.name = @"User#1";
//		//NSLog(@"Create new user");
//		return user;
//	}
//	else
//	{
//		//NSLog(@"User already exists: %@", ((User *)users[0]).name);
//		return ((Trip *)users[0]);
//	}
}


@end
