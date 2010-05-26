//
//  AccountService.m
//
//  Created by Tony Tam on 5/17/10.
//  Copyright 2010 Wordnik. All rights reserved.
//

#import "AccountService.h"

@implementation AccountService
- (void) logout {
	NSString *serviceURL = @"api/account.json";
    NSString *command = @"logout";
    NSString *commandURL = [NSString stringWithFormat:@"%@/%@/%@", SERVER, serviceURL, command];

	NSString *res = [self sendSync:commandURL];	
}

- (AuthenticationToken*) login:(NSString*)username
			password:(NSString*)pwd {
    NSString *serviceURL = @"api/account.json";
    NSString *command = [NSString stringWithFormat:@"authenticate/%@?password=%@", username,pwd];
    NSString *commandURL = [NSString stringWithFormat:@"%@/%@/%@", SERVER, serviceURL, command];

	NSString *res = [self sendSync:commandURL];
	NSDictionary *response = [res JSONValue];
	
	AuthenticationToken *token = [AuthenticationToken alloc];
	token = [token init:response];

	return token;
}

- (User*) getUser:(NSString *)username {
    NSString *serviceURL = @"api/account.json";
    NSString *command = @"user";
    NSString *commandURL = [NSString stringWithFormat:@"%@/%@/%@", SERVER, serviceURL, command];

	NSString *res = [self sendSync:commandURL];
	NSDictionary *response = [res JSONValue];
	
	User *user = [User alloc];
	user = [user init:response];
	
	return user;
}

@end
