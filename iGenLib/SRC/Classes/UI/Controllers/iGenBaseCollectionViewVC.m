#import "iGenBaseCollectionViewVC.h"

@interface iGenBaseCollectionViewVC ()
{
	UICollectionView *_collectionView;
	NSMutableDictionary *_lastClickedIndexPaths;
}
@property(nonatomic,strong) NSMutableDictionary *lastClickedIndexPaths;
@end

@implementation iGenBaseCollectionViewVC
@synthesize lastClickedIndexPaths=_lastClickedIndexPaths;
@synthesize collectionView=_collectionView;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark collection view delegate and datasource

/**
 *  Reloads data in the passed collection view
 *  When same subclass has multiple collectionview's this does job
 *  @param collectionView Collection view in which data to be reloaded
 */
-(void)reloadDataInCollectionView:(UICollectionView*)collectionView
{
    collectionView.delegate=self;
    collectionView.dataSource=self;
    
    Class cellClass=[self classOrNibForReusingCellInCollectionView:collectionView];
    NSString *identifier=[self reuseIdentifierForCellInCollectionView:collectionView];
    
    NSString *nibPath=[[NSBundle mainBundle] pathForResource:NSStringFromClass(cellClass) ofType:@"nib"];
    if (nibPath)
    {
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:identifier];
    }
    else
    {
        [collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
    }
    
    
    [collectionView reloadData];
    
    collectionView.backgroundColor=self.view.backgroundColor;
}

/**
 *  Custom cell Class to use in collectionview
 *  If not overriden uses UICollectionViewCell
 *  @param collectionView collection view in which passed custom cell is targeted
 *
 *  @return UICollectionViewCell or its sub class
 */
-(Class)classOrNibForReusingCellInCollectionView:(UICollectionView *)collectionView
{
    return [UICollectionViewCell class];
}

/**
 *  Reusable idendfer for cell in CollectionView
 *  If not overridden the class name of custom cell or UICollectionViewCell is used
 *  Optional in the view is not having multiple collection views
 *  @param collectionView CollectionView the identified is targeted to
 *  @return reusable identifier for cell in collection view.
 */
-(NSString*)reuseIdentifierForCellInCollectionView:(UICollectionView*)collectionView;
{
    NSString *identifier=NSStringFromClass([self classOrNibForReusingCellInCollectionView:collectionView]);
    return identifier;
}

/**
 *  Notify subclass a cell is created for passed class or nib name
 *  Do further cell customizations here
 *  @param collectionView Collection view where cell is created
 *  @param collectionCell Cell which is created
 *  @param indexPath      indexpath for which cell is created for
 */
-(void)collectionView:(UICollectionView *)collectionView cellCreated:(UICollectionViewCell*)collectionCell atIndexPath:(NSIndexPath *)indexPath
{
    
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier=[self reuseIdentifierForCellInCollectionView:collectionView];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [self collectionView:collectionView cellCreated:cell atIndexPath:indexPath];
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 0;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

/**
 *  Adds a little padding at top and bottom of collection view
 *  @param collectionView Collection which the padding is needed for
 *
 *  @return height to be padding in collection view
 */
-(CGFloat)paddingAtTopAndBottomForCollectionView:(UICollectionView*)collectionView
{
    return 10.0f;
}


/**
 *  Adds a little padding at bottom of collection view , to be used in combination of above method
 *  @param collectionView Collection which the padding is needed for
 *
 *  @return height to be padding in bottom collection view
 */
-(CGFloat)paddingAtBottomForCollectionView:(UICollectionView*)collectionView
{
	return CGFLOAT_MAX;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]])
    {
        if(section==0)
        {
			return CGSizeMake(0, [self paddingAtTopAndBottomForCollectionView:collectionView]);
        }
    }
    
    return CGSizeZero;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]])
    {
		NSInteger sectionCount=[self numberOfSectionsInCollectionView:collectionView];
		if(sectionCount > 0 && section==sectionCount-1)
        {
			if([self paddingAtBottomForCollectionView:collectionView]!=CGFLOAT_MAX)
			{
				return CGSizeMake(0, [self paddingAtBottomForCollectionView:collectionView]);
			}
            return CGSizeMake(0, [self paddingAtTopAndBottomForCollectionView:collectionView]);
        }
    }
    
    return CGSizeZero;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]])
    {
        UICollectionViewFlowLayout *flowLayout=((UICollectionViewFlowLayout*)collectionView.collectionViewLayout);
        CGSize siz=flowLayout.itemSize;
        
        NSInteger noOfCols=[self collectionView:collectionView numberOfItemsInSection:indexPath.section];
        if(noOfCols==1)
        {
            siz.width=collectionView.frame.size.width-flowLayout.sectionInset.left-flowLayout.sectionInset.right;
        }
        
        return siz;
    }
    
    return CGSizeZero;
}

#pragma mark -
#pragma mark collection view indexpath handling

/**
 * Preserves passed indexpath for collection view
 * Useful when multiple collectionviews are there in same VC
 *  @param indexPath      indexpath to preserve, if nil passed old one removed
 *  @param collectionView collectionview where indexpath is triggered
 */
-(void)assignLastClickedIndexPath:(NSIndexPath*)indexPath forCollectionView:(UICollectionView*)collectionView
{
	NSString *key=[NSString stringWithFormat:@"%p",collectionView];
	if(indexPath==nil)
	{
		[self.lastClickedIndexPaths removeObjectForKey:key];
	}
	else
	{
		if(_lastClickedIndexPaths==nil)
		{
			self.lastClickedIndexPaths=[[NSMutableDictionary alloc] init];
		}
		NSIndexPath *newIp=[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
		[self.lastClickedIndexPaths setObject:newIp forKey:key];
	}
}

/**
 *  Retrieves preserved indexpath by assignLastClicked.... method
 *  @param collectionView Collection view on which indexpath should be retrieved
 *  @return indexpath object
 */
-(NSIndexPath*)lastClickedIndexPathInCollectionView:(UICollectionView*)collectionView
{
	NSString *key=[NSString stringWithFormat:@"%p",collectionView];
	return (NSIndexPath*)[self.lastClickedIndexPaths objectForKey:key];
}

#pragma mark -
#pragma mark Keyboard

-(void)keyboardDidAppearedAtTop:(CGFloat)keyTop
{
	CGRect colFrame=self.collectionView.frame;
	colFrame.size.height=keyTop;
	self.collectionView.frame=colFrame;
	
	NSIndexPath *indexPath=[self lastClickedIndexPathInCollectionView:self.collectionView];
	if(indexPath!=nil)
	{
		[self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
	}
	
	[super keyboardDidAppearedAtTop:keyTop];
}

-(void)keyboardDidDisappeared
{
	CGRect colFrame=self.collectionView.frame;
	colFrame.size.height=self.view.frame.size.height;
	self.collectionView.frame=colFrame;
	[super keyboardDidDisappeared];
}

#pragma mark -
@end