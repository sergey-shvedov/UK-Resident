//
//  AttachPhoto.h
//  UK Resident
//
//  Created by Sergey Shvedov on 23.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Trip;

@interface AttachPhoto : NSManagedObject

@property (nonatomic, retain) NSString * storePath;
@property (nonatomic, retain) Trip *inTrip;

@end
