//
//  TripFormAttachmentVC.h
//  UK Resident
//
//  Created by Sergey Shvedov on 22.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header TripFormAttachmentVC.h
	@abstract Declares interface for TripFormAttachmentVC.
	@copyright 2015 Sergey Shvedov
*/

#import <UIKit/UIKit.h>
@class TempTrip;

/*!
	@abstract The class provides the functionality to present required data.
*/
@interface TripFormAttachmentVC : UIViewController

@property (nonatomic, strong) TempTrip *editingTrip;

@end
