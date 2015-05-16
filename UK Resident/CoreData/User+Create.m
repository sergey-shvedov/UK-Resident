//
//  User+Create.m
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "User+Create.h"
#import "UKLibraryAPI.h"

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

+ (User *)userWithID:(NSUInteger)anUserID inContext:(NSManagedObjectContext *)aContext
{
	User *result = nil;
	
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
	request.predicate = [NSPredicate predicateWithFormat:@"userID = %@", anUserID];
	NSError *error;
	NSArray *users = [aContext executeFetchRequest:request error:&error];
	
	if ([users count])
	{
		result = ((User *)[users firstObject]);
	}
	else
	{
		NSFetchRequest *request2 = [NSFetchRequest fetchRequestWithEntityName:@"User"];
		request2.predicate = [NSPredicate predicateWithFormat:@"userID = %@", anUserID];
		request2.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"userID" ascending:YES]];
		NSError *error2;
		NSArray *users2 = [aContext executeFetchRequest:request error:&error2];
		if ([users2 count])
		{
			result = ((User *)[users2 firstObject]);
		}
		else
		{
			result = [User firstUserInContext:aContext];
		}
	}
	
	return result;
}

+ (void)deleteUser:(User *)anUser inContext:(NSManagedObjectContext *)aContext
{
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	if (YES == [library.currentUser isEqual:anUser])
	{
		library.currentUser = nil;
	}
	[aContext deleteObject:anUser];
	[library saveContext];
}

@end
