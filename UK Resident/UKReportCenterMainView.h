//
//  UKReportCenterMainView.h
//  UK Resident
//
//  Created by Sergey Shvedov on 02.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header UKReportCenterMainView.h
	@abstract Declares interface for UKReportCenterMainView.
	@copyright 2015 Sergey Shvedov
*/

#import <UIKit/UIKit.h>

@class UKReportCenterMainView;

@protocol UKReportCenterMainViewDelegate <NSObject>

- (void)mainView:(UKReportCenterMainView *)aMainView layoutToFullVersion:(BOOL)isFullVersion;

@end

/*!
	@abstract The class provides the functionality to inform their delegate about a layout event.
*/
@interface UKReportCenterMainView : UIView

@property (nonatomic, weak) id<UKReportCenterMainViewDelegate> delegate;

@end
