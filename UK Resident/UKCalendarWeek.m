//
//  UKCalendarWeek.m
//  UK Resident
//
//  Created by Sergey Shvedov on 28.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKCalendarWeek.h"
#import "NSDate+UKResident.h"

@implementation UKCalendarWeek

- (instancetype)init
{
	return [self initWithWeekDelta:0 fromDate:[NSDate date]];
}

- (instancetype)initWithWeekDelta:(NSInteger)aWeelDelta fromDate:(NSDate *)aDate
{
	self = [super init];
	
	if (nil != self)
	{
		NSDate *modifiedDate = [aDate addWeekDelta:aWeelDelta];
		NSCalendar *gregorian = [NSDate customCalendar];
		
		NSRange range = [gregorian rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:modifiedDate];
		
		NSLog(@"RANGE: %lu: %lu", (unsigned long)range.location, (unsigned long)range.length);
		
		NSMutableArray *array = [[NSMutableArray alloc] init];
		
//		for (int i = 0; i < 7; i++)
//		{
//			if (i < range.location || i > (range.location + range.length))
//			{
//				[array addObject:[NSNull null]];
//			}
//			else
//			{
//				NSDateComponents *components = [[NSDateComponents alloc] init];
//				[components setDay:(i - [modifiedDate dayOfWeek])];
//				NSDate *date = [gregorian dateByAddingComponents:components toDate:modifiedDate options:0];
//				
//				
//				NSLog(@"OLD:%@  -- DAY:%@", modifiedDate, date);
//				
//				//NSDateComponents *components2 = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
//				[array addObject:date];
//				
//			}
//		}
		
		for (int i = 0; i < 7; i++)
		{
			NSDateComponents *components = [[NSDateComponents alloc] init];
			[components setWeekday:i];
			NSDate *date = [gregorian dateByAddingComponents:components toDate:modifiedDate options:0];
			NSDateComponents* comp1 = [gregorian components:NSCalendarUnitMonth fromDate:modifiedDate];
			NSDateComponents* comp2 = [gregorian components:NSCalendarUnitMonth fromDate:date];
			if ([comp1 month] == [comp2 month])
			{
				[array addObject:date];
			}
			else
			{
				[array addObject:[NSNull null]];
			}
		}
		
		self.days = array;
		
		
//		for (NSUInteger i = range.location; i < (range.location + range.length); i++)
//		{
//			NSDateComponents *components = [[NSDateComponents alloc] init];
//			[components setDay:(i - [modifiedDate dayOfWeek])];
//			NSDate *date = [gregorian dateByAddingComponents:components toDate:modifiedDate options:0];
//			
//			
//			NSLog(@"OLD:%@  -- DAY:%@", modifiedDate, date);
//			
//			NSDateComponents *components2 = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
//
//			[array replaceObjectAtIndex:i withObject:[NSNumber numberWithInteger:[components2 day]]];
//			
//			//array replaceObjectAtIndex:i withObject:[NSNumber]
//		}
		//NSLog(@"RANGE:%lu", (unsigned long)range.length);
		
	}
	return self;
}

- (instancetype)initWithMonthDelta:(NSInteger)aMonthDelta andWeekOfMonth:(NSInteger)aWeekOfMonth fromDate:(NSDate *)aDate
{
	self = [super init];
	
	if (nil != self)
	{
		NSLog(@"");
		NSLog(@"       #month: %li, week%li", (long)aMonthDelta, (long)aWeekOfMonth);
		NSCalendar *calendar = [NSDate customCalendar];
		NSDateComponents* components = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday fromDate:aDate];
		
		[components setMonth:[components month] + aMonthDelta];
		NSInteger searchMonth = [components month];
		[components setWeekOfMonth:aWeekOfMonth];
		

		NSDateComponents *tempComp = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:aDate];
		[tempComp setMonth:[tempComp month] + aMonthDelta];
		NSDate *monthDate = [calendar dateFromComponents:tempComp];
		NSDateComponents *comp1 = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:monthDate];
		//NSLog(@"%@", date);
		
		NSMutableArray *array = [[NSMutableArray alloc] init];
		
		for (int i = 2; i <= 8; i++)
		{
			[components setWeekday:i];
			
			NSDate *searchDate = [calendar dateFromComponents:components];
			
			NSDateComponents *comp2 = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:searchDate];
			
			NSLog(@"%i) %li / %li /comp1: %li ~ %@ ~aDate: %@", i, (long)searchMonth, (long)[comp2 month], (long)[comp1 month], searchDate, aDate);
			
			if ([comp1 month] == [comp2 month])
			{
				[array addObject:searchDate];
				//NSLog(@"%@", searchDate);
			}
			else
			{
				[array addObject:[NSNull null]];
			}
			
			self.days = array;
		}


		
		
		
	}
	
	return self;
}

@end
