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
		user.name = @"Traveler";
		user.userID = @0;
		user.colorID = @0;
		[[UKLibraryAPI sharedInstance] saveContext];
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
	request.predicate = [NSPredicate predicateWithFormat:@"userID = %@", [NSNumber numberWithInteger:anUserID]];
	NSError *error;
	NSArray *users = [aContext executeFetchRequest:request error:&error];
	
	if ([users count])
	{
		result = ((User *)[users firstObject]);
	}
	else
	{
		NSFetchRequest *request2 = [NSFetchRequest fetchRequestWithEntityName:@"User"];
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

+ (User *)createNextUserinContext:(NSManagedObjectContext *)aContext
{
	User *result = nil;
	NSInteger userID = 0;
	
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
	request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"userID" ascending:YES]];
	NSError *error;
	NSArray *users = [aContext executeFetchRequest:request error:&error];
	
	if ([users count])
	{
		userID = [((User *)[users lastObject]).userID integerValue] + 1;
	}
	
	User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:aContext];
	user.name = @"Traveler";
	user.userID = [NSNumber numberWithInteger:userID];;
	user.colorID = @0;
	[[UKLibraryAPI sharedInstance] saveContext];
	result = user;
	[[UKLibraryAPI sharedInstance] logAllData];
	
	return result;
}

+ (void)deleteUser:(User *)anUser inContext:(NSManagedObjectContext *)aContext
{
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	[library logAllData];
	BOOL needUpdate = NO;
	NSInteger previusID = 0;
	if (YES == [library.currentUser isEqual:anUser])
	{
		previusID = [anUser.userID integerValue] - 1;
		if (previusID < 0) previusID = 0;
		library.currentUser = nil;
		needUpdate = YES;
	}
	
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
	request.predicate = [NSPredicate predicateWithFormat:@"userID > %@", anUser.userID];
	NSError *error;
	NSArray *users = [aContext executeFetchRequest:request error:&error];
	
	for (User *user in users)
	{
		user.userID = [NSNumber numberWithInteger:([user.userID integerValue] - 1)];
	}
	
	[aContext deleteObject:anUser];
	[library saveContext];
	
	if (YES == needUpdate)
	{
		library.currentUser = [User userWithID:previusID inContext:aContext];
		[library sendNotificationTripsChanged];
	}
}

+ (void)deleteUserWithID:(NSInteger)anUserID inContext:(NSManagedObjectContext *)aContext
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
	request.predicate = [NSPredicate predicateWithFormat:@"userID = %@", [NSNumber numberWithInteger:anUserID]];
	NSError *error;
	NSArray *users = [aContext executeFetchRequest:request error:&error];
	if ([users count])
	{
		User *user = (User *)[users firstObject];
		[User deleteUser:user inContext:aContext];
	}
}

+ (void)editUserWithID:(NSInteger)anUserID forName:(NSString *)aName andColorID:(NSInteger)aColorID inContext:(NSManagedObjectContext *)aContext
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
	request.predicate = [NSPredicate predicateWithFormat:@"userID = %@", [NSNumber numberWithInteger:anUserID]];
	NSError *error;
	NSArray *users = [aContext executeFetchRequest:request error:&error];
	if ([users count])
	{
		User *user = (User *)[users firstObject];
		user.name = aName;
		user.colorID = [NSNumber numberWithInteger:aColorID];
	}
	[[UKLibraryAPI sharedInstance] saveContext];
}


@end
