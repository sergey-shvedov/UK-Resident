//
//  User+Create.m
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "User+Create.h"

@implementation User (Create)

+ (User *)firstUserInContext:(NSManagedObjectContext *)context
{
	User *result = nil;
	
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
	request.predicate = [NSPredicate predicateWithFormat:@"userID = %@", @0];
	NSError *error;
	NSArray *users = [context executeFetchRequest:request error:&error];
	
	
	if (0 == [users count])
	{
		User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
		user.name = @"User 1";
		user.userID = @0;
		user.colorID = @0;
		result = user;
	}
	else
	{
		result = ((User *)[users firstObject]);
	}
	
	return result;
}

@end
