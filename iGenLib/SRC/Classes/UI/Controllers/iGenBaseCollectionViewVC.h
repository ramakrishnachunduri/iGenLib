#import <UIKit/UIKit.h>
#import "iGenBaseVC.h"

/*!
 * \brief		iGenBaseCollectionViewVC
 * \details		A subclass of iGenBaseVC added up with collectionview handy methods.\n \n
 * 	This file is part of iGenLib. iGenLib is comprehensive library that provide a common way to integrate and reuse the components across other iOS apps
 * \n
 * \n			This class does following stuff
 *				- Collection view handling.
 *					- Custom cell loading
 *					- Last Clicked indexpath handling
 *				- Does everything iGenBaseVC can do.
 *
 *
 * \author		Rama Krishna Chunduri
 * \date		24th December 2014
 * \copyright	CodeWorth 2014, All rights reserved.
 * @ingroup		UI-Controllers
 */
@interface iGenBaseCollectionViewVC : iGenBaseVC <UICollectionViewDataSource,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
}

#pragma mark collection view delegate and datasource

/**
 *  An outlet which subclasse nib's collectionview have to be linked to
 */
@property(nonatomic,strong) IBOutlet UICollectionView *collectionView;

/**
 *  Reloads data in the passed collection view
 *  When same subclass has multiple collectionview's this does job
 *  @param collectionView Collection view in which data to be reloaded
 */
-(void)reloadDataInCollectionView:(UICollectionView*)collectionView;

/**
 *  Custom cell Class to use in collectionview
 *  If not overriden uses UICollectionViewCell
 *  @param collectionView collection view in which passed custom cell is targeted
 *
 *  @return UICollectionViewCell or its sub class
 */
-(Class)classOrNibForReusingCellInCollectionView:(UICollectionView*)collectionView;

/**
 *  Reusable idendfer for cell in CollectionView
 *  If not overridden the class name of custom cell or UICollectionViewCell is used
 *  Optional in the view is not having multiple collection views
 *  @param collectionView CollectionView the identified is targeted to
 *  @return reusable identifier for cell in collection view.
 */
-(NSString*)reuseIdentifierForCellInCollectionView:(UICollectionView*)collectionView;

/**
 *  Notify subclass a cell is created for passed class or nib name
 *  Do further cell customizations here
 *  @param collectionView Collection view where cell is created
 *  @param collectionCell Cell which is created
 *  @param indexPath      indexpath for which cell is created for
 */
-(void)collectionView:(UICollectionView *)collectionView cellCreated:(UICollectionViewCell*)collectionCell atIndexPath:(NSIndexPath *)indexPath;

/**
 *  Adds a little padding at top and bottom of collection view
 *  @param collectionView Collection which the padding is needed for
 *
 *  @return height to be padding in collection view
 */
-(CGFloat)paddingAtTopAndBottomForCollectionView:(UICollectionView*)collectionView;


/**
 *  Adds a little padding at bottom of collection view , to be used in combination of above method
 *  @param collectionView Collection which the padding is needed for
 *
 *  @return height to be padding in bottom collection view
 */
-(CGFloat)paddingAtBottomForCollectionView:(UICollectionView*)collectionView;

#pragma mark -
#pragma mark collection view indexpath handling

/**
 * Preserves passed indexpath for collection view
 * Useful when multiple collectionviews are there in same VC
 *  @param indexPath      indexpath to preserve
 *  @param collectionView collectionview where indexpath is triggered
 */
-(void)assignLastClickedIndexPath:(NSIndexPath*)indexPath forCollectionView:(UICollectionView*)collectionView;

/**
 *  Retrieves preserved indexpath by assignLastClicked.... method
 *  @param collectionView Collection view on which indexpath should be retrieved
 *  @return indexpath object
 */
-(NSIndexPath*)lastClickedIndexPathInCollectionView:(UICollectionView*)collectionView;

#pragma mark -
@end