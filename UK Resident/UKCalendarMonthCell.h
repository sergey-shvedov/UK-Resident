//
//  UKCalendarMonthCell.h
//  UK Resident
//
//  Created by Sergey Shvedov on 28.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header UKCalendarMonthCell.h
	@abstract Declares interface for UKCalendarMonthCell.
	@copyright 2015 Sergey Shvedov
*/

#import <UIKit/UIKit.h>

/*!
	@abstract The class provides the functionality to present data in a custom cell.
*/
@interface UKCalendarMonthCell : UITableViewCell

@property (nonatomic, strong) NSDate *date;

@end
