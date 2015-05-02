//
//  UKReportCenterCVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 29.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKReportCenterCVC.h"
#import "UKReportCenterMainView.h"

@interface UKReportCenterCVC ()<UKReportCenterMainViewDelegate>

@property (nonatomic, weak) IBOutlet UISegmentedControl *segment;
@property (nonatomic, weak) IBOutlet UKReportCenterMainView *mainView;
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
	
}

- (IBAction)fullBlockStepperChanged:(id)sender
{
	[self.fullBlock2StepperLabel setText:[NSString stringWithFormat:@"%i", (int)self.fullBlock2Stepper.value]];
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
