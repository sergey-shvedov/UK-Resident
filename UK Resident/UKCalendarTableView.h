//
//  UKCalendarTableView.h
//  UK Resident
//
//  Created by Sergey Shvedov on 27.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UKCalendarTableViewAgent <NSObject>

@optional
- (void)calendarTableViewWillRecenterTo:(NSInteger)aRowNumber;
- (void)calendarTableViewDidRecenterTo:(NSInteger)aRowNumber;

@end

@interface UKCalendarTableView : UITableView

@property (nonatomic, weak) id<UKCalendarTableViewAgent> agent;

@end
