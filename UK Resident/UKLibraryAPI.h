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
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) NSCalendar *customCalendar;
@property (nonatomic, strong) NSArray *testTrips;
@property (nonatomic, strong) User *currentUser;
@property (nonatomic, strong) NSDate *currentInitDate;
@property (nonatomic, assign) BOOL isInitDateSetted;

+ (UKLibraryAPI *)sharedInstance;

- (BOOL)isATripDate:(NSDate *)aDate inContext:(NSManagedObjectContext *)aContext;
- (NSArray *)arrayWithTripsBetweenStartDate:(NSDate *)aStartBorderDate andEndDate:(NSDate *)anEndBorderDate inContext:(NSManagedObjectContext *)aContext;
- (NSInteger)numberOfTripDaysBetweenStartDate:(NSDate *)aStartBorderDate andEndDate:(NSDate *)anEndBorderDate andCountArrivalAndDepartureDays:(BOOL)aNeedCountArrivalDays inContext:(NSManagedObjectContext *)aContext;
- (NSInteger)numberOfLigalInvestDaysFromDate:(NSDate *)aDate withBoundaryDatesStatus:(BOOL)aBoundaryDatesStatus inContext:(NSManagedObjectContext *)aContext;
- (NSDate *)nearestDateWithRequiredTripDays:(NSInteger)aRequiredTripDaysNumber fromDate:(NSDate *)aDate withBoundaryDatesStatus:(BOOL)aBoundaryDatesStatus inContext:(NSManagedObjectContext *)aContext;
- (void)logAllData;
- (void)saveContext;

@end
