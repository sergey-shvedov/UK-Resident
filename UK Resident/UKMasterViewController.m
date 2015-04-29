//
//  UKMasterViewController.m
//  UK Resident
//
//  Created by Sergey Shvedov on 29.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKMasterViewController.h"
#import "UKCalendarTableViewController.h"

@interface UKMasterViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelTopYear;

@end

@implementation UKMasterViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTestNotification:) name:@"TopYearChangedNotification" object:nil];
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) receiveTestNotification:(NSNotification *) notification
{
	NSDictionary *userInfo = notification.userInfo;
	NSNumber *number = [userInfo objectForKey:@"topYear"];
	self.labelTopYear.text = [NSString stringWithFormat:@"%@", number];
}

@end
