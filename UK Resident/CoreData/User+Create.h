//
//  User+Create.h
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "User.h"

@interface User (Create)

+ (User *)firstUserInContext:(NSManagedObjectContext *)context;
+ (User *)userWithID:(NSUInteger)anUserID inContext:(NSManagedObjectContext *)aContext;
//+ (User *)createNextUserinContext:(NSManagedObjectContext *)context;

+ (void)deleteUser:(User *)anUser inContext:(NSManagedObjectContext *)aContext;

@end
