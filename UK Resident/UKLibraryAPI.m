//
//  UKLibraryAPI.m
//  UK Resident
//
//  Created by Sergey Shvedov on 04.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKLibraryAPI.h"
#import "NSDate+UKResident.h"

@implementation UKLibraryAPI

+ (UKLibraryAPI *)sharedInstance
{
	static UKLibraryAPI *_sharedInstance = nil;
	static dispatch_once_t oncePredicate;
	dispatch_once(&oncePredicate, ^{
		_sharedInstance = [[UKLibraryAPI alloc] init];
	});
	return _sharedInstance;
}

- (instancetype)init
{
	self = [super init];
	if (nil != self)
	{
		NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
		[gregorian setFirstWeekday:2];
		self.customCalendar = gregorian;
		
		NSArray *array1 = [[NSArray alloc] initWithObjects:[NSDate dateFromMyString:@"25-05-2015"], [NSDate dateFromMyString:@"15-06-2015"], nil];
		NSArray *array2 = [[NSArray alloc] initWithObjects:[NSDate dateFromMyString:@"02-02-2015"], [NSDate dateFromMyString:@"10-02-2015"], nil];
		NSArray *array3 = [[NSArray alloc] initWithObjects:[NSDate dateFromMyString:@"20-08-2015"], [NSDate dateFromMyString:@"03-09-2015"], nil];
		NSArray *array4 = [[NSArray alloc] initWithObjects:[NSDate dateFromMyString:@"07-12-2015"], [NSDate dateFromMyString:@"23-12-2015"], nil];
		NSArray *array5 = [[NSArray alloc] initWithObjects:[NSDate dateFromMyString:@"10-03-2016"], [NSDate dateFromMyString:@"25-03-2016"], nil];
		
		self.testTrips = [[NSArray alloc] initWithObjects:array1, array2, array3, array4, array5, nil];
	}
	return self;
}

@end
