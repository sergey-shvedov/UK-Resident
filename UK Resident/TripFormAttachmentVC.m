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

@end

@implementation TripFormAttachmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
	[self.popover dismissPopoverAnimated:YES];
	[self resetPopover];
	//[self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self.popover dismissPopoverAnimated:YES];
	[self resetPopover];
	//[self dismissViewControllerAnimated:YES completion:^{}];
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
