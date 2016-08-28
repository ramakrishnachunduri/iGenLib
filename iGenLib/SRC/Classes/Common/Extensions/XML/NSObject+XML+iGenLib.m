#import "NSObject+XML+iGenLib.h"

@implementation NSDictionary (XMLBuilder)
-(NSString*)BuildXMLRepresentation
{
	return [self BuildXMLRepresentationWithDelegate:nil inLevel:0];
}

-(NSString*)BuildXMLRepresentationWithDelegate:(id<XMLBuilderDelegate>) delegate
{
	return [self BuildXMLRepresentationWithDelegate:delegate inLevel:0];
}

-(NSString*)BuildXMLRepresentationWithDelegate:(id<XMLBuilderDelegate>) delegate inLevel:(NSInteger)level
{
	NSString *xml=@"";
	NSString *tabs=@"	";
	NSString *tabsBE=@"";
	for(int i=0;i<level;i++)
	{
		tabs=[tabs stringByAppendingString:@"	"];
		tabsBE=[tabsBE stringByAppendingString:@"	"];
	}
	
	if([[self allKeys] count]<3)
	{
		NSString *value=@"";
		NSString *attbs=@"";
		
		for(NSString *k in [self allKeys])
		{
			if([k isEqualToString:@"xmlTagContent"])
			{
				value=[self objectForKey:k];
			}
			else if([k isEqualToString:@"xmlTagAttributes"])
			{
				attbs=[self objectForKey:k];
			}
			xml=[xml stringByAppendingFormat:@"%@<%@%@>\n%@%@\n%@</%@>",tabsBE,k,attbs,tabs,value,tabsBE,k];
		}
		return xml;
	}
	
	
	id value;
	NSEnumerator *i = [self keyEnumerator];
	NSString *XMLkey;
	while ((XMLkey = [i nextObject])) 
	{
		NSString *attbs=@"";
		value = [self objectForKey:XMLkey];
		
		if(delegate!=nil)
		{
			if([delegate respondsToSelector:@selector(attribsForNode:atLevel:)])
			{
				id att=[delegate attribsForNode:XMLkey atLevel:level];
				if([att isKindOfClass:[NSString class]])
				{
					if(![(NSString*)att isEqualToString:@""])
						attbs=[@" " stringByAppendingString:att];
				}
				else if([att isKindOfClass:[NSDictionary class]])
				{
					for(NSString *attrib in [(NSDictionary*)att allKeys])
					{
						attbs=[attbs stringByAppendingFormat:@" %@=\"%@\"",attrib,[(NSDictionary*)att objectForKey:attrib]];
					}
				}
				else
				{
					NSLog(@"Invalid Attribute Specifier");
				}
			}
		}
		
		NSString *NLEnd=([[self allKeys] lastObject]==XMLkey)?@"":@"\n";
		if ([value isKindOfClass:[NSDictionary class]]) 
		{	
			NSString *childxml=[(NSMutableDictionary*)value BuildXMLRepresentationWithDelegate:delegate inLevel:level+1];
			xml=[xml stringByAppendingFormat:@"<%@%@>\n%@\n%@</%@>%@",XMLkey,attbs,childxml,tabsBE,XMLkey,NLEnd];
		}
		else 
		{
			if([delegate respondsToSelector:@selector(BuildXMLRepresentationForObject:)])
			{
				NSString *x=[delegate BuildXMLRepresentationForObject:value];
				if(x!=nil)
				{
					value=x;
				}
			}	
			xml=[xml stringByAppendingFormat:@"%@<%@%@>\n%@%@\n%@</%@>%@",tabsBE,XMLkey,attbs,tabs,value,tabsBE,XMLkey,NLEnd];
		}
	}
	return xml;
}
@end