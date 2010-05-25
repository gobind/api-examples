//
//  AuthenticationToken.m
//
//  Created by Tony Tam on 5/17/10.
//  Copyright 2010 Wordnik. All rights reserved.
//

#import "AuthenticationToken.h"

@implementation AuthenticationToken
@synthesize token;

- (AuthenticationToken*) init:(NSDictionary*)response {
	self.token = [response objectForKey:@"token"];
	if(token == nil){
		return nil;
	}
	return self;
}
@end
