//
//  UserWithTrip.h
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Trip, User;

@interface UserWithTrip : NSManagedObject

@property (nonatomic, retain) Trip *inTrip;
@property (nonatomic, retain) User *whoTravel;

@end
