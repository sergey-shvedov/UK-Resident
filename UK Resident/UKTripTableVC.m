//
//  UKTripTableVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKTripTableVC.h"
#import "UKTripAddFormViewController.h"
#import "Trip.h"
#import "NSDate+UKResident.h"
#import "NSString+UKResident.h"

@implementation UKTripTableVC

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
	_managedObjectContext = managedObjectContext;
	
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Trip"];
	request.predicate = nil;
	request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:NO selector:@selector(compare:)]];
	
	self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}

#pragma mark - Deselecting
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	if ([self.tableView indexPathForSelectedRow])
	{
		[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Trip Cell"];
	
	if (nil != cell)
	{
		Trip *trip=[self.fetchedResultsController objectAtIndexPath:indexPath];
		cell.textLabel.text = trip.destination;
		NSInteger tripDays = [trip.startDate numberOfDaysUntil:trip.endDate];
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ — %@ (%ld %@)",
									 [trip.startDate localizedStringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle],
									 [trip.endDate localizedStringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle],
									 tripDays,
									 [NSString russianStringFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:tripDays]];
	}
	
	
	return cell;
}

#pragma mark - Preparing for Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([sender isKindOfClass:[UITableViewCell class]])
	{
		NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
		if ([segue.identifier isEqualToString:@"Edit Trip"])
		{
			if ([segue.destinationViewController isKindOfClass:[UKTripAddFormViewController class]])
			{
				[self prepareVC:segue.destinationViewController forSegue:segue.identifier fromIndexPatch:indexPath];
				//NSLog(@"Prepare for UKTripAddFormViewController");
			}
		}
	}
}

- (void)prepareVC:(id)aViewController forSegue:(NSString *)aSegueIdetifier fromIndexPatch:(NSIndexPath *)anIndexPath
{
	Trip *trip =[self.fetchedResultsController objectAtIndexPath:anIndexPath];
	
	if ([aViewController isKindOfClass:[UKTripAddFormViewController class]])
	{
		UKTripAddFormViewController *tripAVC = (UKTripAddFormViewController *)aViewController;
		tripAVC.trip = trip;
		tripAVC.editingTrip = [TempTrip editingTempTripCopyFromTrip:trip];
		tripAVC.managedObjectContext = self.managedObjectContext;
		//tripAVC.userEditingTrip=self.user;
		tripAVC.isCreating = NO;
	}
}

@end
