//
//  CALayer+RuntimeAttributes.m
//  UK Resident
//
//  Created by Sergey Shvedov on 02.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "CALayer+RuntimeAttributes.h"

@implementation CALayer (RuntimeAttributes)

- (void)setBorderUIColor:(UIColor*)color
{
	self.borderColor = color.CGColor;
}

- (UIColor*)borderUIColor
{
	return [UIColor colorWithCGColor:self.borderColor];
}

@end
