//
//  UKTripViewController.m
//  UK Resident
//
//  Created by Sergey Shvedov on 29.04.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKTripViewController.h"
#import "AppDelegate.h"
#import "UKNotifications.h"
#import "UKTripTableVC.h"
#import "UKTripAddFormViewController.h"
#import "UKLibraryAPI.h"

@interface UKTripViewController ()

@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UIView *emptyBackgroundView;

@end

@implementation UKTripViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.navigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBarIconTripSelected"];
	[self updateUI];
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center addObserver:self selector: @selector(updateUI) name: UKNotificationNeedUpdateUI object: nil];
}

- (void)dealloc
{
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center removeObserver:self];
}

- (void)updateUI
{
	
	UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Trip"];
	request.predicate = [NSPredicate predicateWithFormat:@"ANY tripsByUser.whoTravel == %@", library.currentUser];
	NSError *error;
	NSArray *trips = [library.managedObjectContext executeFetchRequest:request error:&error];
	if ([trips count])
	{
		[self.emptyBackgroundView setHidden:YES];
	}
	else
	{
		[self.emptyBackgroundView setHidden:NO];
	}
}

//- (void)dealloc
//{
//	[[NSNotificationCenter defaultCenter] removeObserver:self];
//}
//
//- (void)awakeFromNib
//{
//	[[NSNotificationCenter defaultCenter] addObserverForName:UKDatabaseAvailabilityNotification object:nil queue:nil usingBlock:^(NSNotification *note){
//		self.managedObjectContext=note.userInfo[UKDatabaseAvailabilityContext];
//	}];
//}

- (NSManagedObjectContext *)managedObjectContext
{
	return ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.destinationViewController isKindOfClass:[UKTripTableVC class]])
	{
		UKTripTableVC *triptvc=segue.destinationViewController;
		triptvc.managedObjectContext = self.managedObjectContext;
	}
	else
	{
		[super prepareForSegue:segue sender:sender];
	}
	if ([segue.identifier isEqualToString:@"Add Trip"]) {
		if ([segue.destinationViewController isKindOfClass:[UKTripAddFormViewController class]]) {
			UKTripAddFormViewController *tripAVC = segue.destinationViewController;
			//tripAVC.userEditingTrip=self.user;
			tripAVC.managedObjectContext=self.managedObjectContext;
			
			tripAVC.editingTrip = [TempTrip defaultTempTripInContext:self.managedObjectContext];
			tripAVC.isCreating = YES;
			//NSLog(@"TRIPAVC is Creating");
		}
	}
}

@end
