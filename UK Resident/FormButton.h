//
//  FormButton.h
//  MultiTest
//
//  Created by Administrator on 02.05.14.
//  Copyright (c) 2014-2015 Administrator. All rights reserved.
//

/*!
	@header FormButton.h
	@abstract Declares interface for FormButton.
	@copyright 2014-2015 Sergey Shvedov
*/

#import <UIKit/UIKit.h>

/*!
	@abstract The class provides the functionality to create a special button with animation effects.
*/
@interface FormButton : UIButton

@property (strong,nonatomic) UILabel *textLabel;
@property (strong,nonatomic) UILabel *backgroundLabel;
@property (nonatomic) BOOL isNeedEdit;
@property (nonatomic) BOOL isCancel;

- (void)setText:(NSString *)text withIsNeedEdit:(BOOL)isNeedEdit ansIsCancel:(BOOL)isCancel;

@end
