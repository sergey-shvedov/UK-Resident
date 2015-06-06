//
//  UKReportTopDiagramVC.h
//  UK Resident
//
//  Created by Sergey Shvedov on 30.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header UKReportTopDiagramVC.h
	@abstract Declares interface for UKReportTopDiagramVC.
	@copyright 2015 Sergey Shvedov
*/

#import <UIKit/UIKit.h>

/*!
	@abstract The class provides the functionality to update the top element with the calendar diagram of the report screen.
*/
@interface UKReportTopDiagramVC : UIViewController

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDate *initialDate;

@end
