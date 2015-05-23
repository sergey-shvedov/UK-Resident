//
//  NSString+UKResident.h
//  UK Resident
//
//  Created by Sergey Shvedov on 01.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UKResident)

+ (NSString *)russianStringFor1:(NSString *)aStringFor1 for2to4:(NSString *)aStringFor2to4 for5up:(NSString *)aStringFor5up withValue:(NSInteger)aValue;
+ (NSString *)documentsDirectory;
- (NSString *)pathToDocumentDirectory;

@end
