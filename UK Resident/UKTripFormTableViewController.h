//
//  UKTripFormTableViewController.h
//  UK Resident
//
//  Created by Sergey Shvedov on 02.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trip.h"
#import "TempTrip.h"

@protocol UKTripFormTVCDelegate <NSObject>

- (void)appearButtons;
- (void)dismissButtons;
- (void)changeNeedEditStatusTo:(BOOL)isNeedEdit;

@end

@interface UKTripFormTableViewController : UITableViewController

@property (nonatomic, weak) id<UKTripFormTVCDelegate> delegate;

@property (strong,nonatomic) Trip *trip;
@property (strong,nonatomic) TempTrip *editingTrip;
@property (strong,nonatomic) NSManagedObjectContext *managedObjectContect;
@property BOOL isCreating;

@end
