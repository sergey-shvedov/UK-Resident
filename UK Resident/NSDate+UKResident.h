//
//  NSDate+UKResident.h
//  UK Resident
//
//  Created by Sergey Shvedov on 28.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header NSDate+UKResident.h
	@abstract Declares interface for NSDate+UKResident.
	@copyright 2015 Sergey Shvedov
*/

#import <Foundation/Foundation.h>

/*!
	@abstract The category provides the functionality to operate with some NSDate elements.
*/
@interface NSDate (UKResident)

+ (NSCalendar *)customCalendar;
+ (NSDate *)dateFromMyString:(NSString *)aDateString;
+ (NSDate *)dateWithDay:(NSInteger)aDay month:(NSInteger)aMonth andYear:(NSInteger)aYear;

- (NSInteger)dayOfWeek;
- (NSInteger)dayOfMonth;
- (NSInteger)weekOfMonth;
- (NSInteger)weekOfYear;
- (NSInteger)monthOfYear;
- (NSInteger)dayComponent;
- (NSInteger)monthComponent;
- (NSInteger)yearComponent;
- (NSInteger)dayOfYear;
- (NSInteger)daysInMonth;
- (NSInteger)numberOfDaysUntil:(NSDate *)aDate;
- (NSInteger)numberOfDaysBetween:(NSDate *)aDate includedBorderDates:(BOOL)aNeedIncludeBorderDates;

- (NSDate *)normalization;
- (NSDate *)startOfDay;
- (NSDate *)endOfDay;
- (NSDate *)startOfYear;
- (NSDate *)endOfYear;
- (NSDate *)addWeekDelta:(NSInteger)aWeekDelta;
- (NSDate *)moveMonth:(NSInteger)aMonthDelta;
- (NSDate *)moveYear:(NSInteger)aYearDelta;
- (NSDate *)moveDay:(NSInteger)aDayDelta;

- (BOOL)isTheSameDayWith:(NSDate *)aSecondDate;
- (BOOL)isToday;

- (NSString *)localizedStringWithDateStyle:(NSDateFormatterStyle)dstyle timeStyle:(NSDateFormatterStyle)tstyle;
- (NSString *)localizedStringWithDateFormat:(NSString *)aDateFormat;

@end
