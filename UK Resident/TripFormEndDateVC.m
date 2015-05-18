//
//  TripFormEndDateVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "TripFormEndDateVC.h"
#import "UKLibraryAPI.h"
#import "NSDate+UKResident.h"

@interface TripFormEndDateVC ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, strong) NSDate *selectedDate;

@end

@implementation TripFormEndDateVC

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	[self.datePicker setCalendar:library.customCalendar];
	
	if (nil == self.editingTrip.endDate)
	{
		self.selectedDate = [[NSDate date] normalization];
	}
	else
	{
		self.selectedDate = self.editingTrip.endDate;
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
	if (NSOrderedAscending == [self.selectedDate compare:self.editingTrip.startDate])
	{
		self.editingTrip.isStartDateNeedEdit = YES;
		self.editingTrip.startDate = [self.selectedDate dateByAddingTimeInterval:-60*60*24];
	}
	self.editingTrip.isEndDateEdited = YES;
	self.editingTrip.isEndDateNeedEdit = NO;
	self.editingTrip.endDate = self.selectedDate;
}

@end
