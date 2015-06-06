//
//  UKCalendarTableView.h
//  UK Resident
//
//  Created by Sergey Shvedov on 27.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header UKCalendarTableView.h
	@abstract Declares interface for UKCalendarTableView.
	@copyright 2015 Sergey Shvedov
*/

#import <UIKit/UIKit.h>

@protocol UKCalendarTableViewAgent <NSObject>

@optional
- (void)calendarTableViewWillRecenterTo:(NSInteger)aRowNumber;
- (void)calendarTableViewDidRecenterTo:(NSInteger)aRowNumber;

@end

/*!
	@abstract The class provides the functionality to create an infinite scrolling table view for a calendar.
*/
@interface UKCalendarTableView : UITableView

@property (nonatomic, weak) id<UKCalendarTableViewAgent> agent;

@end
