//
//  UKReportViewController.m
//  UK Resident
//
//  Created by Sergey Shvedov on 29.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKReportViewController.h"
#import "UKReportTopCVC.h"
#import "UKReportCenterCVC.h"
#import "UKReportBottomCVC.h"

@interface UKReportViewController ()

@end

@implementation UKReportViewController

- (void)setDate:(NSDate *)date
{
	_date = date;
	[self updateUI];
}

- (void)updateUI
{
	
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"ReportTopCVC"])
	{
		UKReportTopCVC *reportTopCVC=(UKReportTopCVC *)[segue destinationViewController];
	}
	else if ([segue.identifier isEqualToString:@"ReportCenterCVC"])
	{
		UKReportCenterCVC *reportCenterCVC=(UKReportCenterCVC *)[segue destinationViewController];
	}
	else if ([segue.identifier isEqualToString:@"ReportBottomCVC"])
	{
		UKReportBottomCVC *reportBotomCVC=(UKReportBottomCVC *)[segue destinationViewController];
	}	
}

@end
