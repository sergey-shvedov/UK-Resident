//
//  UIColor+UKResident.m
//  UK Resident
//
//  Created by Sergey Shvedov on 02.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UIColor+UKResident.h"

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

@end
