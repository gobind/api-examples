//
//  RandomWordService.m
//
//  Created by Tony Tam on 5/17/10.
//  Copyright 2010 Wordnik. All rights reserved.
//

#import "WordService.h"
#import "Word.h"

@implementation WordService

/**
 parameter-less call defaults to any random word
 **/
- (Word*) fetchRandomWord {
	return  [self fetchRandomWord:NO];
}

- (Word*) fetchRandomWord:(BOOL)onlyDictionaryWord {
    NSString *command = [NSString stringWithFormat:@"randomWord?hasDictionaryDef=%@", (onlyDictionaryWord?"true" : "false")];
    NSString *serviceURL = @"api/words.json";
    NSString *commandURL = [NSString stringWithFormat:@"%@/%@/%@", SERVER, serviceURL, command];

	NSString * res = [self sendSync:commandURL];
	NSDictionary *response = [res JSONValue];

	Word * word = [Word alloc];
	word = [word init:response];

	return word;
}

- (NSArray*) fetchDefinitions:(NSString*)wordstring {
    NSString *command = [NSString stringWithFormat:@"%@/definitions", wordstring];
    NSString *serviceURL = @"api/word.json";
    NSString *commandURL = [NSString stringWithFormat:@"%@/%@/%@", SERVER, serviceURL, command];	
	NSString * res = [self sendSync:commandURL];
	NSArray *response = [res JSONValue];
	
	NSMutableArray * definitions = [[NSMutableArray alloc] init];
	for(NSDictionary * dict in response){
		Definition * def = [[Definition alloc]init:dict];
		[definitions addObject:def];
	}
	
	return definitions;
}

@end
