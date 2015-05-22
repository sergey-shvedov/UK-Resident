//
//  Trip.h
//  UK Resident
//
//  Created by Sergey Shvedov on 23.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject, UserWithTrip;

@interface Trip : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSString * destination;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSSet *tripsByUser;
@property (nonatomic, retain) NSSet *attachedPhotos;
@end

@interface Trip (CoreDataGeneratedAccessors)

- (void)addTripsByUserObject:(UserWithTrip *)value;
- (void)removeTripsByUserObject:(UserWithTrip *)value;
- (void)addTripsByUser:(NSSet *)values;
- (void)removeTripsByUser:(NSSet *)values;

- (void)addAttachedPhotosObject:(NSManagedObject *)value;
- (void)removeAttachedPhotosObject:(NSManagedObject *)value;
- (void)addAttachedPhotos:(NSSet *)values;
- (void)removeAttachedPhotos:(NSSet *)values;

@end
