//
//  CALayer+RuntimeAttributes.h
//  UK Resident
//
//  Created by Sergey Shvedov on 02.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header CALayer+RuntimeAttributes.h
	@abstract Declares interface for CALayer+RuntimeAttributes.
	@copyright 2015 Sergey Shvedov
 */

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

/*!
	@abstract The category provides the functionality to change a border color in Runtime.
*/
@interface CALayer (RuntimeAttributes)

@property(nonatomic, assign) UIColor* borderUIColor;

@end
