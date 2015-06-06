//
//  UKUserEditVC.h
//  UK Resident
//
//  Created by Sergey Shvedov on 20.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

/*!
	@header UKUserEditVC.h
	@abstract Declares interface for UKUserEditVC.
	@copyright 2015 Sergey Shvedov
*/

#import <UIKit/UIKit.h>

/*!
	@abstract The class provides the functionality to edit a user element.
*/
@interface UKUserEditVC : UIViewController

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger colorID;
@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, assign) BOOL isCreating;

@end
