//
//  UIColor+UKResident.m
//  UK Resident
//
//  Created by Sergey Shvedov on 02.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UIColor+UKResident.h"

typedef NS_ENUM(NSInteger, UKUserColors)
{
	kUKUserColorBlue = 0,
	kUKUserColorRed,
	kUKUserColorYellow,
	kUKUserColorGreen,
	kUKUserColorPurple,
};

@implementation UIColor (UKResident)

+ (UIColor *)colorNeedEdit
{
	return [UIColor colorWithRed:218.0/255.0 green:188.0/255.0 blue:70.0/255.0 alpha:1.0];
}

+ (UIColor *) colorNotYetEdit
{
	return [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
}

+ (UIColor *) colorEdited
{
	return [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
}

////////////////////////////////////////////

+ (UIColor *)colorButtonCancelBackground
{
	return [UIColor colorWithRed:255.0/255.0 green:220.0/255.0 blue:225.0/255.0 alpha:1.0];
}

+ (UIColor *)colorButtonCancelBackgroundHigligted
{
	return [UIColor colorWithRed:255.0/255.0 green:58.0/255.0 blue:82.0/255.0 alpha:1.0];
}

+ (UIColor *)colorButtonCancelText
{
	return [UIColor colorWithRed:227.0/255.0 green:49.0/255.0 blue:68.0/255.0 alpha:1.0];
}

+ (UIColor *)colorButtonCancelTextHigligted
{
	return [UIColor whiteColor];
}

//////////////////////////////////////////////

+ (UIColor *)colorButtonOkBackground
{
	return [UIColor colorWithRed:185.0/255.0 green:252.0/255.0 blue:207.0/255.0 alpha:1.0];
}

+ (UIColor *)colorButtonOkBackgroundHigligted
{
	return [UIColor colorWithRed:20.0/255.0 green:240.0/255.0 blue:94.0/255.0 alpha:1.0];
}

+ (UIColor *)colorButtonOkText
{
	return [UIColor colorWithRed:23.0/255.0 green:132.0/255.0 blue:44.0/255.0 alpha:1.0];
}

+ (UIColor *)colorButtonOkTextHigligted
{
	return [UIColor whiteColor];
}

////////////////////////////////////////////////

+ (UIColor *)colorButtonNeedEditOkBackground
{
	return [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
}

+ (UIColor *)colorButtonNeedEditOkBackgroundHigligted
{
	return [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
}

+ (UIColor *)colorButtonNeedEditOkText
{
	return [UIColor colorWithRed:178.0/255.0 green:178.0/255.0 blue:178.0/255.0 alpha:1.0];
}

+ (UIColor *)colorButtonNeedEditOkTextHigligted
{
	return [UIColor whiteColor];
}

////////////////////////////////////////////////

+ (UIColor *)colorCalendarWorkDay
{
	return [UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:1.0];
}

+ (UIColor *)colorCalendarWeekend
{
	return [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0];
}

+ (UIColor *)colorCalendarWarningDay
{
	return [UIColor colorWithRed:227.0/255.0 green:6.0/255.0 blue:19.0/255.0 alpha:1.0];
}

////////////////////////////////////////////////

+ (UIColor *)colorDiagramTripView
{
	return [UIColor colorWithRed:76/255. green:217/255. blue:99/255. alpha:1.0];
}

+ (UIColor *)colorDiagramWarningView
{
	return [UIColor colorWithRed:255.0/255.0 green:34.0/255.0 blue:34.0/255.0 alpha:0.8];
}

////////////////////////////////////////////////

+ (UIColor *)colorLeftGraphMain
{
	return [UIColor colorWithRed:67.0/255.0 green:213.0/255.0 blue:81.0/255.0 alpha:1.0];
}

+ (UIColor *)colorLeftGraphBackground
{
	return [UIColor colorWithRed:42.0/255.0 green:135.0/255.0 blue:195.0/255.0 alpha:1.0];
}

+ (UIColor *)colorRightGraphMain
{
	return [UIColor whiteColor];
}

+ (UIColor *)colorRightGraphBackground
{
	return [UIColor colorWithRed:44.0/255.0 green:153.0/255.0 blue:215.0/255.0 alpha:1.0];
}

////////////////////////////////////////////////

+ (UIColor *)colorInitialButtonSetted
{
	return [UIColor colorWithRed:88.0/255.0 green:185.0/255.0 blue:255.0/255.0 alpha:1.0];
}

+ (UIColor *)colorInitialButton
{
	return [UIColor whiteColor];
}

////////////////////////////////////////////////

+ (UIColor *)colorReportCenterBackground
{
	return [UIColor colorWithRed:63.0/255.0 green:169.0/255.0 blue:245.0/255.0 alpha:0.33];
}

+ (UIColor *)colorReportCenterBackgroundWarning
{
	return [UIColor colorWithRed:255.0/255.0 green:34.0/255.0 blue:34.0/255.0 alpha:0.33];
}

+ (UIColor *)colorReportCenterText
{
	return [UIColor colorWithRed:44.0/255.0 green:65.0/255.0 blue:143.0/255.0 alpha:1.0];
}

+ (UIColor *)colorReportCenterTextWarning
{
	return [UIColor colorWithRed:227.0/255.0 green:6.0/255.0 blue:19.0/255.0 alpha:1.0];
}

////////////////////////////////////////////////

+ (UIColor *)colorWithColorID:(NSInteger)aColorID
{
	return [self colorWithColorID:aColorID withAlpha:0.7];
}

+ (UIColor *)colorWithColorID:(NSInteger)aColorID withAlpha:(CGFloat)anAlpha
{
	UIColor *result = [UIColor whiteColor];
	
	aColorID = aColorID % 5;
	switch (aColorID)
	{
		case kUKUserColorBlue:
			result = [UIColor colorWithRed:29.0/255.0 green:98.0/255.0 blue:240.0/255.0 alpha:anAlpha];
			break;
		case kUKUserColorRed:
			result = [UIColor colorWithRed:255.0/255.0 green:42.0/255.0 blue:104.0/255.0 alpha:anAlpha];
			break;
		case kUKUserColorYellow:
			result = [UIColor colorWithRed:255.0/255.0 green:205.0/255.0 blue:2.0/255.0 alpha:anAlpha];
			break;
		case kUKUserColorGreen:
			result = [UIColor colorWithRed:11.0/255.0 green:211.0/255.0 blue:24.0/255.0 alpha:anAlpha];
			break;
		case kUKUserColorPurple:
			result = [UIColor colorWithRed:198.0/255.0 green:67.0/255.0 blue:252.0/255.0 alpha:anAlpha];
			break;
		default:
			break;
	}
	
	return result;
}

////////////////////////////////////////////////

+ (UIColor *)colorUserPopoverSelection
{
	return [UIColor colorWithRed:200.0/255.0 green:240.0/255.0 blue:255.0/255.0 alpha:1.0];
}

@end
