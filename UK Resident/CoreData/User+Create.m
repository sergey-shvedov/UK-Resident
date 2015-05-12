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
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
	request.predicate = [NSPredicate predicateWithFormat:@"name = %@", @"User#1"];
	NSError *error;
	NSArray *users=  [context executeFetchRequest:request error:&error];
	
	if (0 == [users count])
	{
		User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
		user.name = @"User#1";
		//NSLog(@"Create new user");
		return user;
	}
	else
	{
		//NSLog(@"User already exists: %@", ((User *)users[0]).name);
		return ((User *)users[0]);
	}
}

@end
