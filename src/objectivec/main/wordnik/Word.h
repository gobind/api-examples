//
//  Word.h
//
//  Created by Tony Tam on 5/17/10.
//  Copyright 2010 Wordnik. All rights reserved.
//

@interface Word : NSObject {
	NSString* wordstring;
	NSString* definition;
	long _id;
}

- (Word*) init:(NSDictionary*)response;

@property (assign) NSString *wordstring;
@property (assign) NSString *definition;
@property (assign) long _id;

@end
