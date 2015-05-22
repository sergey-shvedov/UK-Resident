//
//  UKReportTopCVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 29.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKReportTopCVC.h"
#import "UKReportTopDiagramVC.h"
#import "UKReportTopInitialDatePopoverVC.h"
#import "GraphRoundView.h"
#import "UKLibraryAPI.h"
#import "NSUserDefaults+AccessoryMethods.h"
#import "NSDate+UKResident.h"
#import "UIColor+UKResident.h"
#import "NSString+UKResident.h"
#import "NSDateFormatter+UKResident.h"

@interface UKReportTopCVC ()

@property (nonatomic, weak) UKReportTopDiagramVC *diagramVC;
@property (weak, nonatomic) IBOutlet UIView *initialBigArrowView;
@property (weak, nonatomic) IBOutlet UIView *generalGraphView;
@property (weak, nonatomic) IBOutlet UILabel *generalGraphReplaceLabel;
@property (weak, nonatomic) IBOutlet UIView *topMonthLabelsView;


@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UIButton *initialDateButton;

@property (weak, nonatomic) IBOutlet UIView *leftGraphView;
@property (weak, nonatomic) IBOutlet UILabel *leftNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftTextLabel;

@property (weak, nonatomic) IBOutlet UIView *rightGraphView;
@property (weak, nonatomic) IBOutlet UILabel *rightNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTextLabel;

@property (nonatomic, strong) NSDate *initialDate;

@end

@implementation UKReportTopCVC

- (void)viewDidLoad
{
	CGFloat xPoint = 32;
	CGFloat xDelta = 43;
	for (int i = 0; i < 12; i++)
	{
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xPoint + i * xDelta, 0., xDelta, 20)];
		[label setTextColor:[UIColor whiteColor]];
		[label setFont:[UIFont systemFontOfSize:10]];
		[label setText:[[[NSDateFormatter customDateFormatter] shortStandaloneMonthSymbols] objectAtIndex:i]];
		[label setTextAlignment:NSTextAlignmentCenter];
		[self.topMonthLabelsView addSubview:label];
	}
	//[self.monthLabel setText:[self.date localizedStringWithDateFormat:@"MMMM"]];
	
}

- (void)setDate:(NSDate *)date
{
	_date = date;
	[self.diagramVC setDate:self.date];
	[self updateUI];
}

- (void)setInitialDate:(NSDate *)initialDate
{
	[UKLibraryAPI sharedInstance].currentInitDate = initialDate;
	[self.diagramVC setInitialDate:self.initialDate];
}

- (NSDate *)initialDate
{
	return [UKLibraryAPI sharedInstance].currentInitDate;
}

- (void)updateUI
{
	if (NO == [UKLibraryAPI sharedInstance].isInitDateSetted)
	{
		[self.diagramVC.view setHidden:YES];
		[self.topMonthLabelsView setHidden:YES];
		[self.initialBigArrowView setHidden:NO];
		[self.generalGraphView setHidden:YES];
		[self.generalGraphReplaceLabel setHidden:YES];
		[self.initialDateButton setTintColor:[UIColor colorInitialButton]];
		[self.initialDateButton setTitleColor:[UIColor colorInitialButton] forState:UIControlStateNormal];
	}
	else
	{
		[self.diagramVC.view setHidden:NO];
		[self.topMonthLabelsView setHidden:NO];
		if (NO == [self.diagramVC.initialDate isTheSameDayWith:self.initialDate])
		{
			self.diagramVC.initialDate = self.initialDate;
		}
		
		[self.initialBigArrowView setHidden:YES];
		[self.initialDateButton setTintColor:[UIColor colorInitialButtonSetted]];
		[self.initialDateButton setTitleColor:[UIColor colorInitialButtonSetted] forState:UIControlStateNormal];
		if ((NSOrderedAscending == [self.initialDate compare:self.date]) && (NSOrderedAscending == [self.date compare:[self.initialDate moveYear:5]]))
		{
			[self.generalGraphView setHidden:NO];
			[self.generalGraphReplaceLabel setHidden:YES];
			[self updateGraphs];
		}
		else
		{
			[self.generalGraphView setHidden:YES];
			[self.generalGraphReplaceLabel setHidden:NO];
		}
	}
	[self.dayLabel setText:[self.date localizedStringWithDateFormat:@"d"]];
	[self.monthLabel setText:[self.date localizedStringWithDateFormat:@"MMMM"]];
	[self.yearLabel setText:[self.date localizedStringWithDateFormat:@"YYYY"]];
}

- (void)updateGraphs
{
	[self.leftGraphView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
	[self.rightGraphView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
	
	//LeftGraphView
	NSArray *leftDaysArray = [self daysForLeftGraph];
	float leftTripDays = 0;
	float leftDays = 1;
	if (2 == [leftDaysArray count])
	{
		leftTripDays = [((NSNumber *)[leftDaysArray firstObject]) floatValue];
		leftDays = [((NSNumber *)[leftDaysArray lastObject]) floatValue];
	}
	
	GraphRoundView *leftGraphView = [[GraphRoundView alloc] initWithSegment:leftTripDays/leftDays withFrame:CGRectMake(0., 0., 56, 56) withBackgrondColor:[UIColor colorLeftGraphBackground] andMainColor:[UIColor colorLeftGraphMain]];
	[self.leftGraphView addSubview:leftGraphView];
	
	[self.leftNumberLabel setText:[NSString stringWithFormat:@"%i%%", (int)(100 * leftTripDays / leftDays)]];
	[self.leftTextLabel setText:[NSString stringWithFormat:@"За текущий визовый год %i из %i %@ \nпроведены за пределами UK", (int)leftTripDays, (int)leftDays, [NSString russianStringFor1:@"дня" for2to4:@"дней" for5up:@"дней" withValue:leftDays]]];
	
	//RightGraphView
	NSArray *rightDaysArray = [self daysForRightGraph];
	float rightTripDays = 0;
	float rightDays = 1;
	if (2 == [rightDaysArray count])
	{
		rightTripDays = [((NSNumber *)[rightDaysArray firstObject]) floatValue];
		rightDays = [((NSNumber *)[rightDaysArray lastObject]) floatValue];
	}
	GraphRoundView *rightGraphView = [[GraphRoundView alloc] initWithSegment:rightTripDays/rightDays withFrame:CGRectMake(0., 0., 56, 56) withBackgrondColor:[UIColor colorRightGraphBackground] andMainColor:[UIColor colorRightGraphMain]];
	[self.rightGraphView addSubview:rightGraphView];
	
	[self.rightNumberLabel setText:[NSString stringWithFormat:@"%i%%", (int)(100 * rightTripDays / rightDays)]];
	[self.rightTextLabel setText:[NSString stringWithFormat:@"С даты начала учета %i из %i %@ \nпроведены в UK", (int)rightTripDays, (int)rightDays, [NSString russianStringFor1:@"дня" for2to4:@"дней" for5up:@"дней" withValue:rightDays]]];
}

- (NSArray *)daysForLeftGraph
{
	NSDate *startDate = [[self.date moveYear: -1] moveDay: +1];
	if (NSOrderedAscending == [startDate compare:self.initialDate])
	{
		startDate = self.initialDate;
	}
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	NSInteger days = [startDate numberOfDaysBetween:self.date includedBorderDates:YES];
	NSInteger tripDays = [library numberOfTripDaysBetweenStartDate:startDate andEndDate:self.date andCountArrivalAndDepartureDays:[NSUserDefaults standardUserDefaults].displayBoundaryDatesStatus inContext:library.managedObjectContext];
	return @[[NSNumber numberWithInteger:tripDays], [NSNumber numberWithInteger:days]];
}

- (NSArray *)daysForRightGraph
{
	NSDate *startDate = self.initialDate;

	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	NSInteger days = [startDate numberOfDaysBetween:self.date includedBorderDates:YES];
	NSInteger tripDays = [library numberOfTripDaysBetweenStartDate:startDate andEndDate:self.date andCountArrivalAndDepartureDays:[NSUserDefaults standardUserDefaults].displayBoundaryDatesStatus inContext:library.managedObjectContext];
	return @[[NSNumber numberWithInteger:(days - tripDays)], [NSNumber numberWithInteger:days]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"ReportDiagramVC"])
	{
		if ([[segue destinationViewController] isKindOfClass:[UKReportTopDiagramVC class]])
		{
			UKReportTopDiagramVC *reportTopDiagramVC = (UKReportTopDiagramVC *)[segue destinationViewController];
			self.diagramVC = reportTopDiagramVC;
		}
	}
	else if ([segue.identifier isEqualToString:@"Initial Date Popover"])
	{
		if ([[segue destinationViewController] isKindOfClass:[UKReportTopInitialDatePopoverVC class]])
		{
			UKReportTopInitialDatePopoverVC *popover = (UKReportTopInitialDatePopoverVC *)[segue destinationViewController];
			popover.initialDate = (self.initialDate != nil) ? self.initialDate : [NSDate date];
		}
	}
}

- (IBAction)popoverApplied:(UIStoryboardSegue *)segue
{
	if ([segue.identifier isEqualToString:@"Unwind To ReportTop"])
	{
		UKReportTopInitialDatePopoverVC *popover = (UKReportTopInitialDatePopoverVC *)[segue sourceViewController];
		self.initialDate = popover.initialDate;
		UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
		library.isInitDateSetted = YES;
		[self updateUI];
	}
}

@end
