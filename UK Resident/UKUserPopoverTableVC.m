//
//  UKUserPopoverTableVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 20.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKUserPopoverTableVC.h"
#import "UKLibraryAPI.h"
#import "UKUserEditVC.h"
#import "UKUserTableCell.h"
#import "User.h"
#import "UIColor+UKResident.h"

@interface UKUserPopoverTableVC ()

@end

@implementation UKUserPopoverTableVC

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
	_managedObjectContext = managedObjectContext;
	
	//UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
	
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
	request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"userID" ascending:NO selector:@selector(compare:)]];
	
	self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self setClearsSelectionOnViewWillAppear:NO];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UKUserTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"User Cell"];
	
	if (nil != cell)
	{
		User *user=[self.fetchedResultsController objectAtIndexPath:indexPath];
		
		UIView *bgColorView = [[UIView alloc] init];
		[bgColorView setBackgroundColor:[UIColor yellowColor]];
		[cell setSelectedBackgroundView:bgColorView];
		
		[cell placeTitle:user.name];
		[cell placeIconColor:[UIColor colorWithColorID:[user.colorID integerValue]]];
		[cell placeTagToDelailButton:indexPath.row];
		
		UKLibraryAPI *library = [UKLibraryAPI sharedInstance];
		if ([library.currentUser.userID isEqualToNumber:user.userID])
		{
			[self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
		}
	}
	
	return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"Add User"])
	{
		if ([segue.destinationViewController isKindOfClass:[UKUserEditVC class]])
		{
			UKUserEditVC *userVC = (UKUserEditVC *)segue.destinationViewController;
			userVC.isCreating = YES;
			userVC.name = @"";
			userVC.colorID = 0;
			userVC.userID = 0;
		}
	}
	else if ([segue.identifier isEqualToString:@"Edit User"])
	{
		if ([segue.destinationViewController isKindOfClass:[UKUserEditVC class]])
		{
			UKUserEditVC *userVC = (UKUserEditVC *)segue.destinationViewController;
			
			if ([sender isKindOfClass:[UIButton class]])
			{
				NSInteger tagNumber = ((UIButton *)sender).tag;
				
				User *user =[self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:tagNumber inSection:0]];
				
				userVC.isCreating = NO;
				userVC.name = user.name;
				userVC.colorID = [user.colorID integerValue];
				userVC.userID = [user.userID integerValue];
			}
		}
	}
}

@end
