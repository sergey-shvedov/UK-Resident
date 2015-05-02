//
//  UKTripFormTableViewController.h
//  UK Resident
//
//  Created by Sergey Shvedov on 02.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UKTripFormTVCDelegate <NSObject>

- (void)appearButtons;
- (void)dismissButtons;

@end

@interface UKTripFormTableViewController : UITableViewController

@property (nonatomic, weak) id<UKTripFormTVCDelegate> delegate;

@end
