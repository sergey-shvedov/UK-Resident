//
//  UKReportTopInitialDatePopoverVC.h
//  UK Resident
//
//  Created by Sergey Shvedov on 13.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header UKReportTopInitialDatePopoverVC.h
	@abstract Declares interface for UKReportTopInitialDatePopoverVC.
	@copyright 2015 Sergey Shvedov
*/

#import <UIKit/UIKit.h>

/*!
	@abstract The class provides the functionality to create a popover with required data.
*/
@interface UKReportTopInitialDatePopoverVC : UIViewController

@property (nonatomic, strong) NSDate *initialDate;

@end
