//
//  NSDate+UKResident.h
//  UK Resident
//
//  Created by Sergey Shvedov on 28.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (UKResident)

- (NSCalendar *)customCalendar;

- (NSInteger)dayOfWeek;
- (NSInteger)weekOfMonth;
- (NSInteger)weekOfYear;
- (NSInteger)monthOfYear;
- (NSInteger)dayComponent;
- (NSInteger)monthComponent;
- (NSInteger)yearComponent;

- (NSDate *)normalization;
- (NSDate *)addWeekDelta:(NSInteger)aWeekDelta;
- (NSDate *)moveMonth:(NSInteger)aMonthDelta;

@end
