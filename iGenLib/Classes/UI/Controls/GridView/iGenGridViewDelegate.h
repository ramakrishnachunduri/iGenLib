//
//  iGenGridViewDelegate.h
//  iGenLib
//
//  Created by Rama Krishna Chunduri on 12/21/10.
//  Copyright 2010 Codeworth. All rights reserved.
//
#import <UIKit/UIKit.h>

@class iGenGridView;

// declare delegate protocol
@protocol iGenGridViewDelegate<NSObject>
@required
-(NSInteger)numberOfItemsInGridView:( iGenGridView*)gridview;
-(NSInteger)numberOfRowsInGridView:( iGenGridView*)gridview;
-(NSInteger)numberOfColsInGridView:( iGenGridView*)gridview;
-(UIView*)gridView:( iGenGridView*)gridView viewForItemAtIndex:(NSInteger)index;
@optional
-(void)gridView:( iGenGridView*)gridView customizePage:(UIView*)pageView atIndex:(NSInteger)pageIndex;
-(void)gridView:( iGenGridView*)gridView didSelectItem:(UIView*)view AtIndex:(NSInteger)index;
@end