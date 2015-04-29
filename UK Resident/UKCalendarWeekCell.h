//
//  UKCalendarWeekCell.h
//  UK Resident
//
//  Created by Sergey Shvedov on 27.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UKCalendarWeek;

@interface UKCalendarWeekCell : UITableViewCell

@property (nonatomic, assign) NSInteger mark;
@property (nonatomic, strong) UKCalendarWeek *week;

@end
