//
//  UKReportTopDiagramVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 30.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKReportTopDiagramVC.h"
#import "NSDate+UKResident.h"
#import "UKLibraryAPI.h"
#import "Trip.h"

@interface UKReportTopDiagramVC ()

@property (nonatomic, weak) IBOutlet UIImageView *background;
@property (nonatomic, weak) IBOutlet UILabel *yearLabelTop;
@property (nonatomic, weak) IBOutlet UILabel *yearLabelBottom;
@property (nonatomic, weak) IBOutlet UIView *drawingView;

@property (nonatomic, strong) UIImageView *todayIcon;
@property (nonatomic, strong) UIImageView *yearBorderTop;
@property (nonatomic, strong) UIImageView *yearBorderBottom;
@property (nonatomic, strong) UILabel *initialDateLabel;
@property (nonatomic, assign) NSUInteger initialYear;

@property (nonatomic, strong) NSMutableArray *shadingViews;
@property (nonatomic, strong) NSMutableArray *lightingViews;
@property (nonatomic, strong) NSMutableArray *tripsViews;

@end

@implementation UKReportTopDiagramVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.shadingViews = [[NSMutableArray alloc] init];
	self.lightingViews = [[NSMutableArray alloc] init];
	self.tripsViews = [[NSMutableArray alloc] init];
	self.initialDate = [UKLibraryAPI sharedInstance].currentInitDate;
	self.date = [NSDate date];
	[self mountDiagramIcons];
	[self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
	
}

- (void)setDate:(NSDate *)date
{
	_date = date;
	[self updateUI];
}

- (void)setInitialDate:(NSDate *)initialDate
{
	_initialDate = initialDate;
	self.initialYear = [initialDate yearComponent];
	[self updateUI];
}

- (void)mountDiagramIcons
{
	UIImageView *borderTop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reportTopDiagramYearsBorderTop"]];
	[self.drawingView addSubview:borderTop];
	[borderTop setCenter:CGPointMake(0, 100)];
	self.yearBorderTop = borderTop;
	
	UIImageView *borderBottom = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reportTopDiagramYearsBorderBottom"]];
	[self.drawingView addSubview:borderBottom];
	[borderBottom setCenter:CGPointMake(0, 100)];
	self.yearBorderBottom = borderBottom;
	
	UIImageView *today = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reportTopDiagramTodayIcon"]];
	[self.drawingView addSubview:today];
	[today setCenter:CGPointMake(0, 100)];
	self.todayIcon = today;
	
	UILabel *initialDateLabel = [[UILabel alloc] init];
	[initialDateLabel setText:@"12.04.2015"];
	[initialDateLabel setTextColor:[UIColor colorWithRed:255./255. green:246./255. blue:166./255. alpha:1.]];
	[initialDateLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
	[initialDateLabel sizeToFit];
	CGRect rect = initialDateLabel.frame;
	rect.origin.x = 40;
	rect.origin.y = 140;
	[initialDateLabel setFrame:rect];

	[self.view addSubview:initialDateLabel];
	self.initialDateLabel = initialDateLabel;
}

- (void)updateUI
{
	self.todayIcon.center = [self pointForDate:self.date];
	self.yearBorderBottom.center = [self pointForDate:self.initialDate withXDelra:5];
	self.yearBorderTop.center = [self pointForDate:[self.initialDate moveYear:5] withXDelra:-5];
	[self createShadingOutsideBordings];
	[self createTripsViews];
	[self createLightingForVisaYear];
	
	[self.initialDateLabel setText:[self.initialDate localizedStringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
	[self.initialDateLabel sizeToFit];
	CGRect initialDateLabelFrame = [self changeFrame:self.initialDateLabel.frame forDate:self.initialDate withXDelra:32];
	initialDateLabelFrame.origin.y = 140;
	[self.initialDateLabel setFrame:initialDateLabelFrame];
	[self.yearLabelBottom setText:[self.initialDate localizedStringWithDateFormat:@"YYYY"]];
	[self.yearLabelTop setText:[[self.initialDate moveYear:5] localizedStringWithDateFormat:@"YYYY"]];
	
	[self reorderViews];
}

- (void)reorderViews
{
	[self.drawingView bringSubviewToFront:self.yearBorderTop];
	[self.drawingView bringSubviewToFront:self.yearBorderBottom];
	[self.drawingView bringSubviewToFront:self.todayIcon];
}

- (void)createShadingOutsideBordings
{
	for (UIView *view in self.shadingViews)
	{
		[view removeFromSuperview];
	}
	[self.shadingViews removeAllObjects];
	
	CGPoint topPoint = [self pointForDate:[self.initialDate moveYear:5]];
	CGPoint bottomPoint = [self pointForDate:self.initialDate];
	CGFloat topWidth = 515 - topPoint.x;
	CGFloat bottomWidth = bottomPoint.x;
	UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(topPoint.x, 0., topWidth, 20)];
	UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0., 115., bottomWidth, 20)];
	UIColor *color = [UIColor colorWithRed:0. green:0.15 blue:0.5 alpha:0.1];
	[topView setBackgroundColor:color];
	[bottomView setBackgroundColor:color];
	[self.drawingView addSubview:topView];
	[self.drawingView addSubview:bottomView];
	[self.shadingViews addObject:topView];
	[self.shadingViews addObject:bottomView];
}

- (void)createLightingForVisaYear
{
	for (UIView *view in self.lightingViews)
	{
		[view removeFromSuperview];
	}
	[self.lightingViews removeAllObjects];
	
	[self.lightingViews addObjectsFromArray:[self createViewsWithStartDate:[self.date moveYear:-1] andEndDate:self.date withInitialBorderDate:self.initialDate andFinalBorderDate:[self.initialDate moveYear:5] withHeight:20 andColor:[UIColor colorWithRed:0.5 green:0.9 blue:1. alpha:0.2]]];
	for (UIView *view in self.lightingViews)
	{
		[self.drawingView addSubview:view];
	}
}

- (void)createTripsViews
{
	for (UIView *view in self.tripsViews)
	{
		[view removeFromSuperview];
	}
	[self.tripsViews removeAllObjects];
	
	NSDate *startGraphDate = [self.initialDate startOfYear];
	NSDate *endGraphDate = [[self.initialDate moveYear:5] endOfYear];
	
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	NSArray *trips = [library arrayWithTripsBetweenStartDate:startGraphDate andEndDate:endGraphDate];
	
	NSDate *initialBorder = [NSDate dateWithDay:1 month:1 andYear:[self.initialDate yearComponent]];
	NSDate *finalBorder = [NSDate dateWithDay:31 month:12 andYear:[[self.initialDate moveYear:5] yearComponent]];
	UIColor *color = [UIColor colorWithRed:76/255. green:217/255. blue:99/255. alpha:1.];
	CGFloat height = 12;
	
	for (Trip *trip in trips)
	{
		[self.tripsViews addObjectsFromArray:[self createViewsWithStartDate:trip.startDate andEndDate:trip.endDate withInitialBorderDate:initialBorder andFinalBorderDate:finalBorder withHeight:height andColor:color]];
	}
	
	for (UIView *view in self.tripsViews)
	{
		[self.drawingView addSubview:view];
	}
}

- (UIView *)lightingViewWithWidth:(CGFloat)aWidth
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0., 0., aWidth, 20)];
	UIColor *color = [UIColor colorWithRed:0.5 green:0.9 blue:1. alpha:0.2];
	[view setBackgroundColor:color];
	return view;
}

- (NSArray *)createViewsWithStartDate:(NSDate *)aStartDate andEndDate:(NSDate *)anEndDate withInitialBorderDate:(NSDate *)anInitialBorderDate andFinalBorderDate:(NSDate *)aFinalBorderDate withHeight:(CGFloat)aHeight andColor:(UIColor *)aColor
{
	NSMutableArray *array = [[NSMutableArray alloc] init];
	NSDate *firstDate = (NSOrderedAscending == [aStartDate compare:anInitialBorderDate]) ? anInitialBorderDate : aStartDate;
	NSDate *latestDate = (NSOrderedAscending == [anEndDate compare:aFinalBorderDate]) ? anEndDate : aFinalBorderDate;
	
	if (NSOrderedAscending == [firstDate compare:latestDate])
	{
		for (NSInteger i = [firstDate yearComponent]; i <= [latestDate yearComponent]; i++)
		{
			CGFloat x1 = 0;
			CGFloat x2 = 515;
			CGFloat y = 125. - (23 * (i - self.initialYear)) - (aHeight / 2);
			if ([firstDate yearComponent] == i)
			{
				x1 = [self pointForDate:firstDate].x;
			}
			if ([latestDate yearComponent] == i)
			{
				x2 = [self pointForDate:latestDate].x;
			}
			CGFloat width = x2 - x1;
			
			UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x1, y, width, aHeight)];
			[view setBackgroundColor:aColor];
			[array addObject:view];
		}
	}
	
	return array;
}

- (CGPoint)pointForDate:(NSDate *)aDate
{
	return [self pointForDate:aDate withXDelra:0];
}

- (CGPoint)pointForDate:(NSDate *)aDate withXDelra:(NSInteger)xDelta
{
	CGPoint point = CGPointMake(-200., -200.);
	if ( (self.initialYear <= [aDate yearComponent]) && ([aDate yearComponent] <= (self.initialYear + 5)) )
	{
		CGFloat y = 125. - (23 * ([aDate yearComponent] - self.initialYear));
		//CGFloat x = (int)(515. * ([aDate dayOfYear] / 365.)) + xDelta;
		CGFloat x = (int)(43 * ([aDate monthComponent] - 1) + 42 * ((float)[aDate dayOfMonth]) / ((float)[aDate daysInMonth])) + xDelta;
		point = CGPointMake(x, y);
	}
	return point;
}

- (CGRect)changeFrame:(CGRect)aRect forDate:(NSDate *)aDate withXDelra:(NSInteger)xDelta
{
	return [self changeFrame:aRect forDate:aDate withXDelra:xDelta andYDelta:0];
}

- (CGRect)changeFrame:(CGRect)aRect forDate:(NSDate *)aDate withXDelra:(NSInteger)xDelta andYDelta:(NSInteger)yDelta
{
	CGPoint point = [self pointForDate:aDate withXDelra:xDelta];
	aRect.origin.x = point.x;
	aRect.origin.y = point.y + yDelta;
	return aRect;
}

@end
