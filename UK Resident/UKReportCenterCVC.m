//
//  UKReportCenterCVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 29.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKReportCenterCVC.h"
#import "UKLibraryAPI.h"
#import "UKReportCenterMainView.h"
#import "NSUserDefaults+AccessoryMethods.h"
#import "NSDate+UKResident.h"
#import "NSString+UKResident.h"

@interface UKReportCenterCVC ()<UKReportCenterMainViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UKReportCenterMainView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIView *shortVersion;
@property (weak, nonatomic) IBOutlet UIView *fullVersion;

@property (weak, nonatomic) IBOutlet UILabel *firstShortDaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstShortDescriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *firstFullDaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstFullWordDaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstFullDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstFullTripDatesLabel;

@property (weak, nonatomic) IBOutlet UIStepper *fullBlock2Stepper;
@property (weak, nonatomic) IBOutlet UILabel *fullBlock2StepperLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondFullDayDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondFullMonthDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondFullDescriptionLabel;


@end

@implementation UKReportCenterCVC

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self.fullVersion setAlpha:0.];
	[self.shortVersion setAlpha:0.];
	self.mainView.delegate = self;
}

- (void)mainView:(UKReportCenterMainView *)aMainView layoutToFullVersion:(BOOL)isFullVersion
{
	if (YES == isFullVersion)
	{
		[UIView animateWithDuration:1.0 animations:^{
			[self.fullVersion setAlpha:1.];
			[self.shortVersion setAlpha:0.];
			[self.fullVersion setHidden:NO];
			[self.shortVersion setHidden:NO];
		}];
	}
	else
	{
		[UIView animateWithDuration:1.0 animations:^{
			[self.fullVersion setAlpha:0.];
			[self.shortVersion setAlpha:1.];
			[self.fullVersion setHidden:NO];
			[self.shortVersion setHidden:NO];
		}];
	}
}

- (void)setDate:(NSDate *)date
{
	_date = date;
	[self updateUI];
}

- (void)updateUI
{
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	if (NO == library.isInitDateSetted)
	{
		[self.mainView setHidden:YES];
		[self.segment setHidden:YES];
		[self.imageView setHidden:NO];
		[self.imageView setImage:[UIImage imageNamed:@"reportCenterImageUninitial"]];
	}
	else
	{
		if ((NSOrderedAscending == [library.currentInitDate compare:self.date]) && (NSOrderedAscending == [self.date compare:[library.currentInitDate moveYear:5]]))
		{
			[self.mainView setHidden:NO];
			[self.segment setHidden:NO];
			[self.imageView setHidden:YES];
			[self updateСalculatedData];
		}
		else
		{
			[self.mainView setHidden:YES];
			[self.segment setHidden:YES];
			[self.imageView setHidden:NO];
			[self.imageView setImage:[UIImage imageNamed:@"reportCenterImageOutBorders"]];
		}
	}
}

- (void)updateСalculatedData
{
	
	
	switch ([NSUserDefaults standardUserDefaults].displayCheckType)
	{
		case kUKRecentCheckTypeInvestor:
			[self.segment setSelectedSegmentIndex:kUKRecentCheckTypeInvestor];
			[self updateInvestData];
			break;
			
		case kUKRecentCheckTypeСitizen:
			[self.segment setSelectedSegmentIndex:kUKRecentCheckTypeСitizen];
			[self updateСitizenData];
			break;
			
		default:
			break;
	}
}

- (void)updateInvestData
{
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	NSInteger delta = [NSUserDefaults standardUserDefaults].displayBoundaryDatesStatus ? -1 : +1;
	NSInteger ligalInvestDays = [library numberOfLigalInvestDaysFromDate:self.date withBoundaryDatesStatus:[NSUserDefaults standardUserDefaults].displayBoundaryDatesStatus inContext:library.managedObjectContext];
	NSString *firstDescription = [NSString stringWithFormat:@"С %@ можно совершить поездку\nдо %@ (на %i %@).",
								  [self.date localizedStringWithDateFormat:@"d MMMM"],
								  [[self.date moveDay:(ligalInvestDays + delta)] localizedStringWithDateFormat:@"d MMMM"],
								  (int)ligalInvestDays,
								  [NSString russianStringFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:ligalInvestDays]];
	
	[self.firstShortDaysLabel setText:[NSString stringWithFormat:@"%i", (int)ligalInvestDays]];
	[self.firstShortDescriptionLabel setText:firstDescription];
	[self.firstFullDaysLabel setText:[NSString stringWithFormat:@"%i", (int)ligalInvestDays]];
	[self.firstFullWordDaysLabel setText:[NSString russianStringFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:ligalInvestDays]];
	[self.firstFullDescriptionLabel setText:firstDescription];
	[self.firstFullTripDatesLabel setText:[NSString stringWithFormat:@"%@ — %@",
										   [self.date localizedStringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle],
										   [[self.date moveDay:(ligalInvestDays + delta)] localizedStringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]]];
	
	NSDate *searchDate = [library nearestDateWithRequiredTripDays:self.fullBlock2Stepper.value fromDate:self.date withBoundaryDatesStatus:[NSUserDefaults standardUserDefaults].displayBoundaryDatesStatus inContext:library.managedObjectContext];
	[self.secondFullDayDateLabel setText:[NSString stringWithFormat:@"%@", [searchDate localizedStringWithDateFormat:@"d MMMM"]]];
	
}

- (void)updateСitizenData
{
	
}

- (IBAction)fullBlockStepperChanged:(id)sender
{
	[self.fullBlock2StepperLabel setText:[NSString stringWithFormat:@"%i", (int)self.fullBlock2Stepper.value]];
	[self updateСalculatedData];
}

- (IBAction)changedSelectedSegment:(id)sender
{
	switch (self.segment.selectedSegmentIndex)
	{
		case kUKRecentCheckTypeInvestor:
			[NSUserDefaults standardUserDefaults].displayCheckType = kUKRecentCheckTypeInvestor;
			break;
			
		case kUKRecentCheckTypeСitizen:
			[NSUserDefaults standardUserDefaults].displayCheckType = kUKRecentCheckTypeСitizen;
			break;
			
		default:
			break;
	}
}

- (void)viewDidLayoutSubviews
{
//	if (self.mainView.frame.size.height > 200)
//	{
//		[self.fullVersion setHidden:NO];
//		[self.shortVersion setHidden:YES];
//	}
//	else
//	{
//		[self.fullVersion setHidden:YES];
//		[self.shortVersion setHidden:NO];
//	}
}

@end
