//
//  XMLReader.m
//  BookMe
//
//  Created by Tsubasa on 10/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "XMLReader.h"
#define MAX_STORYS 30000
static NSUInteger parsedStoryCounter;

@implementation XMLReader

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	parsedStoryCounter = 0;
}

- (void)setDelegate:(id)delegate {
    delegate_ = delegate;
}

- (void)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error {
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:URL];
	// Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
	[parser setDelegate:self];
	// Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	[parser parse];
	
	
	NSError *parseError = [parser parserError];
	if (parseError && error) {
		*error = parseError;
	}
	[parser release];
}

- (void)parseXMLData:(NSData *)data parseError:(NSError **)error {
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
	// Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
	[parser setDelegate:self];
	// Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	[parser parse];
	NSError *parseError = [parser parserError];
	if (parseError && error) {
		*error = parseError;
	}
	[parser release];
}

- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict {
	if (qName) {
		elementName = qName;
	}
	// If the number of parsed storys is greater than MAX_STORYS, abort the parse.
	// Otherwise the application runs very slowly on the device.
	if (parsedStoryCounter >= MAX_STORYS) {
		[parser abortParsing];
	}
    if ( [elementName isEqualToString:@"Table"] ) {
		datas_ = [[NSMutableArray alloc] init];
	}
	if ( [elementName isEqualToString:@"Row"] ) {
		data_ = [[NSMutableArray alloc] init];
	}
    if ( [elementName isEqualToString:@"Data"] ) {
		string_ = [[NSMutableString alloc ] init];
	}
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
	if ( qName ) {
		elementName = qName;
	}
	if ( [elementName isEqualToString:@"Data"] ) {
        [data_ addObject:string_];
		[string_ release];
	}
	if ( [elementName isEqualToString:@"Row"] ) {
        [datas_ addObject:data_];
        [data_ release];
	}
	if ( [elementName isEqualToString:@"Table"] ) {
		[delegate_ parsingDidEnd:datas_];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if ( string_ ) {
		// If the current element is one whose content we care about, append 'string'
		// to the property that holds the content of the current element.
		[string_ appendString:string];
	}
}

- (void) dealloc
{
	if ( error_ ) {
		[error_ release];
	}
	if ( data_ ) {
		[data_ release];
	}
    if ( datas_ ) {
        [datas_ release];
    }
	[super dealloc];
}

@end
