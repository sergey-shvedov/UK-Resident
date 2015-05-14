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

@interface UKReportCenterCVC ()<UKReportCenterMainViewDelegate>

@property (nonatomic, weak) IBOutlet UISegmentedControl *segment;
@property (nonatomic, weak) IBOutlet UKReportCenterMainView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, weak) IBOutlet UIView *shortVersion;
@property (weak, nonatomic) IBOutlet UIView *fullVersion;

@property (weak, nonatomic) IBOutlet UIStepper *fullBlock2Stepper;
@property (weak, nonatomic) IBOutlet UILabel *fullBlock2StepperLabel;


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
			break;
			
		case kUKRecentCheckTypeСitizen:
			[self.segment setSelectedSegmentIndex:kUKRecentCheckTypeСitizen];
			break;
			
		default:
			break;
	}
}

- (IBAction)fullBlockStepperChanged:(id)sender
{
	[self.fullBlock2StepperLabel setText:[NSString stringWithFormat:@"%i", (int)self.fullBlock2Stepper.value]];
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
