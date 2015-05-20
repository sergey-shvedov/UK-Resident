//
//  UKUserTableCell.m
//  UK Resident
//
//  Created by Sergey Shvedov on 20.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKUserTableCell.h"

@interface UKUserTableCell ()

@property (weak, nonatomic) IBOutlet UIView *iconBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (strong, nonatomic) UIColor *iconBackgroundColor;

@end

@implementation UKUserTableCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
	[self.iconBackgroundView setBackgroundColor:self.iconBackgroundColor];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
	[super setHighlighted:highlighted animated:animated];
	[self.iconBackgroundView setBackgroundColor:self.iconBackgroundColor];
}

- (void)placeTitle:(NSString *)aTitle
{
	[self.title setText:aTitle];
}

- (void)placeIconColor:(UIColor *)aColor
{
	self.iconBackgroundColor = aColor;
	[self.iconBackgroundView setBackgroundColor:aColor];
}

@end
