//
//  Word.m
//
//  Created by Tony Tam on 5/17/10.
//  Copyright 2010 Wordnik. All rights reserved.
//

#import "Word.h"


@implementation Word

@synthesize wordstring;
@synthesize definition;
@synthesize _id;

-  (Word*) init:(NSDictionary*)response {
	self.wordstring = [response objectForKey:@"wordstring"];
	self._id = [[response objectForKey:@"id"]longValue];
	
	return self;
}

@end
