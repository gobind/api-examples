//
//  User.h
//
//  Created by Tony Tam on 5/17/10.
//  Copyright 2010 Wordnik. All rights reserved.
//


@interface User : NSObject {
	id _id;
	NSString* username;
	NSString* email;
	NSString* displayname;
}

@property (assign) id _id;
@property (assign) NSString *username;
@property (assign) NSString *email;
@property (assign) NSString *displayname;

@end
