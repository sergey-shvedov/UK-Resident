//
//  UKWarningNavigationController.m
//  UK Resident
//
//  Created by Sergey Shvedov on 17.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKWarningNavigationController.h"
#import "UKNotifications.h"

@interface UKWarningNavigationController ()

@end

@implementation UKWarningNavigationController

- (void)awakeFromNib
{
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center addObserver:self selector: @selector(updateUI:) name:UKNotificationWarningTabNeedUpdate object: nil];
}

- (void)updateUI:(NSNotification *)aNotification
{
	NSDictionary *dictionary = [aNotification userInfo];
	NSInteger oldValue = [self.tabBarItem.badgeValue integerValue];
	NSInteger newValue = oldValue;
	if ([[dictionary objectForKey:@"totalWarnings"] isKindOfClass:[NSNumber class]])
	{
		newValue = [(NSNumber *)[dictionary objectForKey:@"totalWarnings"] integerValue];
	}
	
	if (0 == newValue)
	{
		[self.tabBarItem setBadgeValue:nil];
	}
	else
	{
		[self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%i", (int)newValue]];
	}
}

- (void)dealloc
{
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center removeObserver:self];
}


@end
