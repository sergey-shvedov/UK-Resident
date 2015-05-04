//
//  UKCalendarWeek.m
//  UK Resident
//
//  Created by Sergey Shvedov on 28.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKCalendarWeek.h"
#import "NSDate+UKResident.h"

@interface UKCalendarWeek ()

@property (nonatomic, strong) NSArray *testTrips;

@end

@implementation UKCalendarWeek

- (NSArray *)testTrips
{
	if (nil == _testTrips)
	{
		NSArray *array1 = [[NSArray alloc] initWithObjects:[NSDate dateFromMyString:@"25-05-2015"], [NSDate dateFromMyString:@"15-06-2015"], nil];
		NSArray *array2 = [[NSArray alloc] initWithObjects:[NSDate dateFromMyString:@"02-02-2015"], [NSDate dateFromMyString:@"10-02-2015"], nil];
		NSArray *array3 = [[NSArray alloc] initWithObjects:[NSDate dateFromMyString:@"20-08-2015"], [NSDate dateFromMyString:@"03-09-2015"], nil];
		NSArray *array4 = [[NSArray alloc] initWithObjects:[NSDate dateFromMyString:@"07-12-2015"], [NSDate dateFromMyString:@"23-12-2015"], nil];
		NSArray *array5 = [[NSArray alloc] initWithObjects:[NSDate dateFromMyString:@"10-03-2016"], [NSDate dateFromMyString:@"25-03-2016"], nil];
		
		_testTrips = [[NSArray alloc] initWithObjects:array1, array2, array3, array4, array5, nil];
	}
	return _testTrips;
}

- (instancetype)init
{
	return [self initWithMonthDelta:0 andWeekOfMonth:1 fromDate:[NSDate date]];
}

- (instancetype)initWithMonthDelta:(NSInteger)aMonthDelta andWeekOfMonth:(NSInteger)aWeekOfMonth fromDate:(NSDate *)aDate
{
	self = [super init];
	
	if (nil != self)
	{
		NSCalendar *calendar = [NSDate customCalendar];
		NSDateComponents* components = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday fromDate:aDate];
		
		[components setMonth:[components month] + aMonthDelta];
		NSInteger searchMonth = [components month];
		[components setWeekOfMonth:aWeekOfMonth];
		

		NSDateComponents *tempComp = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:aDate];
		[tempComp setMonth:[tempComp month] + aMonthDelta];
		NSDate *monthDate = [calendar dateFromComponents:tempComp];
		NSDateComponents *comp1 = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:monthDate];
		
		NSMutableArray *array = [[NSMutableArray alloc] init];
		NSMutableArray *trips = [[NSMutableArray alloc] init];
		
		for (int i = 2; i <= 8; i++)
		{
			[components setWeekday:i];
			
			NSDate *searchDate = [calendar dateFromComponents:components];
			NSDateComponents *comp2 = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:searchDate];
			
			if ([comp1 month] == [comp2 month])
			{
				[array addObject:searchDate];
				if ([self isATripDate:searchDate])
				{
					[trips addObject:@(1)];
				}
				else
				{
					[trips addObject:[NSNull null]];
				}
			}
			else
			{
				[array addObject:[NSNull null]];
				[trips addObject:[NSNull null]];
			}
			
			self.days = array;
			self.tripDays = trips;
		}
	}
	
	return self;
}

- (BOOL)isATripDate:(NSDate *)aDate
{
	BOOL result = NO;
	
	for (NSArray *trip in self.testTrips)
	{
		NSDate *startTrip = (NSDate *)[trip objectAtIndex:0];
		NSDate *endTrip = (NSDate *)[trip objectAtIndex:1];
		if ((NSOrderedAscending == [startTrip compare:aDate]) && (NSOrderedAscending == [aDate compare:endTrip]))
		{
			result = YES;
			break;
		}
	}
	
	return result;
}



@end
