//
//  UKWarningViewController.m
//  UK Resident
//
//  Created by Sergey Shvedov on 29.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKWarningViewController.h"
#import "UKNotifications.h"
#import "UKLibraryAPI.h"

@interface UKWarningViewController ()

@property (weak, nonatomic) IBOutlet UIView *statusOKView;

@end

@implementation UKWarningViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.navigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBarIconWarningSelected"];
	
	[self updateUI];
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center addObserver:self selector: @selector(updateUI) name: UKNotificationNeedUpdateUI object: nil];
}

- (void)dealloc
{
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center removeObserver:self];
}

- (void)updateUI
{
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	if ([library.warningInvestTrips count] || [library.warningCitizenTrips count])
	{
		[self.statusOKView setHidden:YES];
	}
	else
	{
		[self.statusOKView setHidden:NO];
	}
}

@end
