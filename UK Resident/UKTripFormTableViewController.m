//
//  UKTripFormTableViewController.m
//  UK Resident
//
//  Created by Sergey Shvedov on 02.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKTripFormTableViewController.h"

@implementation UKTripFormTableViewController

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self updateUI];
}

- (void)updateUI
{
	[self.delegate appearButtons];
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
