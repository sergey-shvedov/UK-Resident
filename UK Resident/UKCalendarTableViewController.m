//
//  UKCalendarTableViewController.m
//  UK Resident
//
//  Created by Sergey Shvedov on 26.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKCalendarTableViewController.h"
#import "UKCalendarWeekCell.h"
#import "UKCalendarTableView.h"

@interface UKCalendarTableViewController () <UKCalendarTableViewAgent>

@property (strong, nonatomic) IBOutlet UKCalendarTableView *calendarTableView;

@property (nonatomic, assign) NSInteger currentCenter;

@end

@implementation UKCalendarTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.calendarTableView.agent = self;
	self.currentCenter = -50;
}

- (void)calendarTableViewWillRecenterTo:(NSInteger)aRowNumber
{
	self.currentCenter -= aRowNumber;
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
    UKCalendarWeekCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Week Cell" forIndexPath:indexPath];
	cell.mark = (int)(indexPath.row + self.currentCenter);
    return cell;
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
