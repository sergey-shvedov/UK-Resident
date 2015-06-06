//
//  WarningTrip.h
//  UK Resident
//
//  Created by Sergey Shvedov on 17.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header WarningTrip.h
	@abstract Declares interface for WarningTrip.
	@copyright 2015 Sergey Shvedov
*/

#import <Foundation/Foundation.h>

/*!
	@abstract The class introduces properties stored in an object.
*/
@interface WarningTrip : NSObject

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSDate *warningDate;

@end
