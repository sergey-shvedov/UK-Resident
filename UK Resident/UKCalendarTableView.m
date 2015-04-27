//
//  UKCalendarTableView.m
//  UK Resident
//
//  Created by Sergey Shvedov on 27.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKCalendarTableView.h"

@implementation UKCalendarTableView

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (nil != self)
	{
		self.contentSize = CGSizeMake(self.frame.size.width, 5000);
		self.contentInset = UIEdgeInsetsMake(1000., 0., 1000., 0.);
	}
	
	return self;
}

- (void)setContentOffset:(CGPoint)aContentOffset
{
	[super setContentOffset:aContentOffset];
	[self recenterIfNecessary];
	
}

- (void)recenterIfNecessary
{
	CGPoint const currentOffset = [self contentOffset];
	CGFloat const contentHeight = [self contentSize].height;
	CGFloat centerOffsetY = (contentHeight - [self bounds].size.height) / 2.f;
	CGFloat const distanceFromCenter = fabs(currentOffset.y - centerOffsetY);
	

	
	if ((contentHeight > 0) && (distanceFromCenter > (contentHeight / 4.0)))
	{
		CGFloat const shiftY = centerOffsetY - currentOffset.y;
		int const rows = ((int)shiftY) / 44;
		CGFloat const delta = rows * 44;
		
		centerOffsetY = currentOffset.y + delta;
		
		if (YES == [self.agent respondsToSelector:@selector(calendarTableViewWillRecenterTo:)])
		{
			[self.agent calendarTableViewWillRecenterTo:rows];
		}
	
		self.contentOffset = CGPointMake(currentOffset.x, centerOffsetY);
		
		if (YES == [self.agent respondsToSelector:@selector(calendarTableViewDidRecenterTo:)])
		{
			[self.agent calendarTableViewDidRecenterTo:rows];
		}

	}
}

@end
