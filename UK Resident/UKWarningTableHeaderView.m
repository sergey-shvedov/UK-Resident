//
//  UKWarningTableHeaderView.m
//  UK Resident
//
//  Created by Sergey Shvedov on 17.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKWarningTableHeaderView.h"

@interface UKWarningTableHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation UKWarningTableHeaderView

- (void)updateTitle:(NSString *)aTitle andDetails:(NSString *)aDetails
{
	[self.titleLabel setText:aTitle];
	[self.detailLabel setText:aDetails];
}

@end
