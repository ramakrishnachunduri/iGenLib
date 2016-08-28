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

-(Class)classOrNibForReusingCellInCollectionView:(UICollectionView *)collectionView
{
    return [UICollectionViewCell class];
}

-(NSString*)reuseIdentifierForCellInCollectionView:(UICollectionView*)collectionView;
{
    NSString *identifier=NSStringFromClass([self classOrNibForReusingCellInCollectionView:collectionView]);
    return identifier;
}

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

-(CGFloat)paddingAtTopAndBottomForCollectionView:(UICollectionView*)collectionView
{
    return 10.0f;
}

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