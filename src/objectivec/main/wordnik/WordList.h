//
//  WordList.h
//
//  Created by Tony Tam on 5/17/10.
//  Copyright 2010 Wordnik. All rights reserved.
//


@interface WordList : NSObject {
	NSString* name;
	NSString* description;
	NSString* permalinkId;

	long _id;
}
- (WordList*) init:(NSDictionary*)response;

@property (copy) NSString *name;
@property (retain) NSString *description;
@property (nonatomic, retain) NSString *permalinkId;
@property (assign) long _id;

@end
