//
//  NSDateFormatter+UKResident.h
//  UK Resident
//
//  Created by Sergey Shvedov on 28.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header NSDateFormatter+UKResident.h
	@abstract Declares interface for UNSDateFormatter+UKResident.
	@copyright 2015 Sergey Shvedov
*/

#import <Foundation/Foundation.h>

/*!
	@abstract The category provides the functionality to fast access to the dateFormatter.
*/
@interface NSDateFormatter (UKResident)

+ (NSDateFormatter *)customDateFormatter;

@end
