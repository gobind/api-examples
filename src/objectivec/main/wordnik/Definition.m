//
//  Definition.m
//
//  Created by Tony Tam on 5/17/10.
//  Copyright 2010 Wordnik. All rights reserved.
//

#import "Definition.h"


@implementation Definition
@synthesize text;
@synthesize extendedText;
@synthesize partOfSpeech;

-  (Definition*) init:(NSDictionary*)response {
	self.text = [response objectForKey:@"text"];
	self.extendedText = [response objectForKey:@"extendedText"];
	self.partOfSpeech = [[PartOfSpeech alloc] init:[response objectForKey:@"partOfSpeech"]];

	return self;
}
@end
