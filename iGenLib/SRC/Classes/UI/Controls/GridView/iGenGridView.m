//
//  iGenGridView.m
//  iGenLib
//
//  Created by Rama Krishna Chunduri on 12/21/10.
//  Copyright 2010 Codeworth. All rights reserved.
//

#import "iGenGridView.h"
#import "iGenTools.h"

// declare page view
@interface iGenGridPageView : UIView
{
}
-(void)setPagePositionWithIndex:(NSInteger)pageIndex layout:(NSUInteger)layoutStyle;
@end

@implementation iGenGridPageView

-(void)dealloc
{
	NSLog(@"deallocated %@",self);
	[super dealloc];
}

-(void)setPagePositionWithIndex:(NSInteger)pageIndex layout:(NSUInteger)layoutStyle
{
	 iGenGridView *gridView=( iGenGridView*)[self superview];
	CGRect pageFrame=gridView.frame;
	if(layoutStyle==0)
	{
		pageFrame.origin.x=pageIndex*gridView.frame.size.width;
		pageFrame.size.width=gridView.frame.size.width;
		pageFrame.size.height=pageFrame.size.height-gridView.pageControl.frame.size.height;
	}
	else
	{
		pageFrame.origin.x=0;
		pageFrame.origin.y=pageIndex*gridView.frame.size.height;
		pageFrame.size.width=gridView.frame.size.width;
	}
	[self setFrame:pageFrame];
}

@end

@interface iGenGridView (PRIVATE)
	-(void)pageIndexChanged:(UIPageControl*)pager;
	-(void)LoadPage:(NSInteger)index;
	-(void)layoutHorizontal;
	-(void)layoutVertical;
	-(void)clearData;
@end

@implementation iGenGridView
@synthesize itemCount=_itemCount;
@synthesize pagesCount=_pagesCount;
@synthesize rowCount=_rowCount;
@synthesize colCount=_colCount;
@synthesize pageControl=_pageControl;
@synthesize pagesArray;
@synthesize gridDelegate;
@synthesize currentPageIndex;

#pragma mark Read Only Property implementation

/* Calculates No.of.Items */
-(NSInteger)itemCount{
	if(_itemCount==0){
		_itemCount=[self.gridDelegate numberOfItemsInGridView:self];
	}return _itemCount;}

/* Calculates No.of.Pages */
-(NSInteger)pagesCount{
	if(_pagesCount==0){
		CGFloat v=self.itemCount;
		v=(v)/(self.rowCount*self.colCount);
		int pgcnt=(int)(v+0.5);
		_pagesCount=pgcnt;
	}return _pagesCount;}

/* Calculates No.of.Rows */
-(NSInteger)rowCount{
	if(_rowCount==0){
		_rowCount=[self.gridDelegate numberOfRowsInGridView:self];
	}return _rowCount;}

/* Calculates No.of.Columns */
-(NSInteger)colCount{
	if(_colCount==0){
		_colCount=[self.gridDelegate numberOfColsInGridView:self];
	}return _colCount;}

/* creates a unique instance of pager control */
-(UIPageControl*)pageControl{
	if(_pageControl==nil)
	{
		CGRect pagerFrame=self.frame;
		pagerFrame.origin.y=pagerFrame.size.height-20;
		pagerFrame.size.height=20;
		_pageControl=[[UIPageControl alloc] initWithFrame:pagerFrame];
		_pageControl.numberOfPages=self.pagesCount;
		[_pageControl addTarget:self action:@selector(pageIndexChanged:) forControlEvents:UIControlEventValueChanged];
	}return _pageControl;}


/* returns pageArray */
-(NSArray*)pagesArray
{
	NSMutableArray *pages=[[NSMutableArray alloc] init];
	for(UIView *page in [self subviews])
	{
		if([page isKindOfClass:[iGenGridPageView class]])
		{
			[pages addObject:page];
		}
	}
	NSArray *returnArray= [NSArray arrayWithArray:pages];
	[pages release];
	return returnArray;
}

#pragma mark Initializers
/* creates new object with passed delegate*/
-( iGenGridView*)initWithDelegate:(id)delegatetoAssign
{
	if(self=[super init])
	{
		self.gridDelegate=delegatetoAssign;
		self.pagingEnabled = YES;
		self.showsHorizontalScrollIndicator = NO;
	}
	return self;
}

#pragma mark Handle Pager
/* page index changed when user taps over the page control */
-(void)pageIndexChanged:(UIPageControl*)pager
{
	UIView *page=(UIView*)[self.pagesArray objectAtIndex:pager.currentPage];
	[self scrollRectToVisible:page.frame animated:YES];
}

#pragma mark Handle Scroll Based Paging
/* handles scroll */
-(void)scrollViewDidScroll:(UIScrollView *)SCV
{
	// move pager to current scroll position so that it will always be in same place
	CGRect pageControlFrame=self.pageControl.frame;
	pageControlFrame.origin.x=SCV.contentOffset.x;
	[self.pageControl setFrame:pageControlFrame];
	
	CGSize pageSize = self.frame.size;
	NSUInteger newPageIndex = (SCV.contentOffset.x + pageSize.width / 2) / pageSize.width;
	if(newPageIndex!=currentPageIndex)
	{
		self.pageControl.currentPage=newPageIndex;
		currentPageIndex=newPageIndex;
		[self LoadPage:newPageIndex];
	}
}

#pragma mark Handle touches
/* handle touched and invoke delegate */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSSet *controls=(NSSet *)[touches valueForKey:@"view"];
	for(UIView *control in [controls allObjects])
	{
		if([self.pagesArray indexOfObject:control]==NSNotFound) //user clicked on item not on empty space
		{
			// calculate item index to pass it wo delegate
			UIView *thisPage=[control superview];
			NSInteger itemIndex = 0;
			for(UIView *page in self.pagesArray)
			{
				if(page==thisPage) break; //stop counting if page is same page
				itemIndex+=[page.subviews count];
			}
			itemIndex+=[[thisPage subviews] indexOfObject:control];
			
			//invoke delegate method
			[self.gridDelegate gridView:self didSelectItem:control AtIndex:itemIndex];
		}
	}
}

#pragma mark Layout & Loading
/* loads page under passed index */
-(void)LoadPage:(NSInteger)pageIndex
{
	//dont load if passed index is out of available pages
	if(pageIndex>=[self.pagesArray count]) { return; }
	
	//get current page
	UIView *page=(UIView*)[self.pagesArray objectAtIndex:pageIndex];
	
	//do not load items if already loaded i.e., if scrolling back to loaded page
	if([[page subviews] count]>0) { return; }
	
	//calculate width and height for item
	CGFloat w=page.frame.size.width/self.colCount;
	CGFloat h=page.frame.size.height/self.rowCount;
	
	//add items to page
	int itemIndex=(self.rowCount*self.colCount)*pageIndex;
	for(int i=0;i<self.rowCount;i++)
	{
		for(int j=0;j<self.colCount;j++)
		{
			if(itemIndex==self.itemCount)
				break;
			UIView *item=[self.gridDelegate gridView:self viewForItemAtIndex:itemIndex];
		    item.frame=CGRectMake(j*w,i*h,w,h);
			[page addSubview:item];
			itemIndex++;
		}
	}
}

-(void)reloadData
{
	[self clearData];
	
	if(self.pagingEnabled)
	{
		[self layoutHorizontal];
	}
	else
	{
		[self layoutVertical];
	}
}

-(void)layoutHorizontal
{
	//set current page index to first page
	self.currentPageIndex=0;
	
	//hide scroll bar
	self.showsVerticalScrollIndicator = NO;
	
	//scroll view to first page
	[self setContentOffset:CGPointZero];
	[self setContentSize:CGSizeMake(self.frame.size.width*self.pagesCount,self.frame.size.height)];
	
	//set delegate
	self.delegate=self;
	
	//place pager in first page
	[self addSubview:self.pageControl];
	self.pageControl.currentPage=currentPageIndex;
	CGRect pagerFrame=self.pageControl.frame;
	pagerFrame.origin.x=0;
	self.pageControl.frame=pagerFrame;
	
	//show pager Control
	self.pageControl.hidden=NO;
	
	for(int i=0;i<self.pagesCount;i++)
	{
		iGenGridPageView *pageView=[[iGenGridPageView alloc] init];
		[self addSubview:pageView];
		[pageView setPagePositionWithIndex:i layout:0];
		[self.gridDelegate gridView:self customizePage:pageView atIndex:i];
		[pageView release];
	}
	
	//load first page
	[self LoadPage:currentPageIndex];
}

-(void)layoutVertical
{
	//remove delegate
	self.delegate=nil;
	
	//set current page index
	self.currentPageIndex=0;
	
	//scroll to first page
	[self setContentOffset:CGPointZero];
	[self setContentSize:CGSizeMake(self.frame.size.width,self.frame.size.height*self.pagesCount)];
	
	//place pager in first page
	[self addSubview:self.pageControl];
	self.pageControl.currentPage=currentPageIndex;
	CGRect pagerFrame=self.pageControl.frame;
	pagerFrame.origin.x=0;
	self.pageControl.frame=pagerFrame;
	
	//add vertical scroll
	self.showsVerticalScrollIndicator = YES;
	
	//hide pager as it is not needed in vertical mode
	self.pageControl.hidden=YES;
	
	//change scrollbar color
	for(UIView *view in [self subviews])
	{
		if([view isKindOfClass:[UIImageView class]])
		{
			view.backgroundColor=[UIColor whiteColor];
		}
	}
	
	for(int i=0;i<self.pagesCount;i++)
	{
		iGenGridPageView *pageView=[[iGenGridPageView alloc] init];
		[self addSubview:pageView];
		[pageView setPagePositionWithIndex:i layout:1];
		[self.gridDelegate gridView:self customizePage:pageView atIndex:i];
		[self LoadPage:i];
		[pageView release];
	}	
}

/* clear data */
-(void)clearData
{
	[self.pageControl removeFromSuperview];
	RELEASE_SAFELY(_pageControl);
	
	_itemCount=0;
	_pagesCount=0;
	_rowCount=0;
	_colCount=0;
	
	for (UIView *v in self.pagesArray)
	{
		[v removeFromSuperview];
	}
}

- (void)dealloc
{
	[self clearData];
	NSLog(@"deallocated");
    [super dealloc];
}
@end
