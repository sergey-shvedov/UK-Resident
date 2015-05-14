//
//  TempTrip.m
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "TempTrip.h"
#import "UserWithTrip.h"
#import "User.h"
#import "UKLibraryAPI.h"
#import "NSDate+UKResident.h"

@implementation TempTrip

- (BOOL)isNeedToEdit
{
	return (YES == (self.isStartDateNeedEdit || self.isEndDateNeedEdit || self.isDestinationNeedEdit || self.isCommentNeedEdit));
}

+ (TempTrip *)editingTempTripCopyFromTrip:(Trip *)trip
{
	//get saveTrip to edit
	//trip = (Trip *)[(((MultiTestAppDelegate *)[UIApplication sharedApplication].delegate).saveContext) objectWithID:[trip objectID]];
	
	TempTrip *editingTrip = [[TempTrip alloc] init];
	editingTrip.destination = trip.destination;
	editingTrip.startDate = trip.startDate;
	editingTrip.endDate = trip.endDate;
	editingTrip.comment = trip.comment;
	
	editingTrip.isStartDateNeedEdit = NO;
	editingTrip.isStartDateEdited = YES;
	editingTrip.isEndDateNeedEdit = NO;
	editingTrip.isEndDateEdited = YES;
	editingTrip.isDestinationNeedEdit = NO;
	editingTrip.isDestinationEdited = YES;
	editingTrip.isCommentNeedEdit = NO;
	editingTrip.isCommentEdited = YES;
	
	if (NSOrderedDescending == [editingTrip.startDate compare:editingTrip.endDate])
	{
		editingTrip.isEndDateNeedEdit = YES;
	}
	return editingTrip;
}

+ (TempTrip *)defaultTempTripInContext:(NSManagedObjectContext *)context
{
	TempTrip *editingTrip = [[TempTrip alloc] init];
	editingTrip.startDate = [[NSDate dateWithTimeIntervalSinceNow:60*60*24*14] normalization];;
	editingTrip.endDate = [[NSDate dateWithTimeIntervalSinceNow:60*60*24*28] normalization];
	editingTrip.destination = @"Мое путешествие";
	editingTrip.comment = @"Комментарии";
	
//	editingTrip.usersByTrip=nil; //[NSSet setWithObject:[User mainUserInContext:context]]; // Need set with UserWithTrip in Future
//	editingTrip.users=[NSArray arrayWithObject:[User mainUserInContext:saveContext]];
	
	editingTrip.isStartDateNeedEdit = YES;
	editingTrip.isStartDateEdited = NO;
	editingTrip.isEndDateNeedEdit = YES;
	editingTrip.isEndDateEdited = NO;
	editingTrip.isDestinationNeedEdit = NO;
	editingTrip.isDestinationEdited = NO;
	editingTrip.isCommentNeedEdit = NO;
	editingTrip.isCommentEdited = NO;
	
	return editingTrip;
}

- (void)insertNewTripInContext:(NSManagedObjectContext *)aContext //CREATE
{
	//[aContext performBlock:^{
		Trip *newTrip=[NSEntityDescription insertNewObjectForEntityForName:@"Trip" inManagedObjectContext:aContext];
	
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	UserWithTrip *userWithTrip = [NSEntityDescription insertNewObjectForEntityForName:@"UserWithTrip" inManagedObjectContext:aContext];
	//userWithTrip.whoTravel = library.currentUser;
	//userWithTrip.inTrip = newTrip;
	[library.currentUser addUserByTripObject:userWithTrip];
	[newTrip addTripsByUserObject:userWithTrip];
	
	
//		NSMutableSet *newSet=[[NSMutableSet alloc]init];
//		for (User *user in self.users) {
//			UserWithTrip *userWithTrip= [NSEntityDescription insertNewObjectForEntityForName:@"UserWithTrip" inManagedObjectContext:self.saveContext];
//			userWithTrip.whoTravel=user;
//			userWithTrip.inTrip=newTrip;
//			[newSet addObject:userWithTrip];
//		}
//		self.usersByTrip=newSet;
		
		[self updateTrip:newTrip];
		
		NSError *error;
		[aContext save:&error];
		
//		NSError *error;
//		[self.saveContext save:&error]; //SAVE
//		[context performBlock:^{
//			[[NSNotificationCenter defaultCenter] postNotificationName:TripNeedUpdateTodayCalendarView object:nil]; //NOTIFICATION
//		}];
		
		
		///UPDATE DAYS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//		[DayWithTrip updateDaysFromDate:self.entryDate toDate:self.outDate withTrip:newTrip inContext:self.saveContext]; //Create DaysWithTrip
//		
//		[self.saveContext save:&error];
		
//		[context performBlock:^{
//			[[NSNotificationCenter defaultCenter] postNotificationName:TripSavedNotification object:nil]; //NOTIFICATION
//		}];
		
		
		//[context performBlock:^{ }]; //Main Thread
		
	//}];
}

- (void)updateTrip:(Trip *)trip
{
	trip.destination = self.destination;
	trip.startDate = self.startDate;
	trip.endDate = self.endDate;
	trip.comment = self.comment;
}

- (void)deleteTrip:(Trip *)aTrip InContext:(NSManagedObjectContext *)aContext //DELETE
{
	[aContext deleteObject:aTrip];
	NSError *error;
	[aContext save:&error];
}

- (void)updateDaysWithTrip:(Trip *)aTrip inContext:(NSManagedObjectContext *)aContext
{
	[self updateTrip:aTrip];
	NSError *error;
	[aContext save:&error];
}


@end
