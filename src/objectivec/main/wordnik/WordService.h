//
//  RandomWordService.h
//
//  Created by Tony Tam on 5/17/10.
//  Copyright 2010 Wordnik. All rights reserved.
//

#import "BaseWordnikService.h"
#import "Word.h"
#import "Definition.h"

@interface WordService : BaseWordnikService {

}

- (Word*) fetchRandomWord;
- (Word*) fetchRandomWord:(BOOL)onlyDictionaryWord;
- (NSArray*) fetchDefinitions:(NSString*)wordstring;

@end
