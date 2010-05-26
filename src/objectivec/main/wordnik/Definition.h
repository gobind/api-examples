//
//  Definition.h
//
//  Created by Tony Tam on 5/17/10.
//  Copyright 2010 Wordnik. All rights reserved.
//

#import "PartOfSpeech.h"

@interface Definition : NSObject {
	NSString* text;
	NSString* extendedText;
	PartOfSpeech* partOfSpeech;
	
}

- (Definition*) init:(NSDictionary*)response;

@property (assign) NSString *text;
@property (assign) NSString *extendedText;
@property (assign) PartOfSpeech* partOfSpeech;

@end
