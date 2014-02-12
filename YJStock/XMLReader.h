//
//  XMLReader.h
//  BookMe
//
//  Created by Tsubasa on 10/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XMLReader
- (void)parsingDidEnd:(NSArray *)array;
@end

@interface XMLReader : NSObject<NSXMLParserDelegate> {
	NSMutableArray *data_;
    NSMutableArray *datas_;
	NSMutableDictionary *error_;
	NSMutableString *string_;
    id<XMLReader> delegate_;
}

- (void)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error;
- (void)parseXMLData:(NSData *)data parseError:(NSError **)error;
- (void)setDelegate:(id)delegate;
@end
