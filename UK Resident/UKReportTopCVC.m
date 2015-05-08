//
//  UKReportTopCVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 29.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKReportTopCVC.h"
#import "UKReportTopDiagramVC.h"
#import "GraphRoundView.h"
#import "NSDate+UKResident.h"
#import "UIColor+UKResident.h"

@interface UKReportTopCVC ()

@property (nonatomic, weak) UKReportTopDiagramVC *diagramVC;

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@property (weak, nonatomic) IBOutlet UIView *leftGraphView;
@property (weak, nonatomic) IBOutlet UIView *rightGraphView;

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
	
	[self updateGraphs];
}

- (void)updateGraphs
{
	[self.leftGraphView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
	[self.rightGraphView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
	
	GraphRoundView *leftGraphView = [[GraphRoundView alloc] initWithSegment:[self.date dayComponent]/31. withFrame:CGRectMake(0., 0., 56, 56) withBackgrondColor:[UIColor colorLeftGraphBackground] andMainColor:[UIColor colorLeftGraphMain]];
	[self.leftGraphView addSubview:leftGraphView];
	
	GraphRoundView *rightGraphView = [[GraphRoundView alloc] initWithSegment:(1-[self.date dayComponent]/31.) withFrame:CGRectMake(0., 0., 56, 56) withBackgrondColor:[UIColor colorRightGraphBackground] andMainColor:[UIColor colorRightGraphMain]];
	[self.rightGraphView addSubview:rightGraphView];
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
