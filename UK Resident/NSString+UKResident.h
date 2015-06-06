//
//  NSString+UKResident.h
//  UK Resident
//
//  Created by Sergey Shvedov on 01.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header NSString+UKResident.h
	@abstract Declares interface for NSString+UKResident.
	@copyright 2015 Sergey Shvedov
*/

#import <Foundation/Foundation.h>

/*!
	@abstract The category provides the functionality to create special strings.
*/
@interface NSString (UKResident)

+ (NSString *)russianStringFor1:(NSString *)aStringFor1 for2to4:(NSString *)aStringFor2to4 for5up:(NSString *)aStringFor5up withValue:(NSInteger)aValue;
+ (NSString *)documentsDirectory;
- (NSString *)pathToDocumentDirectory;

@end
