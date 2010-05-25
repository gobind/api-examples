//
//  BaseWordnikService.h
//
//  Created by Tony Tam on 5/17/10.
//  Copyright 2010 Wordnik. All rights reserved.
//

#import "ApplicationConstants.h"

@interface BaseWordnikService : NSObject {
	// Called on the delegate when the request completes successfully
	SEL didFinishSelector;

	// Called on the delegate when the request fails
	SEL didFailSelector;

	int mode;
	int requestCount;
	id serviceCaller;
}
- (id)init:(NSString*)key;
- (void) handleResponse:(NSString*)res;
- (void) sendAsync:(NSString *)commandURL;
- (NSString*) sendSync:(NSString*)commandURL;

- (NSString*) sendSync:(NSString*)commandURL
			 postValue:(NSString*)postValue;


+ (void)setServer:(NSString *)newServer;

@property (assign) int mode;
@property (assign) id serviceCaller;

@end
