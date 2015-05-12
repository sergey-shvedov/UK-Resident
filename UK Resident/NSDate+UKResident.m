//
//  NSDate+UKResident.m
//  UK Resident
//
//  Created by Sergey Shvedov on 28.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "NSDate+UKResident.h"
#import "UKLibraryAPI.h"

@implementation NSDate (UKResident)

+ (NSCalendar *)customCalendar
{
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	
	return library.customCalendar;
}

+ (NSDate *)dateFromMyString:(NSString *)aDateString
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd-MM-yyyy"];
	return [dateFormatter dateFromString:aDateString];
}

+ (NSDate *)dateWithDay:(NSInteger)aDay month:(NSInteger)aMonth andYear:(NSInteger)aYear
{
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setYear:aYear];
	[components setMonth:aMonth];
	[components setDay:aDay];
	return [[NSDate customCalendar] dateFromComponents:components];
}

- (NSInteger)dayOfWeek
{
	NSDateComponents *component = [[NSDate customCalendar] components:NSCalendarUnitWeekday fromDate:self];
	return [component weekday];
}

- (NSInteger)dayOfMonth
{
	NSDateComponents *component = [[NSDate customCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
	return [component day];
}

- (NSInteger)weekOfMonth
{
	NSDateComponents *component = [[NSDate customCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self];
	return [component weekOfMonth];
}

- (NSInteger)weekOfYear
{
	NSDateComponents *component = [[NSDate customCalendar] components:NSCalendarUnitWeekOfYear fromDate:self];
	return [component weekOfYear];
}

- (NSInteger)monthOfYear
{
	NSDateComponents *component = [[NSDate customCalendar] components:NSCalendarUnitMonth fromDate:self];
	return [component month];
}

- (NSInteger)dayComponent
{
	NSDateComponents *component = [[NSDate customCalendar] components:NSCalendarUnitDay fromDate:self];
	return [component day];
}

- (NSInteger)monthComponent
{
	NSDateComponents *component = [[NSDate customCalendar] components:NSCalendarUnitMonth fromDate:self];
	return [component month];
}

- (NSInteger)yearComponent
{
	NSDateComponents *component = [[NSDate customCalendar] components:NSCalendarUnitYear fromDate:self];
	return [component year];
}

- (NSInteger)dayOfYear
{
	return [[NSDate customCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:self];
}

- (NSInteger)daysInMonth
{
	NSRange range = [[NSDate customCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
	return range.length;
}

- (NSInteger)numberOfDaysUntil:(NSDate *)aDate
{
	NSDateComponents *components = [[NSDate customCalendar] components:NSCalendarUnitDay fromDate:self toDate:aDate options:0];
	return [components day];
}

- (NSDate *)normalization
{
	NSDate *date = nil;
	NSCalendar *calendar = [NSDate customCalendar];
	NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour) fromDate:self];
	[components setHour:12];
	date = [calendar dateFromComponents:components];
	return date;
}

- (NSDate *)startOfDay
{
	NSDate *date = nil;
	NSCalendar *calendar = [NSDate customCalendar];
	NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:self];
	[components setHour:0];
	[components setMinute:0];
	[components setSecond:0];
	date = [calendar dateFromComponents:components];
	return date;
}

- (NSDate *)endOfDay
{
	NSDate *date = nil;
	NSCalendar *calendar = [NSDate customCalendar];
	NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:self];
	[components setHour:23];
	[components setMinute:59];
	[components setSecond:59];
	date = [calendar dateFromComponents:components];
	return date;
}

- (NSDate *)addWeekDelta:(NSInteger)aWeekDelta
{
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setWeekOfYear:aWeekDelta];
	return [[NSDate customCalendar] dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)moveMonth:(NSInteger)aMonthDelta
{
	NSCalendar *calendar = [NSDate customCalendar];
	NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:self];
	[components setMonth:[components month] + aMonthDelta];
	NSDate *date = [calendar dateFromComponents:components];
	return date;
}

- (NSDate *)moveYear:(NSInteger)aYearDelta
{
	NSCalendar *calendar = [NSDate customCalendar];
	NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
	[components setYear:[components year] + aYearDelta];
	NSDate *date = [calendar dateFromComponents:components];
	return date;
}
- (NSDate *)moveDay:(NSInteger)aDayDelta
{
	NSCalendar *calendar = [NSDate customCalendar];
	NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
	[components setDay:[components day] + aDayDelta];
	NSDate *date = [calendar dateFromComponents:components];
	return date;
}

- (BOOL)isTheSameDayWith:(NSDate *)aSecondDate
{
	NSCalendar *calendar = [NSDate customCalendar];
	return [calendar isDate:self inSameDayAsDate:aSecondDate];
}

- (BOOL)isToday
{
	NSCalendar *calendar = [NSDate customCalendar];
	return [calendar isDateInToday:self];
}

- (NSString *)localizedStringWithDateStyle:(NSDateFormatterStyle)dstyle timeStyle:(NSDateFormatterStyle)tstyle
{
	NSDateFormatter *dateFormatter = [NSDate dateFormatter];
	[dateFormatter setDateStyle:dstyle];
	[dateFormatter setTimeStyle:tstyle];
	return [dateFormatter stringFromDate:self];
}

+ (NSDateFormatter *)dateFormatter
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setCalendar:[NSDate customCalendar]];
	[dateFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"ru_RU"]];
	return dateFormatter;
}

- (NSString *)localizedStringWithDateFormat:(NSString *)aDateFormat
{
	NSDateFormatter *dateFormatter = [NSDate dateFormatter];
	[dateFormatter setDateFormat:aDateFormat];
	return [dateFormatter stringFromDate:self];
}

@end
