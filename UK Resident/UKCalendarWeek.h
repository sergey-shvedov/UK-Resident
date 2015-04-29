//
//  UKCalendarWeek.h
//  UK Resident
//
//  Created by Sergey Shvedov on 28.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UKCalendarWeek : NSObject

@property (nonatomic, strong) NSArray *days;
@property (nonatomic, strong) NSArray *tripDays;
@property (nonatomic, strong) NSArray *warningDays;

- (instancetype)initWithWeekDelta:(NSInteger)aWeekDelta fromDate:(NSDate *)aDate;
- (instancetype)initWithMonthDelta:(NSInteger)aMonthDelta andWeekOfMonth:(NSInteger)aWeekOfMonth fromDate:(NSDate *)aDate;

@end
