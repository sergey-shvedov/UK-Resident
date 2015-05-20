//
//  UKUserEditVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 20.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKUserEditVC.h"
#import "UIColor+UKResident.h"
#import "User+Create.h"
#import "CALayer+RuntimeAttributes.h"
#import "UKLibraryAPI.h"

CGFloat const kUKHeightOfSegmentRoundView = 12.;

@interface UKUserEditVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *backgroundForSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *trashBarIcon;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIView *borderTextView;

@end

@implementation UKUserEditVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.nameTextField.delegate = self;
	
	if (YES == self.isCreating)
	{
		self.navigationItem.rightBarButtonItem = nil;
		[self.saveButton setTitle:@"Создать" forState:UIControlStateNormal];
	}
	[self.segment setSelectedSegmentIndex:self.colorID];
	[self.segment setTintColor:[UIColor colorWithColorID:self.colorID withAlpha:1.]];
	[self.borderTextView.layer setBorderUIColor:[UIColor colorWithColorID:self.colorID withAlpha:0.5]];
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

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	self.name = self.nameTextField.text;
}

#pragma mark -

- (IBAction)changedSegmentValue:(id)sender
{
	NSInteger selectedIndex = self.segment.selectedSegmentIndex;
	[self.segment setTintColor:[UIColor colorWithColorID:selectedIndex withAlpha:1.]];
	[self.borderTextView.layer setBorderUIColor:[UIColor colorWithColorID:selectedIndex withAlpha:0.5]];
	self.colorID = selectedIndex;
}

- (IBAction)tapedSaveButton:(id)sender
{
	[self.nameTextField endEditing:YES];
	[self.navigationController popViewControllerAnimated:YES];
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	if (self.isCreating)
	{
		User *user = [User createNextUserinContext:library.managedObjectContext];
		user.name = self.name;
		user.colorID = [NSNumber numberWithInteger:self.colorID];
	}
	else
	{
		[User editUserWithID:self.userID forName:self.name andColorID:self.colorID inContext:library.managedObjectContext];
	}
}

- (IBAction)tapedDeleteButton:(id)sender
{
	UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Удаление" message:@"Вы уверены, что хотите удалить этого путешественника а также все его поездки?" delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Да", nil];
	[alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if ([alertView.title isEqualToString:@"Удаление"] && (1 == buttonIndex))
	{
		UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
		[User deleteUserWithID:self.userID inContext:library.managedObjectContext];
		[self.navigationController popViewControllerAnimated:YES];
	}
}


@end
