//
//  UKCalendarWeek.h
//  UK Resident
//
//  Created by Sergey Shvedov on 28.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header UKCalendarWeek.h
	@abstract Declares interface for UKCalendarWeek objects.
	@copyright 2015 Sergey Shvedov
*/

#import <Foundation/Foundation.h>

/*!
	@abstract The class introduces properties which allow to receive required data for a calendar cell.
*/
@interface UKCalendarWeek : NSObject

@property (nonatomic, strong) NSArray *days;
@property (nonatomic, strong) NSArray *tripDays;
@property (nonatomic, strong) NSArray *warningDays;

- (instancetype)initWithMonthDelta:(NSInteger)aMonthDelta andWeekOfMonth:(NSInteger)aWeekOfMonth fromDate:(NSDate *)aDate;

@end
