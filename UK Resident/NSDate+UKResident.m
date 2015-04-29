//
//  NSDate+UKResident.m
//  UK Resident
//
//  Created by Sergey Shvedov on 28.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "NSDate+UKResident.h"

@implementation NSDate (UKResident)

- (NSCalendar *)customCalendar
{
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	[gregorian setFirstWeekday:2];
	return gregorian;
}

- (NSInteger)dayOfWeek
{
	NSDateComponents *component = [[self customCalendar] components:NSCalendarUnitWeekday fromDate:self];
	return [component weekday];
}

- (NSInteger)weekOfMonth
{
	NSDateComponents *component = [[self customCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self];
	return [component weekOfMonth];
}

- (NSInteger)weekOfYear
{
	NSDateComponents *component = [[self customCalendar] components:NSCalendarUnitWeekOfYear fromDate:self];
	return [component weekOfYear];
}

- (NSInteger)monthOfYear
{
	NSDateComponents *component = [[self customCalendar] components:NSCalendarUnitMonth fromDate:self];
	return [component month];
}

- (NSInteger)dayComponent
{
	NSDateComponents *component = [[self customCalendar] components:NSCalendarUnitDay fromDate:self];
	return [component day];
}

- (NSInteger)monthComponent
{
	NSDateComponents *component = [[self customCalendar] components:NSCalendarUnitMonth fromDate:self];
	return [component month];
}

- (NSInteger)yearComponent
{
	NSDateComponents *component = [[self customCalendar] components:NSCalendarUnitYear fromDate:self];
	return [component year];
}

- (NSDate *)normalization
{
	NSDate *date = nil;
	NSCalendar *calendar = [self customCalendar];
	NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour) fromDate:self];
	[components setHour:12];
	date = [calendar dateFromComponents:components];
	return date;
}

- (NSDate *)addWeekDelta:(NSInteger)aWeekDelta
{
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setWeekOfYear:aWeekDelta];
	return [[self customCalendar] dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)moveMonth:(NSInteger)aMonthDelta
{
	NSCalendar *calendar = [self customCalendar];
	NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:self];
	[components setMonth:[components month] + aMonthDelta];
	NSDate *date = [calendar dateFromComponents:components];
	return date;
}

@end
