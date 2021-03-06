//
//  TempTrip.h
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header TempTrip.h
	@abstract Declares interface for TempTrip.
	@copyright 2015 Sergey Shvedov
*/

#import <Foundation/Foundation.h>
#import "Trip.h"

/*!
	@abstract The class provides the functionality to create and edit a TempTrip object.
*/
@interface TempTrip : NSObject

@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSDate *endDate;
@property (nonatomic, retain) NSString *destination;
@property (nonatomic, retain) NSString *comment;
@property (nonatomic, retain) NSSet *tripsByUser;
@property (nonatomic, retain) NSMutableSet *attachedPhotosPathStrings;

@property (nonatomic) BOOL isStartDateNeedEdit;
@property (nonatomic) BOOL isStartDateEdited;
@property (nonatomic) BOOL isEndDateNeedEdit;
@property (nonatomic) BOOL isEndDateEdited;
@property (nonatomic) BOOL isDestinationNeedEdit;
@property (nonatomic) BOOL isDestinationEdited;
@property (nonatomic) BOOL isCommentNeedEdit;
@property (nonatomic) BOOL isCommentEdited;

@property (nonatomic) BOOL isNeedToEdit;
@property (nonatomic, retain) NSMutableSet *addedPhotosWhileEdited;
@property (nonatomic, retain) NSMutableSet *deletedPhotosWhileEdited;


+ (TempTrip *)editingTempTripCopyFromTrip:(Trip *)trip;
+ (TempTrip *)defaultTempTripInContext:(NSManagedObjectContext *)context;
- (void)insertNewTripInContext:(NSManagedObjectContext *)aContext;
- (void)deleteTrip:(Trip *)aTrip InContext:(NSManagedObjectContext *)aContext; //DELETE
- (void)updateDaysWithTrip:(Trip *)aTrip inContext:(NSManagedObjectContext *)aContext;
- (void)removeUnusedSavedPhotosBy:(Trip *)trip;
- (void)recheckSavedPhotosForDeletion;

@end
