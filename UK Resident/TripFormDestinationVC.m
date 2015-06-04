//
//  TripFormDestinationVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 12.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "TripFormDestinationVC.h"

@interface TripFormDestinationVC ()<UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *destinationTextField;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@property (nonatomic, strong) NSString *selectedText;

@end

@implementation TripFormDestinationVC

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.destinationTextField.delegate = self;
	self.commentTextView.delegate = self;
	if (self.editingTrip.isDestinationEdited)
	{
		self.destinationTextField.text = self.editingTrip.destination;
	}
	self.selectedText = nil;
	if (self.editingTrip.isCommentEdited)
	{
		self.commentTextView.text = self.editingTrip.comment;
	}
}

- (IBAction)okButton:(id)sender
{
	[self.destinationTextField endEditing:YES];
	
	if ([self.selectedText length])
	{
		self.editingTrip.destination = self.selectedText;
		self.editingTrip.isDestinationEdited = YES;
		self.editingTrip.isDestinationNeedEdit = NO;
	}
	if (NO == [self.commentTextView.text isEqualToString:@"Комментарии"] && NO == [self.commentTextView.text isEqualToString:@""])
	{
		self.editingTrip.comment = self.commentTextView.text;
		self.editingTrip.isCommentEdited = YES;
		self.editingTrip.isCommentNeedEdit = NO;
	}
	
	[self.navigationController popViewControllerAnimated:YES];
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

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
	if ([self.commentTextView.text isEqualToString:@"Комментарии"])
	{
		[self.commentTextView setText:@""];
	}
}

@end
