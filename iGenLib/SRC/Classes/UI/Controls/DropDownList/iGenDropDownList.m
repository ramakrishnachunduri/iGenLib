#import "iGenDropDownList.h"
#import "iGenPaddedLabel.h"
#import "UIColor+iGenLib.h"
#import "iGenTools.h"

@interface iGenDropDownList()
-(void)hideDropDown:(void(^)(void))done;
@end

@interface DDTransparentView:UIView
{
	CGRect holeRect;
}
@property(nonatomic,assign) iGenDropDownList *dropdown;
@end
@implementation DDTransparentView

-(id)initWithFrame:(CGRect)frame
{
	self=[super initWithFrame:frame];
	self.backgroundColor=[UIColor clearColor];
	return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if([touches.anyObject view]==self)
	{
		[self.dropdown hideDropDown:^{}];
	}
}

-(void)drawRect:(CGRect)rect
{
	UIColor *color=[[UIColor grayColor] colorWithAlphaComponent:0.5];
	
	CGRect lar=self.bounds;
	lar.size.height=holeRect.origin.y;
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context,color.CGColor);
	CGContextFillRect(context, lar);
	
	lar=self.bounds;
	lar.origin.y=holeRect.origin.y+holeRect.size.height;
	CGContextSetFillColorWithColor(context,color.CGColor);
	CGContextFillRect(context, lar);
	
	lar=self.bounds;
	lar.origin.y=holeRect.origin.y;
	lar.size.height=holeRect.size.height;
	lar.size.width=holeRect.origin.x;
	CGContextSetFillColorWithColor(context,color.CGColor);
	CGContextFillRect(context, lar);
	
	lar=self.bounds;
	lar.origin.y=holeRect.origin.y;
	lar.origin.x=holeRect.origin.x+holeRect.size.width;
	lar.size.height=holeRect.size.height;
	CGContextSetFillColorWithColor(context,color.CGColor);
	CGContextFillRect(context, lar);
	
	CGFloat f=self.dropdown.layer.cornerRadius/2;
	CGRect rct=CGRectInset(holeRect, f/2, f/2);
	CGContextSetStrokeColorWithColor(context, color.CGColor);
	UIBezierPath *bezierPath=[UIBezierPath bezierPathWithRect:rct];
	[bezierPath setLineWidth:f];
	[bezierPath stroke];
	
	[super drawRect:rect];
}

-(void)drawHoleAt:(CGRect)rect
{
	holeRect=rect;
	[self setNeedsDisplay];
}

@end

@interface iGenDropDownList()<UITableViewDataSource,UITableViewDelegate>
{
	CGFloat ddCellHeight;
	BOOL towardsBottom;
}
@property(nonatomic,strong) DDTransparentView *transparentView;
@property(nonatomic,strong) iGenPaddedLabel *label;
@property(nonatomic,retain) NSArray *dropDownValuesArray;
-(void)showDropDown;
@end

@implementation iGenDropDownList

-(void)setDefaults
{
	self.edgeInsets=UIEdgeInsetsMake(0, 10, 0, 10);
	self.font=[UIFont systemFontOfSize:15];
	self.backgroundColor=[UIColor whiteColor];
	self.textColor=[UIColor blackColor];
	self.listTextColor=[UIColor whiteColor];
	self.listBackgroundColor=[UIColor grayColor];
}

-(instancetype)init
{
	if(self=[super init])
	{
		[self setDefaults];
	}
	return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if(self=[super initWithCoder:aDecoder])
	{
		[self setDefaults];
	}
	return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
	if(self=[super initWithFrame:frame])
	{
		[self setDefaults];
	}
	return self;
}

#pragma mark Life cycle

-(void)createSubControls
{
	if(self.subviews.count==0)
	{
		CGRect rect=self.frame; rect.origin.y=0; rect.origin.x=0;
		
		self.label=[[[iGenPaddedLabel alloc] initWithFrame:rect] autorelease];
		self.label.backgroundColor=[UIColor clearColor];
		self.label.edgeInsets=self.edgeInsets;
		self.label.text=(self.placeHolder==nil)?self.value:self.placeHolder;
		self.label.font=self.font;
		self.label.textColor=(self.placeHolder==nil)?self.textColor:[self.textColor colorWithAlphaComponent:0.3];
		[self addSubview:self.label];
		
		CGRect bar=rect;
		bar.origin.y=bar.origin.y+(bar.size.height-2);
		bar.size.height=2;
		UIView *barView=[[UIView alloc] initWithFrame:bar];
		[self addSubview:barView];
		[barView release];
		
		rect.origin.x+=rect.size.width-rect.size.height;
		rect.size.width=rect.size.height;
		rect.origin.x-=self.edgeInsets.right;
		UILabel *lbl=[[UILabel alloc] initWithFrame:rect];
		lbl.text=@"▼";
		lbl.textAlignment=NSTextAlignmentRight;
		lbl.font=[UIFont systemFontOfSize:10];
		lbl.textColor=[UIColor grayColor];
		[self addSubview:lbl];
		[lbl release];
		
		UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
		self.transparentView=[[[DDTransparentView alloc] initWithFrame:window.bounds] autorelease];
		self.transparentView.dropdown=self;
	}
}

-(void)layoutSubviews
{
	[self createSubControls];
	[super layoutSubviews];
}

#pragma mark -

-(void)setValue:(id)value
{
	_value=value;
}

-(void)setDropDownValues:(NSString *)dropDownValues
{
	_dropDownValues=dropDownValues;
	if([dropDownValues containsString:@",,"])
	{
		self.dropDownValuesArray=[dropDownValues componentsSeparatedByString:@",,"];
	}
	else
	{
		self.dropDownValuesArray=[dropDownValues componentsSeparatedByString:strComma];
	}
	
	_value=self.dropDownValuesArray[0];
}

#pragma mark -
#pragma mark actions

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(self.willOpen) { self.willOpen(); }
	[self showDropDown];
	[super touchesEnded:touches withEvent:event];
}

-(void)showDropDown
{
	ddCellHeight=self.frame.size.height;
	self.transparentView.alpha=0;
	
	UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
	[window addSubview:self.transparentView];
	[window bringSubviewToFront:self.transparentView];
	CGPoint p = [self convertPoint:self.bounds.origin toView:window];
	CGFloat ht=(self.dropDownValuesArray.count*ddCellHeight);
	ht+=self.dropDownValuesArray.count*2;
	CGRect thisPlace={p.x,p.y,self.frame.size.width,self.frame.size.height};
	[self.transparentView drawHoleAt:thisPlace];
	
	CGRect rect;
	
	if(thisPlace.origin.y<[UIScreen mainScreen].bounds.size.height/2)
	{
		towardsBottom=YES;
		
		p.y+=self.frame.size.height;
		CGFloat maxHt=window.bounds.size.height-p.y;
		if(ht>maxHt)
		{
			CGFloat f=floor(maxHt/(ddCellHeight+2));
			f*=(ddCellHeight+2);
			ht=f;
		}
		
		rect=CGRectMake(p.x,p.y,self.frame.size.width,ht);
	}
	else
	{
		towardsBottom=NO;
		
		CGFloat y=p.y;
		CGFloat maxHt=y;
		if(ht>maxHt)
		{
			CGFloat f=floor(maxHt/(ddCellHeight+2));
			f*=(ddCellHeight+2);
			ht=f;
		}
		y=p.y-ht;
		rect=CGRectMake(p.x,y,self.frame.size.width,ht);
	}
	
	UITableView *v1=[[UITableView alloc] initWithFrame:CGRectMake(p.x, p.y,self.frame.size.width,0)];
	v1.delegate=self;
	v1.dataSource=self;
	v1.bounces=NO;
	v1.layer.borderWidth=1;
	v1.layer.borderColor=self.layer.borderColor;
	v1.layer.borderWidth=self.layer.borderWidth;
	v1.layer.cornerRadius=self.layer.cornerRadius;
	v1.separatorColor=[UIColor clearColor];
	[self.transparentView addSubview:v1];
	
	[UIView animateWithDuration:0.2 animations:^{
		v1.frame=rect;
		self.transparentView.alpha=1;
	}];
}

#pragma mark -
#pragma mark table view

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.dropDownValuesArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return ddCellHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	CGRect rect={0,0,tableView.frame.size.width,1};
	UIView *v=[[[UIView alloc] initWithFrame:rect] autorelease];
	v.backgroundColor=[UIColor colorFromHEX:@"#CCCCCC"];
	return v;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	CGRect rect={0,0,tableView.frame.size.width,1};
	UIView *v=[[[UIView alloc] initWithFrame:rect] autorelease];
	v.backgroundColor=[UIColor colorFromHEX:@"#CCCCCC"];
	return v;
}

-(void)hideDropDown:(void(^)(void))done
{
	UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
	CGPoint p = [self convertPoint:self.bounds.origin toView:window];
	if(towardsBottom) { p.y+=self.frame.size.height; }
	[UIView animateWithDuration:0.2 animations:^{
		UIView *v=self.transparentView.subviews[0];
		v.frame=CGRectMake(p.x, p.y, v.frame.size.width, 0);
		self.transparentView.alpha=0;
	} completion:^(BOOL finished) {
		[self.transparentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
		[self.transparentView removeFromSuperview];
		done();
	}];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	self.value=self.dropDownValuesArray[indexPath.section];
	
	[self hideDropDown:^{
		if(self.didChange){self.didChange(self.value);};
		self.label.text=self.value;
		self.label.textColor=self.textColor;
	}];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	cell.backgroundColor= self.listBackgroundColor;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *identifier=@"Cell";
	UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
	if(cell==nil)
	{
		cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									reuseIdentifier:identifier] autorelease];
	}
	cell.selectionStyle=UITableViewCellSelectionStyleNone;
	
	iGenPaddedLabel *label=nil;
	if([cell.contentView viewWithTag:5] == nil)
	{
		CGRect rct=cell.contentView.frame;
		rct.origin.y=0;
		label=[[[iGenPaddedLabel alloc] initWithFrame:rct] autorelease];
		label.edgeInsets=self.edgeInsets;
		label.textColor=self.listTextColor;
		label.backgroundColor=[UIColor clearColor];
		label.font=self.font;
		label.tag=5;
		[cell.contentView addSubview:label];
	}
	else
	{
		label=[cell.contentView viewWithTag:5];
	}
	label.text=self.dropDownValuesArray[indexPath.section];
	return cell;
}

#pragma mark -
@end