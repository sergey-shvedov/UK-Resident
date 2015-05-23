//
//  TripFormAttachmentVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 22.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "TripFormAttachmentVC.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "TripFormAttachmentDetailPhotoVC.h"
#import "TempTrip.h"

@interface TripFormAttachmentVC ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIPopoverController *popover;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *emptyBackgroundImage;

@property (nonatomic, strong) NSArray *sortedPath;

@end

@implementation TripFormAttachmentVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	
	self.sortedPath = [[NSArray alloc] init];
	[self updateUI];
	
	UIBarButtonItem *btnPhoto = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(tappedPhotoButton:)];
	UIBarButtonItem *btnLibrary = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(tappedLibraryButton:)];
	[self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:btnLibrary, btnPhoto, nil]];
}

#pragma mark = UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return [self.sortedPath count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Attach Photo Cell" forIndexPath:indexPath];
	if (nil != cell)
	{
		[cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
		UIImage *savedImage = nil;
		if ([self.sortedPath count] > indexPath.row)
		{
			savedImage = [UIImage imageWithContentsOfFile:[self.sortedPath objectAtIndex:indexPath.row]];
		}
		if (nil == savedImage) savedImage = [UIImage imageNamed:@"tripFormPhotoBackground"];
		
		UIImageView *imageView = [[UIImageView alloc] initWithImage:savedImage];
		imageView.contentMode = UIViewContentModeScaleAspectFill;
		[imageView setFrame:cell.bounds];
		[cell addSubview:imageView];
	}
	
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	
}

- (void)updateUI
{
	[self sortPath];
	[self.emptyBackgroundImage setHidden:([self.sortedPath count] ? YES : NO)];

	[self.collectionView reloadData];
}

- (void)sortPath
{
	self.sortedPath = [self.editingTrip.attachedPhotosPathStrings allObjects];
}

- (NSString *)saveImage:(UIImage *)anImage
{
	NSString *result = nil;
	NSString *prefixString = @"AttachedPhoto";
	NSString *guid = [[NSUUID new] UUIDString];
	NSString *uniqueFileName = [NSString stringWithFormat:@"%@_%@.png", prefixString, guid];
	
	NSData *imageData = UIImagePNGRepresentation(anImage);
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:uniqueFileName];
	
	NSLog((@"pre writing to file"));
	if (![imageData writeToFile:imagePath atomically:NO])
	{
		NSLog((@"Failed to cache image data to disk"));
	}
	else
	{
		result = imagePath;
	}
	
	return result;
}

//- (UIImage *)readImageFromPath:(NSString *)path
//{
//	UIImage *result = nil;
//	
//	UIImage *customImage = [UIImage imageWithContentsOfFile:path];
//	
//	return result;
//}

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
	UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
	if (nil == image) image = [info objectForKey:UIImagePickerControllerOriginalImage];
	if (nil != image)
	{
		NSString *path = [self saveImage:image];
		[self.editingTrip.attachedPhotosPathStrings addObject:path];
		[self updateUI];
	}
	
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

#pragma mark - Preparing for Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([sender isKindOfClass:[UICollectionViewCell class]])
	{
		NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
		if ([segue.identifier isEqualToString:@"Photo detail"])
		{
			if ([segue.destinationViewController isKindOfClass:[TripFormAttachmentDetailPhotoVC class]])
			{
				TripFormAttachmentDetailPhotoVC *detailVC = (TripFormAttachmentDetailPhotoVC *)segue.destinationViewController;
				if ([self.sortedPath count] > indexPath.row)
				{
					detailVC.imagePath = [self.sortedPath objectAtIndex:indexPath.row];
				}
			}
		}
	}
}

- (IBAction)popoverApplied:(UIStoryboardSegue *)segue
{
	if ([segue.identifier isEqualToString:@"Unwind deletion"])
	{
		if ([[segue sourceViewController] isKindOfClass:[TripFormAttachmentDetailPhotoVC class]])
		{
			TripFormAttachmentDetailPhotoVC *detailVC = (TripFormAttachmentDetailPhotoVC *)segue.sourceViewController;
			[self.editingTrip.attachedPhotosPathStrings removeObject:detailVC.imagePath];
			[self updateUI];
		}
	}
}


@end
