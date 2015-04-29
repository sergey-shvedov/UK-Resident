//
//  UKCalendarMonthCell.m
//  UK Resident
//
//  Created by Sergey Shvedov on 28.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKCalendarMonthCell.h"
#import "NSDate+UKResident.h"
#import "NSDateFormatter+UKResident.h"

@interface UKCalendarMonthCell ()

@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@end

@implementation UKCalendarMonthCell

- (void)layoutSubviews
{
	NSString *monthTitle = @"";
	if (nil != self.date)
	{
		NSInteger monthOfYear = [self.date monthOfYear];
		monthTitle = [[[NSDateFormatter customDateFormatter] standaloneMonthSymbols] objectAtIndex:(monthOfYear - 1)];
	}
	
	NSString *yearTitle = @"";
	if ((nil != self.date) && (1 == [self.date monthOfYear]))
	{
		yearTitle = [NSString stringWithFormat:@"%li", (long)[self.date yearComponent]];
	}
	
	self.monthLabel.text = monthTitle;
	self.yearLabel.text = yearTitle;
	
								 
	//NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	
	
	//[dateFormatter setDateStyle:NSDA];
	//[dateFormatter setTimeStyle:tstyle];
	//[dateFormatter setCalendar:[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar]];
}

@end
