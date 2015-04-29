//
//  UKCalendarTableViewController.m
//  UK Resident
//
//  Created by Sergey Shvedov on 26.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKCalendarTableViewController.h"
#import "UKCalendarWeekCell.h"
#import "UKCalendarMonthCell.h"
#import "UKCalendarTableView.h"
#import "NSDate+UKResident.h"
#import "UKCalendarWeek.h"

@interface UKCalendarTableViewController () <UKCalendarTableViewAgent>

@property (strong, nonatomic) IBOutlet UKCalendarTableView *calendarTableView;

@property (nonatomic, assign) NSInteger currentCenter;
@property (nonatomic, strong) NSDate *todayDate;
@property (nonatomic, assign) NSInteger topYear;

@end

@implementation UKCalendarTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.calendarTableView.agent = self;
	self.todayDate = [[NSDate date] normalization];
	self.topYear = [self.todayDate yearComponent];
	self.currentCenter = -45;
}

- (void)setTopYear:(NSInteger)topYear
{
	_topYear = topYear;
	
	NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:topYear] forKey:@"topYear"];
	[[NSNotificationCenter defaultCenter] postNotificationName: @"TopYearChangedNotification" object:nil userInfo:userInfo];
}

- (void)calendarTableViewWillRecenterTo:(NSInteger)aRowNumber
{
	self.currentCenter -= aRowNumber;
}

- (IBAction)tappedButton:(id)sender
{
	if (YES == [sender isKindOfClass:[UIButton class]])
	{
		
	}
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    // Return the number of rows in the section.
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = nil;
	
	NSInteger todayMonthDelta = -[self.todayDate weekOfMonth];
	NSInteger searchMonth = (int)(indexPath.row + self.currentCenter + todayMonthDelta) / 7;
	NSInteger searchWeek = ((int)(indexPath.row + self.currentCenter + todayMonthDelta) % 7);
	if (searchWeek < 0)
	{
		searchWeek = 7 + searchWeek;
		searchMonth -= 1;
	}
	if (0 == searchWeek)
	{
		cell = [tableView dequeueReusableCellWithIdentifier:@"Month Cell" forIndexPath:indexPath];
		((UKCalendarMonthCell *)cell).date = [self.todayDate moveMonth:searchMonth];
	}
	else
	{
		cell = [tableView dequeueReusableCellWithIdentifier:@"Week Cell" forIndexPath:indexPath];
		
		((UKCalendarWeekCell *)cell).mark = (int)(indexPath.row + self.currentCenter);
		//UKCalendarWeek *week = [[UKCalendarWeek alloc] initWithWeekDelta:(searchMonth * 6 + searchWeek) fromDate:self.todayDate];
		UKCalendarWeek *week = [[UKCalendarWeek alloc] initWithMonthDelta:searchMonth andWeekOfMonth:searchWeek fromDate:self.todayDate];
		((UKCalendarWeekCell *)cell).week = week;
	}

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (YES == [cell isKindOfClass:[UKCalendarMonthCell class]])
	{
		UKCalendarMonthCell *tempCell = (UKCalendarMonthCell *)cell;
		NSDate *tempDate = tempCell.date;
		if ((1 == [tempDate monthComponent]) && (self.topYear == [tempDate yearComponent] || 0 == self.topYear))
		{
			self.topYear = [tempDate yearComponent] - 1;
		}
	}
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (YES == [cell isKindOfClass:[UKCalendarMonthCell class]])
	{
		UKCalendarMonthCell *tempCell = (UKCalendarMonthCell *)cell;
		NSDate *tempDate = tempCell.date;
		NSIndexPath *firstVisibleIndexPath = [[self.tableView indexPathsForVisibleRows] objectAtIndex:0];
		if (1 == [tempDate monthComponent])
		{
			if (indexPath.row < firstVisibleIndexPath.row)
			{
				self.topYear = [tempDate yearComponent];
			}
		}
	}
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
