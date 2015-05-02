//
//  UKTripAddFormViewController.h
//  UK Resident
//
//  Created by Sergey Shvedov on 02.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormButton.h"

@protocol UKTripAddFormViewControllerDelegate <NSObject>

- (void)appearButtons;
- (void)dismissButtons;

@end

@interface UKTripAddFormViewController : UIViewController

@property BOOL isCreating;
@property (strong,nonatomic) FormButton *buttonOk;
@property (strong,nonatomic) FormButton *buttonCancel;

@end
