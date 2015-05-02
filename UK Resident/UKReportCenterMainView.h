//
//  UKReportCenterMainView.h
//  UK Resident
//
//  Created by Sergey Shvedov on 02.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UKReportCenterMainView;

@protocol UKReportCenterMainViewDelegate <NSObject>

- (void)mainView:(UKReportCenterMainView *)aMainView layoutToFullVersion:(BOOL)isFullVersion;

@end

@interface UKReportCenterMainView : UIView

@property (nonatomic, weak) id<UKReportCenterMainViewDelegate> delegate;

@end
