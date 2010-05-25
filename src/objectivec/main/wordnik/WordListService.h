//
//  WordListService.h
//
//  Created by Tony Tam on 5/17/10.
//  Copyright 2010 Wordnik. All rights reserved.
//

#import "BaseWordnikService.h"
#import "WordList.h"
#import "Word.h"

@interface WordListService : BaseWordnikService {

}

- (NSArray*) fetchWords:(NSString*)listName;
- (NSArray*) fetchWordLists;
- (NSArray*) fetchWordLists:(int)startAt
				   count:(int)countToFetch;

@end
