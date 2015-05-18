//
//  UKLibraryAPI.h
//  UK Resident
//
//  Created by Sergey Shvedov on 04.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@class User;
@class Trip;

@interface UKLibraryAPI : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *expenciveFetchContext;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) NSCalendar *customCalendar;
@property (nonatomic, strong) NSArray *testTrips;
@property (nonatomic, strong) User *currentUser;
@property (nonatomic, strong) NSDate *currentInitDate;
@property (nonatomic, assign) BOOL isInitDateSetted;

@property (nonatomic, strong, readonly) NSArray *warningInvestTrips;
@property (nonatomic, strong, readonly) NSArray *warningCitizenTrips;

+ (UKLibraryAPI *)sharedInstance;

- (BOOL)isATripDate:(NSDate *)aDate inContext:(NSManagedObjectContext *)aContext;
- (BOOL)isAWarningDate:(NSDate *)aDate;
- (NSArray *)arrayWithTripsBetweenStartDate:(NSDate *)aStartBorderDate andEndDate:(NSDate *)anEndBorderDate inContext:(NSManagedObjectContext *)aContext;
- (NSArray *)arrayWithWarningsBetweenStartDate:(NSDate *)aStartBorderDate andEndDate:(NSDate *)anEndBorderDate;
- (NSInteger)numberOfTripDaysBetweenStartDate:(NSDate *)aStartBorderDate andEndDate:(NSDate *)anEndBorderDate andCountArrivalAndDepartureDays:(BOOL)aNeedCountArrivalDays inContext:(NSManagedObjectContext *)aContext;

- (NSInteger)investNumberOfLigalDaysFromDate:(NSDate *)aDate withBoundaryDatesStatus:(BOOL)aBoundaryDatesStatus inContext:(NSManagedObjectContext *)aContext;
- (NSDate *)investNearestDateWithRequiredTripDays:(NSInteger)aRequiredTripDaysNumber fromDate:(NSDate *)aDate withBoundaryDatesStatus:(BOOL)aBoundaryDatesStatus inContext:(NSManagedObjectContext *)aContext;
- (NSInteger)citizenNumberOfLigalDaysFromDate:(NSDate *)aDate withBoundaryDatesStatus:(BOOL)aBoundaryDatesStatus inContext:(NSManagedObjectContext *)aContext;
- (NSDate *)citizenNearestDateWithRequiredTripDays:(NSInteger)aRequiredTripDaysNumber fromDate:(NSDate *)aDate withBoundaryDatesStatus:(BOOL)aBoundaryDatesStatus inContext:(NSManagedObjectContext *)aContext;
- (Trip *)tripWithStartDate:(NSDate *)aStartDate inContext:(NSManagedObjectContext *)aContext;

- (void)logAllData;
- (void)saveContext;

- (void)sendNotificationTripsChanged;
- (void)sendNotificationNeedUpdateUI;
- (void)sendNotificationNeedUpdateReportView;

@end
