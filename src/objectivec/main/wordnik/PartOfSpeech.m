//
//  PartOfSpeech.m
//
//  Created by Tony Tam on 5/17/10.
//  Copyright 2010 Wordnik. All rights reserved.
//

#import "PartOfSpeech.h"


@implementation PartOfSpeech
@synthesize name;
@synthesize typeId;

- (PartOfSpeech*) init:(NSString*)response {
	self.name = response;

	return self;
}

@end
