//
//  UIButton+UKRecord.m
//  UK Resident
//
//  Created by Sergey Shvedov on 29.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <objc/runtime.h>
#import "UIButton+UKRecord.h"

static const char *const kUKDateRecordKey = "UK-date-record-key";

@implementation UIButton (UKRecord)

- (void)setUkRecord:(id)aUKRecord
{
	objc_setAssociatedObject(self, kUKDateRecordKey, aUKRecord, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)ukRecord
{
	return objc_getAssociatedObject(self, kUKDateRecordKey);
}

- (void)setButtonDate:(NSDate *)aButtonDate
{
	self.ukRecord = aButtonDate;
}

- (NSDate *)buttonDate
{
	NSDate *date = nil;
	if ([self.ukRecord isKindOfClass:[NSDate class]])
	{
		date = (NSDate *)self.ukRecord;
	}
	return date;
}

@end
