//
//  WordList.m
//
//  Created by Tony Tam on 5/17/10.
//  Copyright 2010 Wordnik. All rights reserved.
//

#import "WordList.h"

@implementation WordList
@synthesize name;
@synthesize description;
@synthesize permalinkId;
@synthesize _id;

-  (WordList*) init:(NSDictionary*)response {
	name = [[response objectForKey:@"name"] retain];
	description = [[response objectForKey:@"description"] retain];
	permalinkId = [[response objectForKey:@"permalinkId"] retain];

	return self;
}

@end
