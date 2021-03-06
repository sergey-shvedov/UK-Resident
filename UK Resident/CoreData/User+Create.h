//
//  User+Create.h
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header User+Create.h
	@abstract Declares interface for User+Create.
	@copyright 2015 Sergey Shvedov
*/

#import "User.h"

/*!
	@abstract The category provides the functionality to create and edit a User object.
*/
@interface User (Create)

+ (User *)firstUserInContext:(NSManagedObjectContext *)context;
+ (User *)userWithID:(NSUInteger)anUserID inContext:(NSManagedObjectContext *)aContext;
+ (User *)createNextUserinContext:(NSManagedObjectContext *)aContext;

+ (void)deleteUser:(User *)anUser inContext:(NSManagedObjectContext *)aContext;
+ (void)deleteUserWithID:(NSInteger)anUserID inContext:(NSManagedObjectContext *)aContext;
+ (void)editUserWithID:(NSInteger)anUserID forName:(NSString *)aName andColorID:(NSInteger)aColorID inContext:(NSManagedObjectContext *)aContext;

@end
