//
//  AccountService.h
//
//  Created by Tony Tam on 5/17/10.
//  Copyright 2010 Wordnik. All rights reserved.
//

#import "BaseWordnikService.h"
#import "AuthenticationToken.h"
#import "User.h"


@interface AccountService : BaseWordnikService {
		
}
- (AuthenticationToken*) login:(NSString*)username
					  password:(NSString*)pwd;
- (void) logout;
- (User*) getUser:(NSString*)username;

@end
