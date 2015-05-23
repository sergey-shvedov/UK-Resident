//
//  UKTripFormTableViewController.m
//  UK Resident
//
//  Created by Sergey Shvedov on 02.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKTripFormTableViewController.h"
#import "TripFormStartDateVC.h"
#import "TripFormEndDateVC.h"
#import "TripFormDestinationVC.h"
#import "TripFormAttachmentVC.h"
#import "NSDate+UKResident.h"
#import "UIColor+UKResident.h"

@interface UKTripFormTableViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *startDateFormCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *endDateFormCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *destinationFormCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *attachmentFormCell;

@property (strong,nonatomic) UIImage *disclosureYellow;
@property (strong,nonatomic) UIImage *disclosureGrey;

@end

@implementation UKTripFormTableViewController

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self updateUI];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	//Hidden navigation bar separator
//	if ([self.navigationController.navigationBar isKindOfClass:[UINavigationBar class]]) {
//		
//		UINavigationBar *navigationBar=self.navigationController.navigationBar;
//		[navigationBar setBackgroundImage:[UIImage new]
//						   forBarPosition:UIBarPositionAny
//							   barMetrics:UIBarMetricsDefault];
//		navigationBar.shadowImage=[UIImage imageNamed:@"barButtonShadowWhiteImage"];
//	}
//	//Hidde Cells here...
//	
//
	
//	//Settings for editing trip
//	self.disclosureYellow = [UIImage imageNamed:@"disclosure_yellow"];
//	self.disclosureGrey = [UIImage imageNamed:@"disclosure_grey"];
}

- (UIImage *)disclosureGrey
{
	if (nil == _disclosureGrey)
	{
		_disclosureGrey = [UIImage imageNamed:@"disclosure_grey"];
	}
	return _disclosureGrey;
}

- (UIImage *)disclosureYellow
{
	if (nil == _disclosureYellow)
	{
		_disclosureYellow = [UIImage imageNamed:@"disclosure_yellow"];
	}
	return _disclosureYellow;
}

- (void)updateUI
{
	//Buttons
	[self.delegate changeNeedEditStatusTo:self.editingTrip.isNeedToEdit];
	[self.delegate appearButtons];
	
	//startDateFormCell
	self.startDateFormCell.detailTextLabel.text = [self.editingTrip.startDate localizedStringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
	if (self.editingTrip.isStartDateNeedEdit)
	{
		self.startDateFormCell.detailTextLabel.textColor=[UIColor colorNeedEdit];
		self.startDateFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureYellow];
	}
	else if (self.editingTrip.isStartDateEdited)
	{
		self.startDateFormCell.detailTextLabel.textColor=[UIColor colorEdited];
		self.startDateFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
	}
	else
	{
		self.startDateFormCell.detailTextLabel.textColor=[UIColor colorNotYetEdit];
		self.startDateFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
	}
	
	//endDateFormCell
	self.endDateFormCell.detailTextLabel.text = [self.editingTrip.endDate localizedStringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
	if (self.editingTrip.isEndDateNeedEdit)
	{
		self.endDateFormCell.detailTextLabel.textColor=[UIColor colorNeedEdit];
		self.endDateFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureYellow];
	}
	else if (self.editingTrip.isEndDateEdited)
	{
		self.endDateFormCell.detailTextLabel.textColor=[UIColor colorEdited];
		self.endDateFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
	}
	else
	{
		self.endDateFormCell.detailTextLabel.textColor=[UIColor colorNotYetEdit];
		self.endDateFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
	}
	
	//Destination
	self.destinationFormCell.detailTextLabel.text = self.editingTrip.destination;
	if (self.editingTrip.isDestinationNeedEdit)
	{
		self.destinationFormCell.detailTextLabel.textColor=[UIColor colorNeedEdit];
		self.destinationFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureYellow];
	}
	else if (self.editingTrip.isDestinationEdited)
	{
		self.destinationFormCell.detailTextLabel.textColor=[UIColor colorEdited];
		self.destinationFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
	}
	else
	{
		self.destinationFormCell.detailTextLabel.textColor=[UIColor colorNotYetEdit];
		self.destinationFormCell.accessoryView=[[UIImageView alloc] initWithImage: self.disclosureGrey];
	}

	// TODO: Attachment
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	[self.delegate dismissButtons];
	
	if ([segue.identifier isEqualToString:@"Trip StartDate Form"])
	{
		if ([segue.destinationViewController isKindOfClass:[TripFormStartDateVC class]])
		{
			TripFormStartDateVC *tfedVC = (TripFormStartDateVC *)segue.destinationViewController;
			tfedVC.editingTrip = self.editingTrip;
			[self.delegate dismissButtons];
		}
	}
	else if ([segue.identifier isEqualToString:@"Trip EndDate Form"])
	{
		if ([segue.destinationViewController isKindOfClass:[TripFormEndDateVC class]])
		{
			TripFormEndDateVC *tfodVC = (TripFormEndDateVC *)segue.destinationViewController;
			tfodVC.editingTrip = self.editingTrip;
			[self.delegate dismissButtons];
		}
	}
	else if ([segue.identifier isEqualToString:@"Trip Destination Form"])
	{
		if ([segue.destinationViewController isKindOfClass:[TripFormDestinationVC class]])
		{
			TripFormDestinationVC *tfodVC = (TripFormDestinationVC *)segue.destinationViewController;
			tfodVC.editingTrip = self.editingTrip;
			[self.delegate dismissButtons];
		}
	}
	else if ([segue.identifier isEqualToString:@"Trip Attachment Form"])
	{
		if ([segue.destinationViewController isKindOfClass:[TripFormAttachmentVC class]])
		{
			TripFormAttachmentVC *tfaVC = (TripFormAttachmentVC *)segue.destinationViewController;
			tfaVC.editingTrip = self.editingTrip;
			[self.delegate dismissButtons];
		}
	}
	
}

@end
