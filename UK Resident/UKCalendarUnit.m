//
//  UKCalendarUnit.m
//  UK Resident
//
//  Created by Sergey Shvedov on 27.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKCalendarUnit.h"

@implementation UKCalendarUnit

- (instancetype)init
{
	return [self initFromIndex:0 withCurrentCenter:0 andTodayDate:[NSDate date]];
}

- (id)initFromIndex:(NSInteger)anIndex withCurrentCenter:(NSInteger)aCenter andTodayDate:(NSDate *)aTodayDate
{
	self = [super init];
	if (nil != self)
	{
		
	}
	
	return self;
}

@end
