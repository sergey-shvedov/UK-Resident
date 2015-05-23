//
//  NSString+UKResident.m
//  UK Resident
//
//  Created by Sergey Shvedov on 01.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "NSString+UKResident.h"

@implementation NSString (UKResident)

+ (NSString *)russianStringFor1:(NSString *)aStringFor1 for2to4:(NSString *)aStringFor2to4 for5up:(NSString *)aStringFor5up withValue:(NSInteger)aValue;
{
	NSString *result =nil;
	aValue = labs(aValue);
	
	if (aValue > 100)
	{
		aValue = aValue % 100;
	}
	if (aValue > 10 && aValue <= 20)
	{
		return aStringFor5up;
	}
	if (aValue > 20)
	{
		aValue = aValue % 10;
	}
	if (0 == aValue) return aStringFor5up;
	else if (1 == aValue) return aStringFor1;
	else if (aValue > 1 && aValue < 5) return aStringFor2to4;
	else return aStringFor5up;
	return result;
}

+ (NSString *)documentsDirectory
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return documentsDirectory;
}

- (NSString *)pathToDocumentDirectory
{
	NSString *imagePath =[[NSString documentsDirectory] stringByAppendingPathComponent:self];
	return imagePath;
}

@end
