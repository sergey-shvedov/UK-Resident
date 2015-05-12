//
//  UKTripFormTableViewController.m
//  UK Resident
//
//  Created by Sergey Shvedov on 02.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKTripFormTableViewController.h"
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
#pragma TODO
	//Attachment
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	[self.delegate dismissButtons];
	
//	if ([segue.identifier isEqualToString:@"Passport IssueDate Form"]) {
//		if ([segue.destinationViewController isKindOfClass:[PassportFormIssueDateVC class]]) {
//			PassportFormIssueDateVC *pfidVC=(PassportFormIssueDateVC *)segue.destinationViewController;
//			pfidVC.editingPassport=self.editingPassport;
//			[self.passportaddvc dismissButtons];
//		}
//	}
//	
//	
//	if ([segue.identifier isEqualToString:@"Passport ExperationDate Form"]) {
//		if ([segue.destinationViewController isKindOfClass:[PassportFormExperationDateVC class]]) {
//			PassportFormExperationDateVC *pfedVC=(PassportFormExperationDateVC *)segue.destinationViewController;
//			pfedVC.editingPassport=self.editingPassport;
//			
//			[self.passportaddvc dismissButtons];
//		}
//	}
//	
//	if ([segue.identifier isEqualToString:@"Passport Type Form"]) {
//		if ([segue.destinationViewController isKindOfClass:[PassportFormTypeVC class]]) {
//			PassportFormTypeVC *pftVC=(PassportFormTypeVC *)segue.destinationViewController;
//			pftVC.editingPassport=self.editingPassport;
//			[self.passportaddvc dismissButtons];
//		}
//	}
}

@end
