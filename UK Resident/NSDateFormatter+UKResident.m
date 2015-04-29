//
//  NSDateFormatter+UKResident.m
//  UK Resident
//
//  Created by Sergey Shvedov on 28.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "NSDateFormatter+UKResident.h"

@implementation NSDateFormatter (UKResident)

+ (NSDateFormatter *)customDateFormatter
{
	NSDateFormatter *df=[[NSDateFormatter alloc]init];
	[df setCalendar:[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian]];
	[df setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"ru_RU"]];
	return df;
}

@end
