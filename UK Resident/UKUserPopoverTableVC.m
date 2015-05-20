//
//  UKUserPopoverTableVC.m
//  UK Resident
//
//  Created by Sergey Shvedov on 20.05.15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "UKUserPopoverTableVC.h"
#import "UKLibraryAPI.h"
#import "UKUserTableCell.h"
#import "User.h"

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
		[cell placeIconColor:[UIColor blueColor]];
	}
	
	return cell;
}

@end
