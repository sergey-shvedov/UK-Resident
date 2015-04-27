//
//  UKCalendarWeekCell.m
//  UK Resident
//
//  Created by Sergey Shvedov on 27.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKCalendarWeekCell.h"

@interface UKCalendarWeekCell()

@property (weak, nonatomic) IBOutlet UIButton *day01;

@end

@implementation UKCalendarWeekCell

- (void)layoutSubviews
{
	[self.day01 setTitle:[NSString stringWithFormat:@"%i", (int)self.mark] forState:UIControlStateNormal];
	
}
@end
