//
//  UKReportViewController.m
//  UK Resident
//
//  Created by Sergey Shvedov on 29.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKReportViewController.h"
#import "UKLibraryAPI.h"
#import "UKNotifications.h"
#import "UKReportTopCVC.h"
#import "UKReportCenterCVC.h"
#import "UKReportBottomCVC.h"
#import "NSDate+UKResident.h"
#import "NSString+UKResident.h"

@interface UKReportViewController ()

@property (nonatomic, weak) UKReportTopCVC *topCVC;
@property (nonatomic, weak) UKReportCenterCVC *centerCVC;
@property (nonatomic, weak) UKReportBottomCVC *bottomCVC;

@property (nonatomic, weak) IBOutlet UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *rightBarButtonItem;

@property (nonatomic, weak) UIButton *leftBarButton;
@property (nonatomic, weak) UIButton *rightBarButton;

@property (nonatomic, strong) NSDate *todayDate;

@end

@implementation UKReportViewController

- (void)setDate:(NSDate *)date
{
	_date = date;
	[self updateUI];
}

- (NSDate *)todayDate
{
	if (nil == _todayDate)
	{
		_todayDate = [[NSDate date] normalization];
	}
	return _todayDate;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.navigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBarIconReportSelected"];
	[self mountBarButtons];
	
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	
	if (nil == library.currentInitDate)
	{
		library.isInitDateSetted = NO;
		//library.currentInitDate = [[NSDate date] normalization];
	}
	else
	{
		library.isInitDateSetted = YES;
		library.currentInitDate = library.currentInitDate;
	}
	
	self.date = [[NSDate date] normalization];
	
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center addObserver:self selector: @selector(updateUI) name: UKNotificationNeedUpdateReportView object: nil];
}

- (void)dealloc
{
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center removeObserver:self];
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
	
	leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, -11, 0, 11);
	leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 12);
	
	[leftButtonView addSubview:leftButton];
	
	UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:leftButtonView];
	self.navigationItem.leftBarButtonItem = leftBarButton;
	
	[leftButton addTarget:self action:@selector(tappedLeftBarButton) forControlEvents:UIControlEventTouchUpInside];
	self.leftBarButton = leftButton;
	
	UIView *rightButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 110, 30)];
	UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
	rightButton.backgroundColor = [UIColor clearColor];
	rightButton.frame = rightButtonView.frame;
	[rightButton setImage:[UIImage imageNamed:@"reportNavBarIconRight"] forState:UIControlStateNormal];
	[rightButton setTitle:@"03.05.2015" forState:UIControlStateNormal];
	
	[rightButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
	rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
	//rightButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
	rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, -17, 0, 17);
	rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 97, 0, -97);
	
	[rightButton sizeToFit];
	[rightButtonView addSubview:rightButton];
	
	UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:rightButtonView];
	self.navigationItem.rightBarButtonItem = rightBarButton;
	
	[rightButton addTarget:self action:@selector(tappedRightBarButton) forControlEvents:UIControlEventTouchUpInside];
	self.rightBarButton = rightButton;
	
	
	
	//[leftButton addTarget:self action:@selector(<YourTargetMethod>) forControlEvents:UIControlEventTouchUpInside];
	
	//[self.leftBarButtonItem setImage:[UIImage imageNamed:@"tabBarIconReportSelected"]];
	//self.leftBarButtonItem = leftButton;
}

- (void)updateUI
{
	[self.topCVC setDate:self.date];
	[self.centerCVC setDate:self.date];
	[self.bottomCVC setDate:self.date];
	
	[self updateNavigationBar];
	[self.navigationController.tabBarItem setTitle:@"Отчет дня"];
}

- (void)updateNavigationBar
{
	NSInteger difference = [[self.todayDate normalization] numberOfDaysUntil:[self.date normalization]];
	NSString *title = @"Сегодня";
	NSString *ruDays = [NSString russianStringFor1:@"день" for2to4:@"дня" for5up:@"дней" withValue:difference];
	if (difference < 0)
	{
		title = [NSString stringWithFormat:@"%li %@ назад", labs(difference), ruDays];
	}
	else if (difference > 0)
	{
		title = [NSString stringWithFormat:@"%li %@ вперед", labs(difference), ruDays];
	}
	[self setTitle:title];
	
	NSDate *selectedDate = (nil != self.date) ? self.date : self.todayDate;
	NSDate *yesterday = [NSDate dateWithTimeInterval:(-24*60*60) sinceDate:selectedDate];
	NSDate *tomorrow = [NSDate dateWithTimeInterval:(+24*60*60) sinceDate:selectedDate];
	[self.leftBarButton setTitle:[yesterday localizedStringWithDateFormat:@"dd.MM.yyyy"] forState:UIControlStateNormal];
	[self.rightBarButton setTitle:[tomorrow localizedStringWithDateFormat:@"dd.MM.yyyy"] forState:UIControlStateNormal];
}

- (void)tappedLeftBarButton
{
	NSDate *selectedDate = (nil != self.date) ? self.date : self.todayDate;
	self.date = [selectedDate moveDay:-1];
}

- (void)tappedRightBarButton
{
	NSDate *selectedDate = (nil != self.date) ? self.date : self.todayDate;
	self.date = [selectedDate moveDay:+1];
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
