//
//  UKReportTopCVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 29.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKReportTopCVC.h"
#import "UKReportTopDiagramVC.h"
#import "NSDate+UKResident.h"

@interface UKReportTopCVC ()

@property (nonatomic, weak) UKReportTopDiagramVC *diagramVC;

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@end

@implementation UKReportTopCVC

- (void)viewDidLoad
{
	self.date = [NSDate date];
}

- (void)setDate:(NSDate *)date
{
	_date = date;
	[self updateUI];
}

- (void)updateUI
{
	[self.diagramVC setDate:self.date];
	
	[self.dayLabel setText:[self.date localizedStringWithDateFormat:@"d"]];
	[self.monthLabel setText:[self.date localizedStringWithDateFormat:@"MMMM"]];
	[self.yearLabel setText:[self.date localizedStringWithDateFormat:@"YYYY"]];
	
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"ReportDiagramVC"])
	{
		UKReportTopDiagramVC *reportTopDiagramVC = (UKReportTopDiagramVC *)[segue destinationViewController];
		self.diagramVC = reportTopDiagramVC;
	}
}

@end
