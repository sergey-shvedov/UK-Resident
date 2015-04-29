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
		if ((nil != [self.week.days objectAtIndex:i]) && (YES == [[self.week.days objectAtIndex:i] isKindOfClass:[NSDate class]]))
		{
			NSInteger day = [(NSDate *)[self.week.days objectAtIndex:i] dayComponent];
			[(UIButton *)[buttons objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%li", (long)day] forState:UIControlStateNormal];
		}
		else
		{
			[(UIButton *)[buttons objectAtIndex:i] setTitle:@"" forState:UIControlStateNormal];
		}
	}
	
}
@end
