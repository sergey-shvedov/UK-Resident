//
//  UKWarningTableVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 17.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKWarningTableVC.h"
#import "UKNotifications.h"
#import "UKWarningTableHeaderView.h"
#import "UKLibraryAPI.h"
#import "WarningTrip.h"
#import "Trip.h"
#import "NSDate+UKResident.h"
#import "NSString+UKResident.h"

typedef NS_ENUM(NSInteger, UKWarningType)
{
	kWarningTypeInvestor = 0,
	kWarningTypeСitizen,
};

@interface UKWarningTableVC ()

@end

@implementation UKWarningTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
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
	[self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

	NSInteger result = 0;
	
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	
	if ([library.warningInvestTrips count]) result++;
	if ([library.warningCitizenTrips count]) result++;
	
    return result;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger result = 0;
	
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	switch ([self warningTypeForSection:section])
	{
		case kWarningTypeInvestor:
			result = [library.warningInvestTrips count];
			break;
		case kWarningTypeСitizen:
			result = [library.warningCitizenTrips count];
			break;
		default:
			break;
	}
	
    return result;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 60.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UKWarningTableHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"UKWarningTableHeaderView" owner:self options:nil] objectAtIndex:0];
	switch ([self warningTypeForSection:section])
	{
		case kWarningTypeInvestor:
			[headerView updateTitle:@"Нарушение требований визы инвестора" andDetails:@"«Отсутствовать не более 180 дней в текущем визовом году»:"];
			break;
			
		case kWarningTypeСitizen:
			[headerView updateTitle:@"Нарушение требований получения гражданства" andDetails:@"«Отсутствовать не более 90 дней в году»:"];
			break;
			
		default:
			break;
	}
	return headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Warning Cell" forIndexPath:indexPath];
    
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	NSArray *array;
	switch ([self warningTypeForSection:indexPath.section])
	{
		case kWarningTypeInvestor:
			array = library.warningInvestTrips;
			break;
		case kWarningTypeСitizen:
			array = library.warningCitizenTrips;
			break;
		default:
			break;
	}
	
	WarningTrip *warningTrip;
	if ([array count] > indexPath.row)
	{
		if ([[array objectAtIndex:indexPath.row] isKindOfClass:[WarningTrip class]])
		{
			warningTrip = (WarningTrip *)[array objectAtIndex:indexPath.row];
		}
	}
	
	if (nil != warningTrip)
	{

		Trip *trip = [library tripWithStartDate:warningTrip.startDate inContext:library.managedObjectContext];
		if (nil != trip)
		{
			NSInteger overDays = 1 + [warningTrip.warningDate numberOfDaysUntil:trip.endDate];
			NSInteger tripDays = 1 + [trip.startDate numberOfDaysUntil:trip.endDate];
			NSString *overDaysString = [NSString stringWithFormat:@"Превышение с %@ на %i %@",
							   [warningTrip.warningDate localizedStringWithDateFormat:@"d MMMM"],
							   (int)overDays,
							   [NSString russianStringFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:overDays]];
			NSString *tripDaysString = [NSString stringWithFormat:@"%@ — %@",
										[trip.startDate localizedStringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle],
										[trip.endDate localizedStringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
			NSString *tripDaysCountString = [NSString stringWithFormat:@"(%i %@)",
											 (int)tripDays,
											 [NSString russianStringFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:tripDays]];
			#pragma unused(tripDaysCountString)
			NSString *title = [NSString stringWithFormat:@"%@: %@", trip.destination, tripDaysString];
			NSString *details = [NSString stringWithFormat:@"%@", overDaysString];
			[cell.textLabel setText:title];
			[cell.detailTextLabel setText:details];
		}
	}
    
    return cell;
}

- (UKWarningType)warningTypeForSection:(NSInteger)aSection
{
	UKWarningType type = kWarningTypeInvestor;
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	
	switch (aSection)
	{
		case 0:
			if (![library.warningInvestTrips count] && [library.warningCitizenTrips count]) type = kWarningTypeСitizen;
			break;
			
		case 1:
			if ([library.warningInvestTrips count] && [library.warningCitizenTrips count]) type = kWarningTypeСitizen;
			break;
			
		default:
			break;
	}
	
	return type;
}

@end
