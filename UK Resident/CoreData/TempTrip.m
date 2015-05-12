//
//  TempTrip.m
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "TempTrip.h"
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

@end
