//
//  DETweetsExtractor.m
//  TwitterSearch
//
//  Created by Arjun Gupta on 11/24/14.
//  Copyright (c) 2014 AG. All rights reserved.
//

#import "DETweetsExtractor.h"
#import "Item.h"
#import "Constants.h"

@implementation DETweetsExtractor


- (NSMutableArray*)extractTweetsFromData:(NSData*)data {
    
    NSDictionary* jsonDict = [self extractJSONFromData:data];
    
    if (jsonDict == nil) {
        DebugLog(@"No tweets extraced");
        return nil;
    }
    
    id itemFeedArrayObj = [jsonDict objectForKey:@"statuses"];
    if (!itemFeedArrayObj || ![itemFeedArrayObj isKindOfClass:[NSArray class]]) {
        DebugLog(@"Incorrect data format");
        return nil;
    }
    
    NSMutableArray *contactsArray = [[NSMutableArray alloc] init];
    
    NSArray *itemFeedArray = (NSArray*)itemFeedArrayObj;
    
    for (NSDictionary *item in itemFeedArray) {
        
        Item *itemObj = [[Item alloc]init];
        
        id textValue = [item objectForKey:@"text"];
        if (textValue && [textValue isKindOfClass:[NSString class]]) {
            
            itemObj.text = textValue;
        }
        else {
            DebugLog(@"Text format seems wrong");
        }
        
        [contactsArray addObject:itemObj];
    }
    
    return contactsArray;
}


@end
