//
//  UKCalendarWeekCell.h
//  UK Resident
//
//  Created by Sergey Shvedov on 27.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header UKCalendarWeekCell.h
	@abstract Declares interface for UKCalendarWeekCell.
	@copyright 2015 Sergey Shvedov
*/

#import <UIKit/UIKit.h>

@class UKCalendarWeek;

/*!
	@abstract The class provides the functionality to present data in a custom cell.
*/
@interface UKCalendarWeekCell : UITableViewCell

@property (nonatomic, assign) NSInteger mark;
@property (nonatomic, strong) UKCalendarWeek *week;

@end
