//
//  GraphRoundView.h
//  UK Resident
//
//  Created by Sergey Shvedov on 08.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header GraphRoundView.h
	@abstract Declares interface for GraphRoundView.
	@copyright 2015 Sergey Shvedov
*/

#import <UIKit/UIKit.h>

/*!
	@abstract The class provides the functionality to create a view with a round chart.
*/
@interface GraphRoundView : UIView

- (instancetype)initWithSegment:(CGFloat)aPercent withFrame:(CGRect)aFrame withBackgrondColor:(UIColor *)aBackgroundColor andMainColor:(UIColor *)aMainColor;

@end
