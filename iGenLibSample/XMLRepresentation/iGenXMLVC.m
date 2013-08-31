//
//  iGenXMLVC.m
//  iLib
//
//  Created by Krish on 08/02/11.
//  Copyright 2011 CSS. All rights reserved.
//

#import "iGenXMLVC.h"

@implementation iGenXMLVC
@synthesize shrxml;
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{	
	[super viewDidLoad];
}
-(IBAction)startXMLtoDic
{
	XMLReader *test=[[XMLReader alloc] init];
	NSDictionary *dic=[test dictionaryForXMLString:self.shrxml];
	NSLog(@"%@,%@",dic,[dic BuildXMLRepresentation]);
	[test release];
}

-(IBAction)startDicToXML
{
	NSMutableDictionary *profile=[[NSMutableDictionary alloc] init];
	[profile setObject:@"Rama" forKey:@"FirstName"];
	[profile setObject:@"Krishna" forKey:@"LastName"];
	[profile setObject:@"Chunduri" forKey:@"Initial"];
	[profile setObject:@"testuser" forKey:@"username"];
	NSArray *keys = [NSArray arrayWithObjects:@"username",@"password" ,@"website",@"Profile",nil];
	NSArray *objects = [NSArray arrayWithObjects:@"RamaKrishna",@"Mypassword", @"<![CDATA[ http://codeworth.com ]]>",profile,nil];
	NSMutableDictionary *user = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
	[profile release];
	
	NSMutableDictionary *userDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObject:user] forKeys:[NSArray arrayWithObject:@"User"]];
	
	self.shrxml=[userDic BuildXMLRepresentationWithDelegate:self];
	NSLog(@"%@",self.shrxml);
}

-(id)attribsForNode:(NSString *)key atLevel:(NSInteger)level
{
	if([key isEqualToString:@"username"])
	{
		if(level==1)
		{
			return [NSString stringWithFormat:@"type=\"string\" level=\"%d\"",level];
		}
		else
		{
			return [NSString stringWithFormat:@"level=\"%d\"",level];
		}

	}
	else if([key isEqualToString:@"username"])
		return [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"SHA",@"*",nil] forKeys:[NSArray arrayWithObjects:@"Encoding",@"Hider",nil]];
	return @"";
}
-(NSString*)BuildXMLRepresentationForObject:(id)obj
{ 
	if([obj isKindOfClass:[NSArray class]])
	{
		NSString *xml=@"";
		for(NSDictionary *v in (NSArray*)obj)
		{
			xml=[xml stringByAppendingString:[v BuildXMLRepresentationWithDelegate:self]];
		}
		return xml;
	}
	return nil;
}

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

- (void)viewDidUnload {}

- (void)dealloc { [super dealloc]; }

@end
