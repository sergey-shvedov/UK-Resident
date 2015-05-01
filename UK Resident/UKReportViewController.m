//
//  UKReportViewController.m
//  UK Resident
//
//  Created by Sergey Shvedov on 29.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKReportViewController.h"
#import "UKReportTopCVC.h"
#import "UKReportCenterCVC.h"
#import "UKReportBottomCVC.h"

@interface UKReportViewController ()

@property (nonatomic, weak) UKReportTopCVC *topCVC;
@property (nonatomic, weak) UKReportCenterCVC *centerCVC;
@property (nonatomic, weak) UKReportBottomCVC *bottomCVC;

@property (nonatomic, weak) IBOutlet UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *rightBarButtonItem;

@end

@implementation UKReportViewController

- (void)setDate:(NSDate *)date
{
	_date = date;
	[self updateUI];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.navigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBarIconReportSelected"];
	[self mountBarButtons];
}

- (void)mountBarButtons
{
	UIView *leftButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 110, 30)];
	UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
	leftButton.backgroundColor = [UIColor clearColor];
	leftButton.frame = leftButtonView.frame;
	[leftButton setImage:[UIImage imageNamed:@"reportNavBarIconLeft"] forState:UIControlStateNormal];
	[leftButton setTitle:@"01.05.2015" forState:UIControlStateNormal];
	[leftButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
	[leftButton sizeToFit];
	[leftButtonView addSubview:leftButton];
	
	UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:leftButtonView];
	self.navigationItem.leftBarButtonItem = leftBarButton;
	
	UIView *rightButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 110, 30)];
	UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
	rightButton.backgroundColor = [UIColor clearColor];
	rightButton.frame = rightButtonView.frame;
	[rightButton setImage:[UIImage imageNamed:@"reportNavBarIconRight"] forState:UIControlStateNormal];
	[rightButton setTitle:@"03.05.2015" forState:UIControlStateNormal];
	
	[rightButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
	rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
	//rightButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
	rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 15);
	rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 95, 0, -95);
	
	[rightButton sizeToFit];
	[rightButtonView addSubview:rightButton];
	
	NSLog(@"%f", rightButton.titleLabel.frame.size.width);
	
	UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:rightButtonView];
	self.navigationItem.rightBarButtonItem = rightBarButton;
	
	
	
	//[leftButton addTarget:self action:@selector(<YourTargetMethod>) forControlEvents:UIControlEventTouchUpInside];
	
	//[self.leftBarButtonItem setImage:[UIImage imageNamed:@"tabBarIconReportSelected"]];
	//self.leftBarButtonItem = leftButton;
}

- (void)updateUI
{
	[self.topCVC setDate:self.date];
	[self.centerCVC setDate:self.date];
	[self.bottomCVC setDate:self.date];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"ReportTopCVC"])
	{
		UKReportTopCVC *reportTopCVC=(UKReportTopCVC *)[segue destinationViewController];
		self.topCVC = reportTopCVC;
	}
	else if ([segue.identifier isEqualToString:@"ReportCenterCVC"])
	{
		UKReportCenterCVC *reportCenterCVC=(UKReportCenterCVC *)[segue destinationViewController];
		self.centerCVC = reportCenterCVC;
	}
	else if ([segue.identifier isEqualToString:@"ReportBottomCVC"])
	{
		UKReportBottomCVC *reportBotomCVC=(UKReportBottomCVC *)[segue destinationViewController];
		self.bottomCVC = reportBotomCVC;
	}
}

@end
