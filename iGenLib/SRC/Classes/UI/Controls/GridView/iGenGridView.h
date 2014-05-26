//
//  iGenGridView.h
//  iGenLib
//
//  Created by Rama Krishna Chunduri on 12/21/10.
//  Copyright 2010 Codeworth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "iGenGridViewDelegate.h"

@interface iGenGridView : UIScrollView <UIScrollViewDelegate>
{
	NSInteger _itemCount  ;
	NSInteger _pagesCount ;
	NSInteger _rowCount	  ;
	NSInteger _colCount	  ;
	UIPageControl *_pageControl;	
	id < iGenGridViewDelegate>  gridDelegate;
	NSInteger currentPageIndex;
}
@property(nonatomic,readonly) NSInteger itemCount;
@property(nonatomic,readonly) NSInteger pagesCount;
@property(nonatomic,readonly) NSInteger rowCount;
@property(nonatomic,readonly) NSInteger colCount;
@property(nonatomic,readonly) UIPageControl *pageControl;
@property(nonatomic,readonly) NSArray *pagesArray;

@property(nonatomic,assign)	NSInteger currentPageIndex;
@property(nonatomic,assign) id < iGenGridViewDelegate> gridDelegate;

-( iGenGridView*)initWithDelegate:(UIViewController*)delegatetoAssign;
-(void)reloadData;
@end
