//
//  UKUserTableCell.h
//  UK Resident
//
//  Created by Sergey Shvedov on 20.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header UKUserTableCell.h
	@abstract Declares interface for UKUserTableCell.
	@copyright 2015 Sergey Shvedov
*/

#import <UIKit/UIKit.h>

/*!
	@abstract The class provides the functionality to present data in a custom cell.
*/
@interface UKUserTableCell : UITableViewCell

- (void)placeTitle:(NSString *)aTitle;
- (void)placeIconColor:(UIColor *)aColor;
- (void)placeTagToDelailButton:(NSInteger)aButtonTag;

@end
