//
//  NSUserDefaults+AccessoryMethods.h
//  UK Resident
//
//  Created by Sergey Shvedov on 14.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header NSUserDefaults+AccessoryMethods.h
	@abstract Declares interface for NSUserDefaults+AccessoryMethods.
	@copyright 2015 Sergey Shvedov
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, UKRecentCheckType)
{
	kUKRecentCheckTypeInvestor = 0,
	kUKRecentCheckTypeСitizen,
};

typedef NS_ENUM(NSInteger, UKRecentBoundaryDatesStatus)
{
	kUKRecentBoundaryDatesStatusExcept = 0,
	kUKRecentBoundaryDatesStatusCount,
};

/*!
	@abstract The category provides the functionality to access and store user defaults.
*/
@interface NSUserDefaults (AccessoryMethods)

@property (nonatomic, assign) BOOL isLaunchedOnce;
@property (nonatomic, assign) NSUInteger userID;
@property (nonatomic, assign) UKRecentCheckType displayCheckType;
@property (nonatomic, assign) UKRecentBoundaryDatesStatus displayBoundaryDatesStatus;

@end
