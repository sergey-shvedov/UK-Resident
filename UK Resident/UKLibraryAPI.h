//
//  UKLibraryAPI.h
//  UK Resident
//
//  Created by Sergey Shvedov on 04.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@class NSManagedObjectContext;

@interface UKLibraryAPI : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *expenciveFetchContext;

@property (nonatomic, strong) NSCalendar *customCalendar;
@property (nonatomic, strong) NSArray *testTrips;
@property (nonatomic, strong) User *currentUser;
@property (nonatomic, strong) NSDate *currentInitDate;
@property (nonatomic, assign) BOOL isInitDateSetted;

+ (UKLibraryAPI *)sharedInstance;

- (BOOL)isATripDate:(NSDate *)aDate;
- (NSArray *)arrayWithTripsBetweenStartDate:(NSDate *)aStartBorderDate andEndDate:(NSDate *)anEndBorderDate;
- (NSInteger)numberOfTripDaysBetweenStartDate:(NSDate *)aStartBorderDate andEndDate:(NSDate *)anEndBorderDate andCountArrivalAndDepartureDays:(BOOL)aNeedCountArrivalDays;
- (NSInteger)numberOfLigalInvestDaysFromDate:(NSDate *)aDate withBoundaryDatesStatus:(BOOL)aBoundaryDatesStatus;
- (NSDate *)nearestDateWithRequiredTripDays:(NSInteger)aRequiredTripDaysNumber fromDate:(NSDate *)aDate withBoundaryDatesStatus:(BOOL)aBoundaryDatesStatus;
- (void)logAllData;
- (void)saveContext;

@end
