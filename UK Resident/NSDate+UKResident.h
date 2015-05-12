//
//  NSDate+UKResident.h
//  UK Resident
//
//  Created by Sergey Shvedov on 28.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

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
