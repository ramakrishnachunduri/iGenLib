/*! 
 *  \brief     XMLReader.
 *  \details   Standalone XML reader class.
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

#import "XMLReader.h"

@implementation XMLReader
@synthesize delegate=_delegate;
@synthesize que,currentContent;
#pragma mark -
#pragma mark Public methods

-(NSDictionary*)dictionaryForXMLString:(NSString *)string
{
	return [self dictionaryForXMLString:string delegate:nil];
}

-(NSDictionary*)dictionaryForXMLString:(NSString *)string delegate:(id<XMLReaderDelegate>)xmlReaderDelegate
{
	self.delegate=xmlReaderDelegate;
	que = [[NSMutableArray alloc] init];
    currentContent = [[NSMutableString alloc] init];
    [que addObject:[NSMutableDictionary dictionary]];
	
	NSData *dt=[string dataUsingEncoding:NSASCIIStringEncoding];
	
    // Parse the XML
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:dt];
    
	parser.delegate = self;
    BOOL success = [parser parse];
    [parser release];
    
	// Return the stack's root dictionary on success
    if (success)
    {
        return  [que objectAtIndex:0];
    }
	
	return nil;
}

- (void)dealloc
{
    [que release];
    [currentContent release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSXMLParserDelegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	// get the last object from the stack
    NSMutableDictionary *parentNode = [que lastObject];
	
    // Create the child dictionary for the new element, and initilaize it with the attributes
    NSMutableDictionary *childNode = [NSMutableDictionary dictionary];
    //[childNode addEntriesFromDictionary:attributeDict];
	if([[attributeDict allKeys] count]>0)
	{
		[childNode setObject:attributeDict forKey:@"xmlTagAttributes"];
	}
	
	//if item already has the key it means that the content is an array but not a dictionary.
	
    id curValue = [parentNode objectForKey:elementName];
	if (curValue)
    {
        NSMutableArray *valArray = nil;
        if ([curValue isKindOfClass:[NSMutableArray class]])
        {
            valArray = (NSMutableArray *)curValue;
        }
        else
        {
            valArray = [NSMutableArray array];
            [valArray addObject:curValue];
            [parentNode setObject:valArray forKey:elementName];
        }
        
        // Add the new child dictionary to the array
        [valArray addObject:childNode];
    }
    else
    {
        [parentNode setObject:childNode forKey:elementName];
    }
	
    [que addObject:childNode];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    // Update the parent dict with text info
    NSMutableDictionary *currentDictionary = [que lastObject];
    
    // Set the text property
    if ([currentContent length] > 0)
    {
		currentContent=[NSMutableString stringWithString:[currentContent stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
		currentContent=[NSMutableString stringWithString:[currentContent stringByReplacingOccurrencesOfString:@"\t" withString:@""]];
		[currentDictionary setObject:currentContent forKey:@"xmlTagContent"];
        
		[currentContent release];
        currentContent = [[NSMutableString alloc] init];
    }
    [que removeLastObject];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // Build the text value
    [currentContent appendString:string];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
	NSLog(@"%@",parseError);
	//[self.delegate didFailWithError:parseError];
}

@end
