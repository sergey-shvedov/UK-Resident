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
#import "UIColor+UKResident.h"

@interface UKReportCenterCVC ()<UKReportCenterMainViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UKReportCenterMainView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIView *shortVersion;
@property (weak, nonatomic) IBOutlet UIView *fullVersion;

@property (weak, nonatomic) IBOutlet UILabel *firstShortDaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstShortDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstShortImage;
@property (weak, nonatomic) IBOutlet UIView *firstShortBackgroundView;

@property (weak, nonatomic) IBOutlet UILabel *firstFullDaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstFullWordDaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstFullDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstFullTripDatesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstFullImage;
@property (weak, nonatomic) IBOutlet UIView *firstFullBackgroundView;

@property (weak, nonatomic) IBOutlet UIStepper *fullBlock2Stepper;
@property (weak, nonatomic) IBOutlet UILabel *fullBlock2StepperLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondFullDayDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondFullMonthDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondFullDescriptionLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *secondFullLabels;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *secondFullActivityIndicator;



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
			[self updateFirstDescription];
			[self updateSecondDescription];
			break;
			
		case kUKRecentCheckTypeСitizen:
			[self.segment setSelectedSegmentIndex:kUKRecentCheckTypeСitizen];
			[self updateFirstDescription];
			[self updateSecondDescription];
			break;
			
		default:
			break;
	}
}

- (void)updateFirstDescription
{
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	NSInteger delta = [NSUserDefaults standardUserDefaults].displayBoundaryDatesStatus ? -1 : +1;
	
	switch ([NSUserDefaults standardUserDefaults].displayBoundaryDatesStatus)
	{
		case kUKRecentBoundaryDatesStatusExcept:
			delta = +1;
			break;
			
		case kUKRecentBoundaryDatesStatusCount:
			delta = -1;
			if ([library isATripDate:self.date inContext:library.managedObjectContext])
			{
				delta = 0;
			}
			break;
			
		default:
			break;
	}
	
	NSInteger numberOfLigalDays;
	NSInteger investNumberOfLigalDays = [library investNumberOfLigalDaysFromDate:self.date withBoundaryDatesStatus:[NSUserDefaults standardUserDefaults].displayBoundaryDatesStatus inContext:library.managedObjectContext];
	NSInteger citizenNumberOfLigalDays = [library citizenNumberOfLigalDaysFromDate:self.date withBoundaryDatesStatus:[NSUserDefaults standardUserDefaults].displayBoundaryDatesStatus inContext:library.managedObjectContext];

	switch ([NSUserDefaults standardUserDefaults].displayCheckType)
	{
		case kUKRecentCheckTypeInvestor:
			numberOfLigalDays = investNumberOfLigalDays;
			break;
			
		case kUKRecentCheckTypeСitizen:
			numberOfLigalDays = citizenNumberOfLigalDays;
			break;
			
		default:
			break;
	}
	
	if (numberOfLigalDays >= 0)
	{
		NSString *firstDescription = [NSString stringWithFormat:@"С %@ можно совершить поездку\nдо %@ (на %i %@).",
									  [self.date localizedStringWithDateFormat:@"d MMMM"],
									  [[self.date moveDay:(numberOfLigalDays + delta)] localizedStringWithDateFormat:@"d MMMM"],
									  (int)numberOfLigalDays,
									  [NSString russianStringFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:numberOfLigalDays]];
		
		[self.firstShortDaysLabel setText:[NSString stringWithFormat:@"%i", (int)numberOfLigalDays]];
		[self.firstShortDescriptionLabel setText:firstDescription];
		[self.firstFullDaysLabel setText:[NSString stringWithFormat:@"%i", (int)numberOfLigalDays]];
		[self.firstFullWordDaysLabel setText:[NSString russianStringFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:numberOfLigalDays]];
		[self.firstFullDescriptionLabel setText:firstDescription];
		[self.firstFullTripDatesLabel setText:[NSString stringWithFormat:@"%@ — %@",
											   [self.date localizedStringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle],
											   [[self.date moveDay:(numberOfLigalDays + delta)] localizedStringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]]];
		
		[self.firstFullBackgroundView setBackgroundColor:[UIColor colorReportCenterBackground]];
		[self.firstFullDaysLabel setTextColor:[UIColor colorReportCenterText]];
		[self.firstFullDescriptionLabel setTextColor:[UIColor colorReportCenterText]];
		[self.firstFullImage setImage:[UIImage imageNamed:@"reportCenterFullPlane"]];
		[self.firstFullTripDatesLabel setHidden:NO];
		[self.firstFullWordDaysLabel setTextColor:[UIColor colorReportCenterText]];
		[self.firstShortBackgroundView setBackgroundColor:[UIColor colorReportCenterBackground]];
		[self.firstShortDaysLabel setTextColor:[UIColor colorReportCenterText]];
		[self.firstShortDescriptionLabel setTextColor:[UIColor colorReportCenterText]];
		[self.firstShortImage setImage:[UIImage imageNamed:@"reportCenterShortPlane"]];
	}
	else
	{
		numberOfLigalDays = abs((int)numberOfLigalDays);
		NSString *firstDescription = [NSString stringWithFormat:@"На %@ Вы превысили максмимальное \nвремя пребывания вне UK на %i %@.",
									  [self.date localizedStringWithDateFormat:@"d MMMM"],
									  (int)numberOfLigalDays,
									  [NSString russianStringFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:numberOfLigalDays]];
		
		[self.firstShortDaysLabel setText:[NSString stringWithFormat:@"%i", (int)numberOfLigalDays]];
		[self.firstShortDescriptionLabel setText:firstDescription];
		[self.firstFullDaysLabel setText:[NSString stringWithFormat:@"%i", (int)numberOfLigalDays]];
		[self.firstFullWordDaysLabel setText:[NSString russianStringFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:numberOfLigalDays]];
		[self.firstFullDescriptionLabel setText:firstDescription];
		[self.firstFullTripDatesLabel setText:[NSString stringWithFormat:@"%@ — %@",
											   [self.date localizedStringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle],
											   [[self.date moveDay:(numberOfLigalDays + delta)] localizedStringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]]];
		
		[self.firstFullBackgroundView setBackgroundColor:[UIColor colorReportCenterBackgroundWarning]];
		[self.firstFullDaysLabel setTextColor:[UIColor colorReportCenterTextWarning]];
		[self.firstFullDescriptionLabel setTextColor:[UIColor colorReportCenterTextWarning]];
		[self.firstFullImage setImage:[UIImage imageNamed:@"reportCenterFullWarning"]];
		[self.firstFullTripDatesLabel setHidden:YES];
		[self.firstFullWordDaysLabel setTextColor:[UIColor colorReportCenterTextWarning]];
		[self.firstShortBackgroundView setBackgroundColor:[UIColor colorReportCenterBackgroundWarning]];
		[self.firstShortDaysLabel setTextColor:[UIColor colorReportCenterTextWarning]];
		[self.firstShortDescriptionLabel setTextColor:[UIColor colorReportCenterTextWarning]];
		[self.firstShortImage setImage:[UIImage imageNamed:@"reportCenterShortWarning"]];
	}
	
	NSString *investTitle = (investNumberOfLigalDays >= 0) ? [NSString stringWithFormat:@"Виза инвестора (%i %@)", (int)investNumberOfLigalDays, [NSString russianStringFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:investNumberOfLigalDays]] : @"Виза инвестора (Нарушение)";
	NSString *citizenTitle = (citizenNumberOfLigalDays >= 0) ? [NSString stringWithFormat:@"Гражданство (%i %@)", (int)citizenNumberOfLigalDays, [NSString russianStringFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:citizenNumberOfLigalDays]] : @"Гражданство (Нарушение)";
	[self.segment setTitle:investTitle forSegmentAtIndex:kUKRecentCheckTypeInvestor];
	[self.segment setTitle:citizenTitle forSegmentAtIndex:kUKRecentCheckTypeСitizen];
}

- (void)updateSecondDescription
{
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	for (UILabel *label in self.secondFullLabels) [label setAlpha:0.1];
	[self.secondFullActivityIndicator startAnimating];
	[library.expenciveFetchContext performBlock:^{
		
		NSDate *searchDate;
		switch ([NSUserDefaults standardUserDefaults].displayCheckType)
		{
			case kUKRecentCheckTypeInvestor:
				searchDate = [library investNearestDateWithRequiredTripDays:self.fullBlock2Stepper.value fromDate:self.date withBoundaryDatesStatus:[NSUserDefaults standardUserDefaults].displayBoundaryDatesStatus inContext:library.expenciveFetchContext];
				break;
				
			case kUKRecentCheckTypeСitizen:
				searchDate = [library citizenNearestDateWithRequiredTripDays:self.fullBlock2Stepper.value fromDate:self.date withBoundaryDatesStatus:[NSUserDefaults standardUserDefaults].displayBoundaryDatesStatus inContext:library.expenciveFetchContext];
				break;
				
			default:
				break;
		}
		
		dispatch_async(dispatch_get_main_queue(), ^{
			for (UILabel *label in self.secondFullLabels) [label setAlpha:1.];
			NSString *secondDescription = [NSString stringWithFormat:@"На %i %@ можно запланировать поездку\nс %@.",
										   (int)self.fullBlock2Stepper.value,
										   [NSString russianStringFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:self.fullBlock2Stepper.value],
										   [searchDate localizedStringWithDateFormat:@"d MMMM"]];
			
			[self.secondFullDayDateLabel setText:[NSString stringWithFormat:@"%@", [searchDate localizedStringWithDateFormat:@"d"]]];
			[self.secondFullMonthDateLabel setText:[NSString stringWithFormat:@"%@", [searchDate localizedStringWithDateFormat:@"MMMM"]]];
			[self.secondFullDescriptionLabel setText:secondDescription];
			[self.secondFullActivityIndicator stopAnimating];
		});
	}];
}

- (IBAction)fullBlockStepperChanged:(id)sender
{
	[self.fullBlock2StepperLabel setText:[NSString stringWithFormat:@"%i", (int)self.fullBlock2Stepper.value]];
	[self updateSecondDescription];
}

- (IBAction)changedSelectedSegment:(id)sender
{
	switch (self.segment.selectedSegmentIndex)
	{
		case kUKRecentCheckTypeInvestor:
			[NSUserDefaults standardUserDefaults].displayCheckType = kUKRecentCheckTypeInvestor;
			[self updateСalculatedData];
			break;
			
		case kUKRecentCheckTypeСitizen:
			[NSUserDefaults standardUserDefaults].displayCheckType = kUKRecentCheckTypeСitizen;
			[self updateСalculatedData];
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
