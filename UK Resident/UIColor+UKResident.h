//
//  UIColor+UKResident.h
//  UK Resident
//
//  Created by Sergey Shvedov on 02.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UKResident)

+ (UIColor *)colorNeedEdit;
+ (UIColor *)colorNotYetEdit;
+ (UIColor *)colorEdited;

+ (UIColor *)colorButtonCancelBackground;
+ (UIColor *)colorButtonCancelBackgroundHigligted;
+ (UIColor *)colorButtonCancelText;
+ (UIColor *)colorButtonCancelTextHigligted;

+ (UIColor *)colorButtonOkBackground;
+ (UIColor *)colorButtonOkBackgroundHigligted;
+ (UIColor *)colorButtonOkText;
+ (UIColor *)colorButtonOkTextHigligted;

+ (UIColor *)colorButtonNeedEditOkBackground;
+ (UIColor *)colorButtonNeedEditOkBackgroundHigligted;
+ (UIColor *)colorButtonNeedEditOkText;
+ (UIColor *)colorButtonNeedEditOkTextHigligted;

+ (UIColor *)colorCalendarWorkDay;
+ (UIColor *)colorCalendarWeekend;
+ (UIColor *)colorCalendarWarningDay;

+ (UIColor *)colorDiagramTripView;
+ (UIColor *)colorDiagramWarningView;

+ (UIColor *)colorLeftGraphMain;
+ (UIColor *)colorLeftGraphBackground;
+ (UIColor *)colorRightGraphMain;
+ (UIColor *)colorRightGraphBackground;

+ (UIColor *)colorInitialButtonSetted;
+ (UIColor *)colorInitialButton;

+ (UIColor *)colorReportCenterBackground;
+ (UIColor *)colorReportCenterBackgroundWarning;
+ (UIColor *)colorReportCenterText;
+ (UIColor *)colorReportCenterTextWarning;

+ (UIColor *)colorWithColorID:(NSInteger)aColorID;
+ (UIColor *)colorWithColorID:(NSInteger)aColorID withAlpha:(CGFloat)anAlpha;

@end
