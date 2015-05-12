//
//  User.h
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UserWithTrip;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * establishedDate;
@property (nonatomic, retain) NSNumber * colorID;
@property (nonatomic, retain) NSSet *userByTrip;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addUserByTripObject:(UserWithTrip *)value;
- (void)removeUserByTripObject:(UserWithTrip *)value;
- (void)addUserByTrip:(NSSet *)values;
- (void)removeUserByTrip:(NSSet *)values;

@end
