//
//  UKUserTableCell.h
//  UK Resident
//
//  Created by Sergey Shvedov on 20.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UKUserTableCell : UITableViewCell

- (void)placeTitle:(NSString *)aTitle;
- (void)placeIconColor:(UIColor *)aColor;
- (void)placeTagToDelailButton:(NSInteger)aButtonTag;

@end
