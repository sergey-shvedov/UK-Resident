//
//  UKCalendarWeekCell.m
//  UK Resident
//
//  Created by Sergey Shvedov on 27.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKCalendarWeekCell.h"
#import "UKCalendarWeek.h"
#import "NSDate+UKResident.h"
#import "UIButton+UKRecord.h"
#import "UIColor+UKResident.h"

@interface UKCalendarWeekCell()

@property (weak, nonatomic) IBOutlet UIButton *day01;
@property (weak, nonatomic) IBOutlet UIButton *day02;
@property (weak, nonatomic) IBOutlet UIButton *day03;
@property (weak, nonatomic) IBOutlet UIButton *day04;
@property (weak, nonatomic) IBOutlet UIButton *day05;
@property (weak, nonatomic) IBOutlet UIButton *day06;
@property (weak, nonatomic) IBOutlet UIButton *day07;

@end

@implementation UKCalendarWeekCell

- (void)layoutSubviews
{
	NSArray *buttons = @[self.day01, self.day02, self.day03, self.day04, self.day05, self.day06, self.day07];
	//[self.day01 setTitle:[NSString stringWithFormat:@"%i", (int)self.mark] forState:UIControlStateNormal];
	for (int i = 0 ; i < 7; i++)
	{
		UIButton *button = (UIButton *)[buttons objectAtIndex:i];
		BOOL isToday = NO;
		
		if ((nil != [self.week.days objectAtIndex:i]) && (YES == [[self.week.days objectAtIndex:i] isKindOfClass:[NSDate class]]))
		{
			NSDate *date = (NSDate *)[self.week.days objectAtIndex:i];
			[button setButtonDate:date];
			NSInteger day = [date dayComponent];
			[button setTitle:[NSString stringWithFormat:@"%li", (long)day] forState:UIControlStateNormal];
			[button setHidden:NO];
			
			if (YES == [date isToday])
			{
				isToday = YES;
				[button setBackgroundImage:[UIImage imageNamed:@"calendarCellToday"] forState:UIControlStateNormal];
				[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
			}
			else
			{
				[button setBackgroundImage:nil forState:UIControlStateNormal];
				[button setTitleColor:( (i > 4) ? [UIColor colorCalendarWeekend] : [UIColor colorCalendarWorkDay] ) forState:UIControlStateNormal];
			}
		}
		else
		{
			[button setButtonDate:nil];
			[button setTitle:@"" forState:UIControlStateNormal];
			[button setBackgroundImage:nil forState:UIControlStateNormal];
			[button setHidden:YES];
		}
		
		if ( (nil != [self.week.tripDays objectAtIndex:i]) && (YES == [[self.week.tripDays objectAtIndex:i] isKindOfClass:[NSNumber class]]) )
		{
			if (YES == isToday)
			{
				[button setBackgroundImage:[UIImage imageNamed:@"calendarCellTodayTripLine"] forState:UIControlStateNormal];
			}
			else
			{
				[button setBackgroundImage:[UIImage imageNamed:@"calendarCellTripLine"] forState:UIControlStateNormal];
			}
		}
	}
}
@end
