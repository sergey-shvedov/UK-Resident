//
//  UKUserEditVC.h
//  UK Resident
//
//  Created by Sergey Shvedov on 20.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UKUserEditVC : UIViewController

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger colorID;
@property (nonatomic, assign) BOOL isCreating;

@end
