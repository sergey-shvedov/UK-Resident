//
//  UKWarningTableHeaderView.h
//  UK Resident
//
//  Created by Sergey Shvedov on 17.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header UKWarningTableHeaderView.h
	@abstract Declares interface for UKWarningTableHeaderView.
	@copyright 2015 Sergey Shvedov
*/

#import <UIKit/UIKit.h>

/*!
	@abstract The class provides the functionality to update view.
*/
@interface UKWarningTableHeaderView : UIView

- (void)updateTitle:(NSString *)aTitle andDetails:(NSString *)aDetails;

@end
