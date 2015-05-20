//
//  UKUserEditVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 20.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKUserEditVC.h"
#import "UIColor+UKResident.h"

CGFloat const kUKHeightOfSegmentRoundView = 14.;

@interface UKUserEditVC ()

@property (weak, nonatomic) IBOutlet UIView *backgroundForSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *trashBarIcon;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation UKUserEditVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	if (YES == self.isCreating)
	{
		self.navigationItem.rightBarButtonItem = nil;
		[self.saveButton setTitle:@"Создать" forState:UIControlStateNormal];
	}
	[self.segment setSelectedSegmentIndex:self.colorID];
	[self.segment setTintColor:[UIColor colorWithColorID:self.colorID withAlpha:1.]];
	[self.nameTextField setText:self.name];
	
	NSInteger numberOfSegments = self.segment.numberOfSegments;
	CGFloat deltaX = self.backgroundForSegment.bounds.size.width / numberOfSegments;
	CGFloat xCentralPoint = deltaX / 2;
	CGFloat yCentralPoint = self.backgroundForSegment.bounds.size.height / 2;
	
	for (int i = 0; i < numberOfSegments; i++)
	{
		UIView *roundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUKHeightOfSegmentRoundView, kUKHeightOfSegmentRoundView)];
		[roundView setCenter:CGPointMake(xCentralPoint + i * deltaX, yCentralPoint)];
		[roundView.layer setCornerRadius:(kUKHeightOfSegmentRoundView / 2)];
		[roundView setBackgroundColor:[UIColor colorWithColorID:i]];
		[self.backgroundForSegment addSubview:roundView];
	}
	
}

- (IBAction)changedSegmentValue:(id)sender
{
	NSInteger selectedIndex = self.segment.selectedSegmentIndex;
	[self.segment setTintColor:[UIColor colorWithColorID:selectedIndex withAlpha:1.]];
	self.colorID = selectedIndex;
}


@end
