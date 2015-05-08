//
//  GraphRoundView.h
//  UK Resident
//
//  Created by Sergey Shvedov on 08.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphRoundView : UIView

- (instancetype)initWithSegment:(CGFloat)aPercent withFrame:(CGRect)aFrame withBackgrondColor:(UIColor *)aBackgroundColor andMainColor:(UIColor *)aMainColor;

@end
