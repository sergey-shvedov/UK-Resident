//
//  UKReportBottomCVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 29.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKReportBottomCVC.h"
#import "UKLibraryAPI.h"
#import "NSUserDefaults+AccessoryMethods.h"

@interface UKReportBottomCVC ()

@property (weak, nonatomic) IBOutlet UISwitch *switcher;
@property (weak, nonatomic) IBOutlet UILabel *switchLabel;


@end

@implementation UKReportBottomCVC

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self updateUI];
}

- (void)setDate:(NSDate *)date
{
	_date = date;
	[self updateUI];
}

- (void)updateUI
{
	switch ([NSUserDefaults standardUserDefaults].displayBoundaryDatesStatus)
	{
		case kUKRecentBoundaryDatesStatusExcept:
			[self.switcher setOn:kUKRecentBoundaryDatesStatusExcept];
			[self.switchLabel setText:@"Дни улета и прилета считаются днями присутствия в UK"];
			break;
			
		case kUKRecentBoundaryDatesStatusCount:
			[self.switcher setOn:kUKRecentBoundaryDatesStatusCount];
			[self.switchLabel setText:@"Дни улета и прилета не учитываются как дни присутствия в UK"];
			break;
			
		default:
			break;
	}
}

- (IBAction)switchChanged:(id)sender
{
	switch (self.switcher.isOn)
	{
		case kUKRecentBoundaryDatesStatusExcept:
			[NSUserDefaults standardUserDefaults].displayBoundaryDatesStatus = kUKRecentBoundaryDatesStatusExcept;
			break;
			
		case kUKRecentBoundaryDatesStatusCount:
			[NSUserDefaults standardUserDefaults].displayBoundaryDatesStatus = kUKRecentBoundaryDatesStatusCount;
			break;
			
		default:
			break;
	}
	[self updateUI];
	[[UKLibraryAPI sharedInstance] sendNotificationNeedUpdateReportView];
}

@end
