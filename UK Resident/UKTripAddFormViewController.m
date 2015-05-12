//
//  UKTripAddFormViewController.m
//  UK Resident
//
//  Created by Sergey Shvedov on 02.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKTripAddFormViewController.h"
#import "UKTripFormTableViewController.h"
#import "FormButton.h"

#define BUTTON_APPEAR_DURATION 0.6

@interface UKTripAddFormViewController ()<UKTripFormTVCDelegate>

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end

@implementation UKTripAddFormViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	//self.isCreating = YES;
	[self createButtonCancel];
	[self createButtonOk];
}

- (void)createButtonOk
{
	FormButton *button=[FormButton buttonWithType:UIButtonTypeCustom];
	[button setFrame:CGRectMake(275.0, 150.0, 265.0, 44.0)];
	
	if (self.isCreating)
	{
		[button setText:@"Создать" withIsNeedEdit:YES ansIsCancel:NO];
		[button addTarget:self action:@selector(clickOKForCreate:) forControlEvents:UIControlEventTouchUpInside];
	}else
	{
		[button setText:@"Сохранить" withIsNeedEdit:NO ansIsCancel:NO];
		[button addTarget:self action:@selector(clickOKForSave:) forControlEvents:UIControlEventTouchUpInside];
	}
	
	self.buttonOk=button;
	[self.view addSubview:self.buttonOk];
}

- (void)createButtonCancel
{
	FormButton *button=[FormButton buttonWithType:UIButtonTypeCustom];
	[button setFrame:CGRectMake(0.0, 150.0, 265.0, 44.0)];
	[button setText:@"Отменить" withIsNeedEdit:NO ansIsCancel:YES];
	[button addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];
	
	self.buttonCancel=button;
	[self.view addSubview:self.buttonCancel];
}

/////////////////////////////////////////
#pragma mark - Buttons action

- (IBAction)deleteTrip:(id)sender
{
	UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Удаление" message:@"Вы уверены, что хотите удалить это путешествие?" delegate:self cancelButtonTitle:@"Нет" otherButtonTitles:@"Да", nil];
	[alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if ([alertView.title isEqualToString:@"Удаление"] && (1 == buttonIndex)) {
		
		[self.editingTrip deleteTrip:self.trip InContext:self.managedObjectContext];
		
		//[self updateTodayView];
		//[self updateCalendarView];
		[self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
	}
	
}

- (void)clickOKForCreate:(id)sender
{
	if (YES == self.editingTrip.isNeedToEdit)
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Внимание!" message:@"Перед созданием нового путешествия необходимо заполнить все требуемые данные." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];
	}
	else
	{
		[self.editingTrip insertNewTripInContext:self.managedObjectContext];
	
//		[self updateTodayView];
//		[self updateCalendarView];
	
		[self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
	}
}
- (void)clickOKForSave:(id)sender
{
	if (self.editingTrip.isNeedToEdit)
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Внимание!" message:@"Перед сохранением путешествия необходимо отредактировать отмеченные данные." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];
	}
	else
	{
		[self.editingTrip updateDaysWithTrip:self.trip inContext:self.managedObjectContext];
//		[self updateTodayView];
//		[self updateCalendarView];
		[self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
	}
}
- (void)clickCancel:(id)sender
{
	    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)animateAppearsButton:(UIButton *)button
{
	button.alpha = 0.0;
	button.hidden = NO;
	[UIView animateWithDuration:BUTTON_APPEAR_DURATION animations:^{
		button.alpha = 1.0;
	}];
}

#pragma mark - UKTripFormTVCDelegate's methods

- (void)dismissButtons
{
	self.buttonOk.hidden = YES;
	self.buttonCancel.hidden = YES;
	
	self.deleteButton.hidden = YES;
}

- (void)appearButtons
{
	[self animateAppearsButton:self.buttonOk];
	[self animateAppearsButton:self.buttonCancel];
	
	[self animateAppearsButton:self.deleteButton];
}

- (void)changeNeedEditStatusTo:(BOOL)isNeedEdit
{
	self.buttonOk.isNeedEdit = isNeedEdit;
}

#pragma mark

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"Trip Form Segue"])
	{
		if ([segue.destinationViewController isKindOfClass:[UINavigationController class]])
		{
			UINavigationController *navc = (UINavigationController *)segue.destinationViewController;
			
			if ([[navc.viewControllers firstObject] isKindOfClass:[UKTripFormTableViewController class]])
			{
				UKTripFormTableViewController *tripTVC = (UKTripFormTableViewController *)[navc.viewControllers firstObject];
				tripTVC.delegate = self;
				tripTVC.managedObjectContect = self.managedObjectContext;
				tripTVC.trip = self.trip;
				tripTVC.editingTrip = self.editingTrip;
				tripTVC.isCreating = self.isCreating;
			}
		}
	}
}

- (BOOL)disablesAutomaticKeyboardDismissal
{
	return NO;
}

@end
