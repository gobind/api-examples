//
//  User.m
//
//  Created by Tony Tam on 5/17/10.
//  Copyright 2010 Wordnik. All rights reserved.
//

#import "User.h"


@implementation User
@synthesize _id;
@synthesize username;
@synthesize email;
@synthesize displayname;

-  (User*) init:(NSDictionary*)response {
	self.email = [response objectForKey:@"email"];
	self.username = [response objectForKey:@"userName"];
	self._id = [response objectForKey:@"id"];
	
	if(email == nil || username == nil){
		return nil;
	}
	return self;
}

@end
