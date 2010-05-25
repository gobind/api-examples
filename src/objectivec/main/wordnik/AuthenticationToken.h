//
//  AuthenticationToken.h
//
//  Created by Tony Tam on 5/17/10.
//  Copyright 2010 Wordnik. All rights reserved.
//


@interface AuthenticationToken : NSObject {
	NSString* token;
}
@property (assign) NSString *token;
- (AuthenticationToken*) init:(NSDictionary*)response;

@end
