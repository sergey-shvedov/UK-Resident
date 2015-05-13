//
//  UKReportTopInitialDatePopoverVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 13.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKReportTopInitialDatePopoverVC.h"

@interface UKReportTopInitialDatePopoverVC ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation UKReportTopInitialDatePopoverVC

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self.datePicker setDate:self.initialDate];
}

- (IBAction)applyButton:(id)sender
{
	self.initialDate = self.datePicker.date;
}

@end
