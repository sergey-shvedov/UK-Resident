//
//  UKLibraryAPI.m
//  UK Resident
//
//  Created by Sergey Shvedov on 04.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKLibraryAPI.h"
#import "AppDelegate.h"
#import "Trip.h"
#import "User+Create.h"
#import "UserWithTrip.h"
#import "NSDate+UKResident.h"

@interface UKLibraryAPI ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation UKLibraryAPI

+ (UKLibraryAPI *)sharedInstance
{
	static UKLibraryAPI *_sharedInstance = nil;
	static dispatch_once_t oncePredicate;
	dispatch_once(&oncePredicate, ^{
		_sharedInstance = [[UKLibraryAPI alloc] init];
	});
	return _sharedInstance;
}

- (instancetype)init
{
	self = [super init];
	if (nil != self)
	{
		NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
		[gregorian setFirstWeekday:2];
		self.customCalendar = gregorian;
		
		NSArray *array1 = [[NSArray alloc] initWithObjects:[NSDate dateFromMyString:@"25-05-2015"], [NSDate dateFromMyString:@"15-06-2015"], nil];
		NSArray *array2 = [[NSArray alloc] initWithObjects:[NSDate dateFromMyString:@"02-02-2015"], [NSDate dateFromMyString:@"10-02-2015"], nil];
		NSArray *array3 = [[NSArray alloc] initWithObjects:[NSDate dateFromMyString:@"20-08-2015"], [NSDate dateFromMyString:@"03-09-2015"], nil];
		NSArray *array4 = [[NSArray alloc] initWithObjects:[NSDate dateFromMyString:@"07-12-2015"], [NSDate dateFromMyString:@"23-12-2015"], nil];
		NSArray *array5 = [[NSArray alloc] initWithObjects:[NSDate dateFromMyString:@"10-03-2016"], [NSDate dateFromMyString:@"25-03-2016"], nil];
		
		self.testTrips = [[NSArray alloc] initWithObjects:array1, array2, array3, array4, array5, nil];
	}
	return self;
}

- (NSManagedObjectContext *)managedObjectContext
{
	if (nil == _managedObjectContext)
	{
		_managedObjectContext = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
	}
	return _managedObjectContext;
}

- (NSDate *)currentInitDate
{
	return self.currentUser.establishedDate;
}

- (void)setCurrentInitDate:(NSDate *)currentInitDate
{
	self.currentUser.establishedDate = currentInitDate;
	NSError *error;
	[self.managedObjectContext save:&error];
}

- (BOOL)isATripDate:(NSDate *)aDate
{
	BOOL result = NO;
	
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Trip"];
	request.predicate = [NSPredicate predicateWithFormat:@"(startDate <= %@) AND (endDate >= %@)", [aDate endOfDay], [aDate startOfDay]];
	
	NSError *error;
	NSArray *trips = [self.managedObjectContext executeFetchRequest:request error:&error];
	if ([trips count] > 0) result = YES;

	return result;
}

- (NSArray *)arrayWithTripsBetweenStartDate:(NSDate *)aStartBorderDate andEndDate:(NSDate *)anEndBorderDate
{
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Trip"];
	request.predicate = [NSPredicate predicateWithFormat:@"((startDate <= %@) AND (endDate >= %@)) OR ((startDate >= %@) AND (endDate <= %@)) OR ((startDate <= %@) AND (endDate >= %@))",
						 aStartBorderDate, aStartBorderDate,
						 aStartBorderDate, anEndBorderDate,
						 anEndBorderDate, anEndBorderDate
						 ];
	NSError *error;
	NSArray *trips = [self.managedObjectContext executeFetchRequest:request error:&error];
	return trips;
}

- (NSInteger)numberOfTripDaysBetweenStartDate:(NSDate *)aStartBorderDate andEndDate:(NSDate *)anEndBorderDate andCountArrivalAndDepartureDays:(BOOL)aNeedCountArrivalDays
{
	NSInteger result = 0;
	NSInteger minusDay = aNeedCountArrivalDays ? 0 : 1;
	NSArray *trips = [self arrayWithTripsBetweenStartDate:aStartBorderDate andEndDate:anEndBorderDate];
	
	for (Trip *trip in trips)
	{
		if ((NSOrderedAscending == [trip.startDate compare:aStartBorderDate]) && (NSOrderedAscending == [anEndBorderDate compare:trip.endDate]))
		{
			result += [aStartBorderDate numberOfDaysBetween:anEndBorderDate includedBorderDates:YES];
		}
		else if (NSOrderedAscending == [trip.startDate compare:aStartBorderDate])
		{
			result += [aStartBorderDate numberOfDaysBetween:trip.endDate includedBorderDates:YES] - minusDay;
		}
		else if (NSOrderedAscending == [anEndBorderDate compare:trip.endDate])
		{
			result += [trip.startDate numberOfDaysBetween:anEndBorderDate includedBorderDates:YES] - minusDay;
		}
		else
		{
			result += [trip.startDate numberOfDaysBetween:trip.endDate includedBorderDates:aNeedCountArrivalDays];
		}
	}
	
	return result;
}

- (void)logAllData
{
	NSFetchRequest *userRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
	userRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"userID" ascending:YES]];
	NSError *error;
	NSArray *users = [self.managedObjectContext executeFetchRequest:userRequest error:&error];
	for (User *user in users)
	{
		NSLog(@"=====================================================");
		NSLog(@"User: %@ \nestablishedDate: %@ \nuserByTrip: %i", user.userID, user.establishedDate, (int)[user.userByTrip count]);
	}
	
	NSFetchRequest *userWithTripRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserWithTrip"];
	userRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"whoTravel.userID" ascending:YES]];
	NSError *error2;
	NSArray *usersWithTrips = [self.managedObjectContext executeFetchRequest:userWithTripRequest error:&error2];
	for (UserWithTrip *userWithTrip in usersWithTrips)
	{
		NSLog(@"+++++++++++++++++++++++++++++++++++++++++++++++++++++");
		NSLog(@"UserWithTrip: \nwhoTravel: %@ \ninTrip:%@", userWithTrip.whoTravel.name, userWithTrip.inTrip.startDate);
	}
	
	NSFetchRequest *tripRequest = [NSFetchRequest fetchRequestWithEntityName:@"Trip"];
	userRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:NO selector:@selector(compare:)]];
	NSError *error3;
	NSArray *trips= [self.managedObjectContext executeFetchRequest:tripRequest error:&error3];
	for (Trip *trip in trips)
	{
		NSLog(@"-----------------------------------------------------");
		NSLog(@"Trip: %@ \nDates: %@ – %@ \ntripsByUser: %i", trip.destination, trip.startDate, trip.endDate, (int)[trip.tripsByUser count]);
	}
}


@end
