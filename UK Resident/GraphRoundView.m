//
//  GraphRoundView.m
//  UK Resident
//
//  Created by Sergey Shvedov on 08.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "GraphRoundView.h"

#define PERSENTS_TO_RADIANS(percent) (2. * (percent) * M_PI)

@implementation GraphRoundView

- (instancetype)initWithSegment:(CGFloat)aPercent withFrame:(CGRect)aFrame withBackgrondColor:(UIColor *)aBackgroundColor andMainColor:(UIColor *)aMainColor
{
	self = [super initWithFrame:aFrame];
	
	if (nil != self)
	{
		
		CGPoint center = CGPointMake(aFrame.origin.x + aFrame.size.width / 2, aFrame.origin.y + aFrame.size.height / 2);
		CGFloat delta = PERSENTS_TO_RADIANS(aPercent);
		CGFloat radius = aFrame.size.width / 2;
		
		//Background
		CALayer *bkgLayer = [CALayer layer];
		bkgLayer.frame = self.layer.bounds;
		bkgLayer.backgroundColor = [aBackgroundColor CGColor];
		CAShapeLayer *maskBkgLayer = [CAShapeLayer layer];
		maskBkgLayer.fillRule = kCAFillRuleEvenOdd;
		maskBkgLayer.frame = self.frame;
		
		CGMutablePathRef bkgPath = CGPathCreateMutable();
		CGPathAddPath(bkgPath, nil, CGPathCreateWithEllipseInRect(aFrame, nil));
		maskBkgLayer.path = bkgPath;
		bkgLayer.mask = maskBkgLayer;
		
		//MainGraph
		CALayer *imageLayer = [CALayer layer];
		imageLayer.frame = self.layer.bounds;
		imageLayer.backgroundColor = [aMainColor CGColor];
		CAShapeLayer *maskLayer = [CAShapeLayer layer];
		maskLayer.fillRule = kCAFillRuleEvenOdd;
		maskLayer.frame = self.frame;
		
		CGMutablePathRef graphPath = CGPathCreateMutable();
		CGPathMoveToPoint(graphPath, NULL, center.x, center.y);
		CGPathAddRelativeArc(graphPath, NULL, center.x, center.y, radius, -(M_PI / 2), delta);
		CGPathAddLineToPoint(graphPath, NULL, center.x, center.y);
		CGPathCloseSubpath(graphPath);
		maskLayer.path = graphPath;
		imageLayer.mask = maskLayer;
		

		[self.layer addSublayer:bkgLayer];
		[self.layer addSublayer:imageLayer];
	}
	
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	return [self initWithSegment:0. withFrame:frame withBackgrondColor:[UIColor blackColor] andMainColor:[UIColor whiteColor]];
}

- (instancetype)init
{
	return [self initWithSegment:0. withFrame:CGRectMake(0., 0., 50., 50.) withBackgrondColor:[UIColor blackColor] andMainColor:[UIColor whiteColor]];
}

@end
