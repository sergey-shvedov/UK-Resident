//
//  UKCalendarWeek.m
//  UK Resident
//
//  Created by Sergey Shvedov on 28.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKCalendarWeek.h"
#import "NSDate+UKResident.h"
#import "UKLibraryAPI.h"
#import "AppDelegate.h"

@interface UKCalendarWeek ()

@end

@implementation UKCalendarWeek

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
		//NSInteger searchMonth = [components month];
		[components setWeekOfMonth:aWeekOfMonth];
		

		NSDateComponents *tempComp = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:aDate];
		[tempComp setMonth:[tempComp month] + aMonthDelta];
		NSDate *monthDate = [calendar dateFromComponents:tempComp];
		NSDateComponents *comp1 = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:monthDate];
		
		NSMutableArray *array = [[NSMutableArray alloc] init];
		NSMutableArray *trips = [[NSMutableArray alloc] init];
		NSMutableArray *warnings = [[NSMutableArray alloc] init];
		
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
				
				if ([self isAWarningDate:searchDate])
				{
					[warnings addObject:@(1)];
				}
				else
				{
					[warnings addObject:[NSNull null]];
				}
			}
			else
			{
				[array addObject:[NSNull null]];
				[trips addObject:[NSNull null]];
				[warnings addObject:[NSNull null]];
			}
			
			self.days = array;
			self.tripDays = trips;
			self.warningDays = warnings;
		}
	}
	
	return self;
}

- (BOOL)isATripDate:(NSDate *)aDate
{
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	return [library isATripDate:aDate inContext:library.managedObjectContext];
}

- (BOOL)isAWarningDate:(NSDate *)aDate
{
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	return [library isAWarningDate:aDate];
}

@end
