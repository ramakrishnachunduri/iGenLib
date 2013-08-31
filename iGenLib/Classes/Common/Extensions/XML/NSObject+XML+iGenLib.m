/*! 
 *  \brief     NSDictionary+iGenLib.
 *  \details   iGenLib XML Extensions for NSDictionary.
 *  \author    Rama Krishna Chunduri
 *  \date      3/22/11
 *	\copyright Codeworth 2011, All rights reserved.
 *  \n This file is part of iGenLib.
 *  \n 
 *  \n iGenLib is free software: you can redistribute it and/or modify
 *  \n it under the terms of the GNU General Public License as published by
 *  \n the Free Software Foundation, either version 3 of the License, or
 *  \n (at your option) any later version.
 *  \n 
 *  \n iGenLib is distributed in the hope that it will be useful,
 *  \n but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  \n MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  \n GNU General Public License for more details.
 *  \n 
 *  \n You should have received a copy of the GNU General Public License
 *  \n along with iGenLib.  If not, see <http://www.gnu.org/licenses/>.
 */

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