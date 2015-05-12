//
//  TripFormDestinationVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "TripFormDestinationVC.h"

@interface TripFormDestinationVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *destinationTextField;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@property (nonatomic, strong) NSString *selectedText;

@end

@implementation TripFormDestinationVC

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.destinationTextField.delegate = self;
	if (self.editingTrip.isDestinationEdited)
	{
		self.destinationTextField.text = self.editingTrip.destination;
	}
	self.selectedText = nil;
}




- (IBAction)okButton:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];

	if ([self.selectedText length])
	{
		self.editingTrip.destination = self.selectedText;
		self.editingTrip.isDestinationEdited = YES;
		self.editingTrip.isDestinationNeedEdit = NO;
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
	self.selectedText = self.destinationTextField.text;
}

@end
