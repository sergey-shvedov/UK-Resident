//
//  NSUserDefaults+AccessoryMethods.m
//  UK Resident
//
//  Created by Sergey Shvedov on 14.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "NSUserDefaults+AccessoryMethods.h"

static NSString *const kDisplayIsTheFirstLaunchKey = @"display-is-the-first-launch";
static NSString *const kDisplayUserIDKey = @"display-user-id";
static NSString *const kDisplayCheckTypeKey = @"display-check-type";
static NSString *const kDisplayBoundaryDatesStatusKey = @"display-boundary-dates-status";

@implementation NSUserDefaults (AccessoryMethods)

- (void)setIsLaunchedOnce:(BOOL)isLaunchedOnce
{
	[[NSUserDefaults standardUserDefaults] setBool:isLaunchedOnce forKey:kDisplayIsTheFirstLaunchKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isLaunchedOnce
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:kDisplayIsTheFirstLaunchKey];
}

- (void)setUserID:(NSUInteger)userID
{
	[[NSUserDefaults standardUserDefaults] setInteger:userID forKey:kDisplayUserIDKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSUInteger)userID
{
	NSUInteger result = 0;
	NSInteger saved = [[NSUserDefaults standardUserDefaults] integerForKey:kDisplayUserIDKey];
	if (saved >= 0) result = saved;
	return result;
}

- (void)setDisplayCheckType:(UKRecentCheckType)displayCheckType
{
	[[NSUserDefaults standardUserDefaults] setInteger:displayCheckType forKey:kDisplayCheckTypeKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (UKRecentCheckType)displayCheckType
{
	return [[NSUserDefaults standardUserDefaults] integerForKey:kDisplayCheckTypeKey];
}

- (void)setDisplayBoundaryDatesStatus:(UKRecentBoundaryDatesStatus)displayBoundaryDatesStatus
{
	[[NSUserDefaults standardUserDefaults] setInteger:displayBoundaryDatesStatus forKey:kDisplayBoundaryDatesStatusKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (UKRecentBoundaryDatesStatus)displayBoundaryDatesStatus
{
	return [[NSUserDefaults standardUserDefaults] integerForKey:kDisplayBoundaryDatesStatusKey];
}


@end
