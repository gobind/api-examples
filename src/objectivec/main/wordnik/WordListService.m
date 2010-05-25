//
//  WordListService.m
//
//  Created by Tony Tam on 5/17/10.
//  Copyright 2010 Wordnik. All rights reserved.
//

#import "WordListService.h"

@implementation WordListService

- (NSArray*) fetchWordLists{

}

- (NSArray*) fetchWords:(NSString*)listName {
    NSString *serviceURL = @"api/wordList.json";
    NSString *command = [NSString stringWithFormat:@"%@/words", [listName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSString *commandURL = [NSString stringWithFormat:@"%@/%@/%@", SERVER, serviceURL, command];	
	NSString * res = [self sendSync:commandURL];
	NSArray *response = [res JSONValue];
	
	NSMutableArray * wordsInList = [[NSMutableArray alloc]init];
	for(NSDictionary * dict in response){
		Word * w = [Word alloc];
		w = [w init:dict];
		[wordsInList addObject:w];
	}
	
	return wordsInList;
}

- (NSArray*) fetchWordLists:(int)startAt
					  count:(int)countToFetch {
    NSString *serviceURL = @"api/wordLists.json";
    NSString *command = [NSString stringWithFormat:@"?offset=%d&count=%d", startAt, countToFetch];
    NSString *commandURL = [NSString stringWithFormat:@"%@/%@%@", SERVER, serviceURL, command];	
	NSString * res = [self sendSync:commandURL];
	NSArray *response = [res JSONValue];
	
	NSMutableArray * wordLists = [[NSMutableArray alloc] init];
	for(NSDictionary * dict in response){
		WordList * wl = [WordList alloc];
		wl = [wl init:dict];
		[wl retain];
		[wordLists addObject:wl];
	}
	
	return wordLists;
}

@end
