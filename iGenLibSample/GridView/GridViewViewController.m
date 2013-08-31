//
//  GridViewViewController.m
//  GridView
//

#import "GridViewViewController.h"
#import "GridViewItem.h"

@interface GridViewViewController()
@property(nonatomic,retain)	iGenGridView *gridView;
@end

@implementation GridViewViewController
@synthesize titles,images,isPagingEnabled,gridView;

#pragma mark memory management

- (void)dealloc
{
	[titles release];
	[images release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark VC LifeCycle methods

-(void)viewDidLoad
{	
	titles=[[NSMutableArray alloc] init];
	images=[[NSMutableArray alloc] init];
	
	NSArray *paths=[[[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"GVpics"] alphabeticallySortedArray];
	
	UIDevice* thisDevice = [UIDevice currentDevice];
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        // iPad - Reque again to Fit compartment
		paths=[paths arrayByAddingObjectsFromArray:paths];
    }
    else
    {
		
    }
	
	for(NSString *path in paths)
	{
		NSString *image=[[path componentsSeparatedByString:@".app/"] lastObject];
		[self.images addObject:image];
		NSString *titleText=[[path componentsSeparatedByString:@"/"] lastObject];
		titleText=[[titleText stringByReplacingOccurrencesOfString:@".png" withString:@""] capitalizedString];
		[self.titles addObject:titleText];
	}
	
	self.view.backgroundColor=[UIColor lightGrayColor];
}

- (void)viewDidAppear:(BOOL)animated
{
	gridView=[[iGenGridView alloc] initWithDelegate:self];
	[gridView setFrame:self.view.frame];
	gridView.pagingEnabled=self.isPagingEnabled;
	gridView.backgroundColor=[UIColor lightGrayColor];
	[self.view addSubview:gridView];
	[gridView reloadData];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

-(void)doRotation
{
	[gridView setFrame:self.view.frame];
	[gridView reloadData];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[self performSelector:@selector(doRotation) withObject:nil afterDelay:duration];
}

#pragma mark -
#pragma mark grid view methods

-(NSInteger)numberOfItemsInGridView:(iGenGridView*)gridview
{
	return [self.titles count];
}

-(NSInteger)numberOfRowsInGridView:(iGenGridView*)gridview
{
	int cnt;
	
	if (UIDeviceOrientationIsLandscape([self interfaceOrientation]))
	{
		cnt=([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)?5:3;
	}
	else
	{
		cnt=([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)?6:4;
	}

	return cnt;
}

-(NSInteger)numberOfColsInGridView:(iGenGridView*)gridview
{
	int cnt;
	
	if (UIDeviceOrientationIsLandscape([self interfaceOrientation]))
	{
		cnt=([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)?6:4;
	}
	else
	{
		cnt=([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)?5:3;
	}
	
	return cnt;
}

-(void)gridView:(iGenGridView *)gridView customizePage:(UIView *)pageView atIndex:(NSInteger)pageIndex
{
	pageView.backgroundColor=[UIColor lightGrayColor];
}

-(UIView*)gridView:(iGenGridView *)gridView viewForItemAtIndex:(NSInteger)index
{
	GridViewItem *gvi=(GridViewItem *)[[[NSBundle mainBundle] loadNibNamed:@"GridViewItem" owner:self options:nil] objectAtIndex:0];
	gvi.imageView.image=[UIImage imageNamed:[self.images objectAtIndex:index]];
	gvi.label.text=[self.titles objectAtIndex:index];
	gvi.backgroundColor=[UIColor clearColor];
	return gvi;
}

-(void)gridView:(iGenGridView *)gridView didSelectItem:(UIView *)view AtIndex:(NSInteger)index
{
	[[[[UIAlertView alloc] initWithTitle:@"GridView" message:[self.titles objectAtIndex:index] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil] autorelease] show];	
}
#pragma mark -
@end