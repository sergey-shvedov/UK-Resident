//
//  UIButton+UKRecord.h
//  UK Resident
//
//  Created by Sergey Shvedov on 29.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header UIButton+UKRecord.h
	@abstract Declares interface for UIButton+UKRecord.
	@copyright 2015 Sergey Shvedov
*/

#import <UIKit/UIKit.h>

/*!
	@abstract The category provides the functionality to store some addition properties.
*/
@interface UIButton (UKRecord)

@property (nonatomic, strong) id ukRecord;
@property (nonatomic, strong) NSDate *buttonDate;

@end
