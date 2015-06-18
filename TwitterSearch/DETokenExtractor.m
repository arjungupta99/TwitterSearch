//
//  DETokenExtractor.m
//  TwitterSearch
//
//  Created by Arjun Gupta on 11/24/14.
//  Copyright (c) 2014 AG. All rights reserved.
//

#import "DETokenExtractor.h"
#import "Constants.h"

@implementation DETokenExtractor

- (NSString*)extractTokenFromData:(NSData*)data {
    
    NSDictionary *jsonDict = [self extractJSONFromData:data];
    
    if (jsonDict == nil) {
        DebugLog(@"No token extraced");
        return nil;
    }
    
    id statusObj = [jsonDict objectForKey:@"access_token"];
    if (!statusObj || ![statusObj isKindOfClass:[NSString class]]) {
        DebugLog(@"Incorrect data format");
        return nil;
    }
    
    NSString *bearerToken = (NSString*)statusObj;
    
    
    if (bearerToken.length == 0) {
        DebugLog(@"Error : Token not found!");
        return nil;
    }
    else {
        DebugLog(@"Success! Token Received!");
    }
    
    return bearerToken;
}

@end
