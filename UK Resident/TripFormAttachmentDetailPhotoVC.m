//
//  TripFormAttachmentDetailPhotoVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 23.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "TripFormAttachmentDetailPhotoVC.h"

@interface TripFormAttachmentDetailPhotoVC ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic,strong) UIImage *image;

@end

@implementation TripFormAttachmentDetailPhotoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self.scrollView addSubview:self.imageView];
	
	UIImage *savedImage = [UIImage imageWithContentsOfFile:self.imagePath];
	if (nil == savedImage) savedImage = [UIImage imageNamed:@"tripFormPhotoBackground"];
	self.imageView.contentMode = UIViewContentModeScaleAspectFill;
	self.image = savedImage;
}

- (UIImage *)image
{
	return self.imageView.image;
}

- (void)setImage:(UIImage *)image
{
	self.imageView.image = image;
	[self.imageView sizeToFit];
	self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

- (UIImageView *)imageView
{
	if (!_imageView)
	{
		_imageView = [[UIImageView alloc] init];
	}
	return _imageView;
}

- (void)setScrollView:(UIScrollView *)scrollView
{
	_scrollView = scrollView;
	self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
	_scrollView.minimumZoomScale = 0.2;
	_scrollView.maximumZoomScale = 2.0;
	_scrollView.delegate=self;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
	
}


@end
