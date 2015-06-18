//
//  DRTweetsHandler.m
//  TwitterSearch
//
//  Created by Arjun Gupta on 11/24/14.
//  Copyright (c) 2014 AG. All rights reserved.
//

#import "DRTweetsHandler.h"
#import "Constants.h"
#import "DETweetsExtractor.h"


NSString* const ITEM_COUNT = @"20";


@interface DRTweetsHandler () {
    
    DETweetsExtractor *_tweetExtractor;
}

@end


@implementation DRTweetsHandler


- (void)deployRequestWithToken:(NSString*)token AndQuery:(NSString*)query {
    
    if (token == nil || token.length == 0) {
        DebugLog(@"Token is missing");
        return;
    }
    
    DebugLog(@"Search query : %@", query);
    
    //URL
    NSString *urlString = SEARCH_REQUEST_URL;
    NSMutableDictionary *headerDict = [[NSMutableDictionary alloc]init];
    
    //Headers
    NSString *authorizationHeader = [NSString stringWithFormat:@"Bearer %@", token];
    [headerDict setObject:authorizationHeader forKey:@"Authorization"];
    
    NSString *contentType = @"application/x-www-form-urlencoded;charset=UTF-8";
    [headerDict setObject:contentType forKey:@"Content-Type"];
    
    //Params
    //Setting language to 'english', count to '20'
    NSString *encodedQuery = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *params = [NSString stringWithFormat:@"q=%@&lang=%@&count=%@",encodedQuery,@"en",ITEM_COUNT];
    
    //Request
    [self deployRequestWithURLString:urlString
                              Params:params
                             Headers:headerDict
                       IsPOSTRequest:NO];
}


#pragma mark - DataRequest override methods

- (void)feedReceived:(NSMutableData *)data {
    
    if (_tweetExtractor == nil) {
        _tweetExtractor = [[DETweetsExtractor alloc]init];
    }
    NSArray *tweets = [_tweetExtractor extractTweetsFromData:data];
    
    if (self.delegate) {
        if (tweets) {
            [self.delegate tweetsReceived:tweets];
            
        }
        else {
            DebugLog(@"Tweets Error");
            
            [self.delegate tweetsError];
        }
    }
}

@end
