//
//  MenuViewController.m
//  iGenLibSample
//
//  Created by Rama Krishna Chunduri on 4/20/11.
//  Copyright 2011 CodeWorth. All rights reserved.
//

#import "MenuViewController.h"
#import "GridViewViewController.h"
#import "MoveAndScaleVC.h"
#import "iGenXMLVC.h"
#import "iGenCommon.h"

@implementation MenuViewController
@synthesize menuItems,myTableView;

#pragma mark memory management methods

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

- (void)dealloc
{
	[menuItems release];
	[myTableView release];
	[super dealloc];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
	if(menuItems==nil)
	{
		NSString *mPath=[[NSBundle mainBundle] pathForResource:@"Main_Menu" ofType:@"plist"];
		menuItems=[[NSDictionary alloc] initWithContentsOfFile:mPath];
	}
	
	myTableView.dataSource=self;
	myTableView.delegate=self;
	[myTableView reloadData];
	
	[super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{	
	[super viewDidAppear:animated];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	[tableView removeBackground];
	
	if([self.menuItems isKindOfClass:[NSDictionary class]])
	{
		return ((NSDictionary*)self.menuItems).allKeys.count;
	}
	else if([self.menuItems isKindOfClass:[NSArray class]])
	{
		return 1;
	}
	
    return 0;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSString *heading=@"";
	
	if([self.menuItems isKindOfClass:[NSDictionary class]])
	{
		NSDictionary *x=(NSDictionary*)self.menuItems;
		heading=[x.allKeys objectAtIndex:section];
	}
	else if([self.menuItems isKindOfClass:[NSArray class]])
	{
		heading=@"";
	}
	
	return heading;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	NSInteger rowCnt=0;
	
	if([self.menuItems isKindOfClass:[NSDictionary class]])
	{
		NSDictionary *x=(NSDictionary*)self.menuItems;
		NSString *heading=[x.allKeys objectAtIndex:section];
		NSArray *items=[x objectForKey:heading];
		rowCnt=items.count;
	}
	else if([self.menuItems isKindOfClass:[NSArray class]])
	{
		NSArray *x=(NSArray*)self.menuItems;
		rowCnt=x.count;
	}
	
	return rowCnt;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
	
	NSDictionary *item=nil;
	
	if([self.menuItems isKindOfClass:[NSDictionary class]])
	{
		NSDictionary *x=(NSDictionary*)self.menuItems;
		NSString *heading=[x.allKeys objectAtIndex:indexPath.section];
		NSArray *items=[x objectForKey:heading];
		item=[items objectAtIndex:indexPath.row];
	}
	else if([self.menuItems isKindOfClass:[NSArray class]])
	{
		NSArray *x=(NSArray*)self.menuItems;
		item=[x objectAtIndex:indexPath.row];
	}
	
	if(item!=nil)
	{
		cell.textLabel.text=[item objectForKey:@"Title"];
   		cell.detailTextLabel.text=[item objectForKey:@"SubTitle"];
	}
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSDictionary *item=nil;
	
	if([self.menuItems isKindOfClass:[NSDictionary class]])
	{
		NSDictionary *x=(NSDictionary*)self.menuItems;
		NSString *heading=[x.allKeys objectAtIndex:indexPath.section];
		NSArray *items=[x objectForKey:heading];
		item=[items objectAtIndex:indexPath.row];
	}
	else if([self.menuItems isKindOfClass:[NSArray class]])
	{
		NSArray *x=(NSArray*)self.menuItems;
		item=[x objectAtIndex:indexPath.row];
	}
	
	if(item!=nil)
	{
		NSInteger UID=[[item objectForKey:@"UID"] integerValue];
		NSString *screenTitle=[item objectForKey:@"Title"];
		if([item objectForKey:@"SubItems"]!=nil)
		{
			MenuViewController *menuVC=[[MenuViewController alloc] init];
			menuVC.menuItems=[item objectForKey:@"SubItems"];
			menuVC.title=screenTitle;
			[self.navigationController pushViewController:menuVC animated:YES];
			[menuVC release];
		}
		else if(UID==1)
		{
			iGenXMLVC *rxvc=[[iGenXMLVC alloc] init];
			rxvc.title=screenTitle;
			[self.navigationController pushViewController:rxvc animated:YES];
			[rxvc release];
		}
		else if(UID==201)
		{
			GridViewViewController *gvc=[[GridViewViewController alloc] init];
			gvc.title=screenTitle;
			[self.navigationController pushViewController:gvc animated:YES];
			[gvc release];
		}
		else if(UID==202)
		{
			GridViewViewController *gvc=[[GridViewViewController alloc] init];
			gvc.isPagingEnabled=YES;
			gvc.title=screenTitle;
			[self.navigationController pushViewController:gvc animated:YES];
			[gvc release];
		}
		else if(UID==3)
		{
			MoveAndScaleVC *msvc=[[MoveAndScaleVC alloc] init];
			msvc.title=screenTitle;
			[self.navigationController pushViewController:msvc animated:YES];
			[msvc release];
		}
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
@end