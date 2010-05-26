//
//  PartOfSpeech.h
//
//  Created by Tony Tam on 5/17/10.
//  Copyright 2010 Wordnik. All rights reserved.
//


@interface PartOfSpeech : NSObject {
	NSString* name;
	id typeId;
}
- (PartOfSpeech*) init:(NSString*)response;

@property (assign) NSString *name;
@property (assign) id typeId;

@end
