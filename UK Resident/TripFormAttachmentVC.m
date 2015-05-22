//
//  TripFormAttachmentVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 22.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "TripFormAttachmentVC.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface TripFormAttachmentVC ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate>

@property (nonatomic, strong) UIPopoverController *popover;
@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation TripFormAttachmentVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	UIBarButtonItem *btnPhoto = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(tappedPhotoButton:)];
	UIBarButtonItem *btnLibrary = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(tappedLibraryButton:)];
	[self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:btnLibrary, btnPhoto, nil]];
}

- (void)tappedPhotoButton:(id)sender
{
	if ([sender isKindOfClass:[UIBarButtonItem class]])
	{
		UIBarButtonItem *item = (UIBarButtonItem *)sender;
		
		UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
		pickerController.delegate = self;
		pickerController.modalPresentationStyle = UIModalPresentationFullScreen;
		
		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
		{
			pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
			
			NSString *desired = (NSString *)kUTTypeImage;
			if ([[UIImagePickerController availableMediaTypesForSourceType:pickerController.sourceType] containsObject:desired])
			{
				pickerController.mediaTypes = @[desired];
				
				[self presentViewController:pickerController animated:YES completion:^{}];
				self.imagePicker = pickerController;
			}
			else
			{
				//fail
			}
		}
	}
}

- (void)tappedLibraryButton:(id)sender
{
	if ([sender isKindOfClass:[UIBarButtonItem class]])
	{
		UIBarButtonItem *item = (UIBarButtonItem *)sender;
		
		UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
		pickerController.delegate = self;
		
		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
		{
			pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
			
			NSString *desired = (NSString *)kUTTypeImage;
			if ([[UIImagePickerController availableMediaTypesForSourceType:pickerController.sourceType] containsObject:desired])
			{
				pickerController.mediaTypes = @[desired];
				
				if(!self.popover)
				{
					self.popover = [[UIPopoverController alloc] initWithContentViewController:pickerController];
					self.popover.delegate = self;
					[self.popover presentPopoverFromBarButtonItem:item permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
				}
			}
			else
			{
				//fail
			}
		}
	}
}

- (IBAction)tappedAddButton:(id)sender
{
	if ([sender isKindOfClass:[UIBarButtonItem class]])
	{
		UIBarButtonItem *item = (UIBarButtonItem *)sender;
		
		UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
		pickerController.delegate = self;
		
		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
		{
			pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		}
		NSString *desired = (NSString *)kUTTypeImage;
		if ([[UIImagePickerController availableMediaTypesForSourceType:pickerController.sourceType] containsObject:desired])
		{
			pickerController.mediaTypes = @[desired];
			
			if(!self.popover)
			{
				self.popover = [[UIPopoverController alloc] initWithContentViewController:pickerController];
				self.popover.delegate = self;
				[self.popover presentPopoverFromBarButtonItem:item permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
			}
		}
		else
		{
			//fail
		}
	}
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
	{
		[self.popover dismissPopoverAnimated:YES];
		[self resetPopover];
	}
	else if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
	{
		[self dismissViewControllerAnimated:YES completion:^{}];
	}
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
	{
		[self.popover dismissPopoverAnimated:YES];
		[self resetPopover];
	}
	else if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
	{
		[self dismissViewControllerAnimated:YES completion:^{}];
	}
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
	[self resetPopover];
}

- (void)resetPopover
{
	self.popover = nil;
}



@end
