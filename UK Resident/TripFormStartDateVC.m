//
//  TripFormStartDateVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "TripFormStartDateVC.h"
#import "UKLibraryAPI.h"
#import "NSDate+UKResident.h"

@interface TripFormStartDateVC ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, strong) NSDate *selectedDate;

@end

@implementation TripFormStartDateVC

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	[self.datePicker setCalendar:library.customCalendar];
	
	if (nil == self.editingTrip.startDate)
	{
		self.selectedDate = [[NSDate date] normalization];
	}
	else
	{
		self.selectedDate = self.editingTrip.startDate;
	}
	
	self.datePicker.date = self.selectedDate;
	[self.datePicker addTarget:self action:@selector(updateDate) forControlEvents:UIControlEventValueChanged];
}

- (void)updateDate
{
	self.selectedDate = self.datePicker.date;
}

- (IBAction)okButton:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
	if (NSOrderedDescending == [self.selectedDate compare:self.editingTrip.endDate])
	{
		self.editingTrip.isEndDateNeedEdit = YES;
		self.editingTrip.endDate = [self.selectedDate dateByAddingTimeInterval:+60*60*24];
	}
	self.editingTrip.isStartDateEdited = YES;
	self.editingTrip.isStartDateNeedEdit = NO;
	self.editingTrip.startDate = self.selectedDate;
}

@end
