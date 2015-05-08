//
//  FormButton.h
//  MultiTest
//
//  Created by Administrator on 02.05.14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormButton : UIButton

@property (strong,nonatomic) UILabel *textLabel;
@property (strong,nonatomic) UILabel *backgroundLabel;
@property (nonatomic) BOOL isNeedEdit;
@property (nonatomic) BOOL isCancel;

- (void)setText:(NSString *)text withIsNeedEdit:(BOOL)isNeedEdit ansIsCancel:(BOOL)isCancel;

@end
