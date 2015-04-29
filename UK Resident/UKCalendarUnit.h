//
//  UKCalendarUnit.h
//  UK Resident
//
//  Created by Sergey Shvedov on 27.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, UKUnitType)
{
	UKUnitTypeWeek = 0,
	UKUnitTypeMonth,
	UKUnitTypeYear,
};

@interface UKCalendarUnit : NSObject

- (id)initFromIndex:(NSInteger)anIndex withCurrentCenter:(NSInteger)aCenter andTodayDate:(NSDate*)aTodayDate;

@property (nonatomic, assign, readonly) UKUnitType type;

@end
