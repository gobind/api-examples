//
//  BaseWordnikService.m
//
//  Created by Tony Tam on 5/17/10.
//  Copyright 2010 Wordnik. All rights reserved.
//

#import "BaseWordnikService.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ApplicationConstants.h"

@implementation BaseWordnikService
@synthesize serviceCaller;
@synthesize mode;

static NSString *wordnikServer;
+ (NSString *)wordnikServer {
	return wordnikServer;
}

+ (void)setServer:(NSString *)newServer {
	wordnikServer = newServer;
}

static NSString *apiKey;
+ (NSString *)apiKey {
	return apiKey;
}

+ (void)setApiKey:(NSString *)newKey {
	apiKey = newKey;
}

- (NSString*) sendSync:(NSString*)commandURL{
	NSURL *url = [NSURL URLWithString:commandURL];
 	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	if(API_KEY){[request addRequestHeader:@"api_key" value:API_KEY];}	
	if(AUTH_TOKEN){[request addRequestHeader:@"auth_token" value:AUTH_TOKEN];}

	[request startSynchronous];
	NSError *error = [request error];
	if (!error) {
		NSString *response = [request responseString];
		return response;
	}
	return nil;
}

- (NSString*) sendSync:(NSString*)commandURL
			 postValue:(NSString*)postValue {
	NSURL *url = [NSURL URLWithString:commandURL];
 	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	if(API_KEY){[request addRequestHeader:@"api_key" value:API_KEY];}
	if(AUTH_TOKEN){[request addRequestHeader:@"auth_token" value:AUTH_TOKEN];}
	[request appendPostData:[postValue dataUsingEncoding:NSUTF8StringEncoding]];
	[request setRequestMethod:@"POST"];
	[request startSynchronous];
	NSError *error = [request error];
	if (!error) {
		NSString *response = [request responseString];
		return response;
	}
	int statusCode = [request responseStatusCode];
	NSString *statusMessage = [request responseStatusMessage];

	return nil;
}

- (void) sendAsync:(NSString *)commandURL
 didFinishSelector:(SEL)finishSelector
   didFailSelector:(SEL)failSelector {

    NSOperationQueue *queue = [[[NSOperationQueue alloc] init] autorelease];
    NSURL *url = [NSURL URLWithString:commandURL];
    ASIHTTPRequest *request = [[[ASIHTTPRequest alloc] initWithURL:url] autorelease];
	if(API_KEY){[request addRequestHeader:@"api_key" value:API_KEY];}	
	if(AUTH_TOKEN){[request addRequestHeader:@"auth_token" value:AUTH_TOKEN];}
    request.requestMethod = @"GET";
	request.defaultResponseEncoding = NSUTF8StringEncoding;

    [request setDelegate:self];
    [request setDidFinishSelector: @selector(finishSelector:)];
    [request setDidFailSelector: @selector(failSelector:)];
    [queue addOperation:request];
}

- (void) successMethod:(ASIHTTPRequest *) request {
	NSString *response = [NSString stringWithUTF8String:[[request responseString] UTF8String]];		
	[self handleResponse:response];
}

- (void) handleResponse:(NSString*)res {
	[self doesNotRecognizeSelector:_cmd];
}

@end
