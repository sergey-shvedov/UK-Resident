//
//  Trip+Create.h
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "Trip.h"

@interface Trip (Create)

+ (Trip *)firstTripInContext:(NSManagedObjectContext *)context;

@end
