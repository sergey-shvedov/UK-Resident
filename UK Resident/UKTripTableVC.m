//
//  UKTripTableVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKTripTableVC.h"
#import "UKLibraryAPI.h"
#import "UKTripAddFormViewController.h"
#import "Trip.h"
#import "NSDate+UKResident.h"
#import "NSString+UKResident.h"
#import "NSDateFormatter+UKResident.h"
#import "UKNotifications.h"

@implementation UKTripTableVC

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
	_managedObjectContext = managedObjectContext;
	
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Trip"];
	request.predicate = [NSPredicate predicateWithFormat:@"ANY tripsByUser.whoTravel == %@", library.currentUser];
	request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:NO selector:@selector(compare:)]];
	
	self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center addObserver:self selector: @selector(updateUI) name: UKNotificationNeedUpdateUI object: nil];
}

- (void)dealloc
{
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center removeObserver:self];
}

- (void)updateUI
{
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Trip"];
	request.predicate = [NSPredicate predicateWithFormat:@"ANY tripsByUser.whoTravel == %@", library.currentUser];
	request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:NO selector:@selector(compare:)]];
	
	self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
	
	[self.tableView reloadData];
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
		
		NSInteger startMonthOfYear = [trip.startDate monthOfYear];
		NSInteger endMonthOfYear = [trip.endDate monthOfYear];
		
		NSString *monthTitle;
		if (startMonthOfYear != endMonthOfYear)
		{
			monthTitle = [NSString stringWithFormat: @"%@ — %@ %i",[[[NSDateFormatter customDateFormatter] standaloneMonthSymbols] objectAtIndex:(startMonthOfYear - 1)], [[[NSDateFormatter customDateFormatter] standaloneMonthSymbols] objectAtIndex:(endMonthOfYear - 1)], (int)[trip.endDate yearComponent]];
		}
		else
		{
			monthTitle = [NSString stringWithFormat: @"%@ %i",[[[NSDateFormatter customDateFormatter] standaloneMonthSymbols] objectAtIndex:(startMonthOfYear - 1)], (int)[trip.startDate yearComponent]];
		}

		cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", trip.destination, monthTitle];
		
		NSInteger tripDays = 1 + [trip.startDate numberOfDaysUntil:trip.endDate];
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ — %@ (%i %@)",
									 [trip.startDate localizedStringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle],
									 [trip.endDate localizedStringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle],
									 (int)tripDays,
									 [NSString russianStringFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:tripDays]];
		if (NSOrderedAscending == [[NSDate date] compare:trip.startDate])
		{
			[cell.imageView setImage:[UIImage imageNamed:@"tripTablePlaneUp"]];
		}
		else if (NSOrderedAscending == [trip.endDate compare:[NSDate date]])
		{
			[cell.imageView setImage:[UIImage imageNamed:@"tripTablePlaneDown"]];
		}
		else
		{
			[cell.imageView setImage:[UIImage imageNamed:@"tripTablePlaneHorizontal"]];
		}
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
