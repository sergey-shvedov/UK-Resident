//
//  UKReportCenterMainView.m
//  UK Resident
//
//  Created by Sergey Shvedov on 02.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKReportCenterMainView.h"

@implementation UKReportCenterMainView

- (void)layoutSubviews
{
	if (self.frame.size.height > 250)
	{
		if ([self.delegate respondsToSelector:@selector(mainView:layoutToFullVersion:)])
		{
			[self.delegate mainView:self layoutToFullVersion:YES];
		}
	}
	else
	{
		if ([self.delegate respondsToSelector:@selector(mainView:layoutToFullVersion:)])
		{
			[self.delegate mainView:self layoutToFullVersion:NO];
		}
	}
}

@end
