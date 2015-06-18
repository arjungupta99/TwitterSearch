//
//  DRTokenHandler.m
//  TwitterSearch
//
//  Created by Arjun Gupta on 11/24/14.
//  Copyright (c) 2014 AG. All rights reserved.
//

#import "DRTokenHandler.h"
#import "Constants.h"
#import "DETokenExtractor.h"


@interface DRTokenHandler () {
    
    NSString *_consumerKey;
    NSString *_consumerSecret;
}

@end


@implementation DRTokenHandler

- (void)deployRequest  {
    
    _consumerKey = CONSUMER_KEY;
    _consumerSecret = CONSUMER_SECRET;
    
    NSAssert(_consumerKey.length > 0, @"\n\n\n\n\n*** Consumer key not defined ***\n\n\n\n\n");
    NSAssert(_consumerSecret.length > 0, @"\n\n\n\n\n*** Consumer secret key not defined ***\n\n\n\n\n");
    
    //URL
    NSString *urlString = TOKEN_REQUEST_URL;
    NSMutableDictionary *headerDict = [[NSMutableDictionary alloc]init];
    
    //Headers
    NSString *authorizationHeader = [NSString stringWithFormat:@"Basic %@", [self base64BearerTokenCredentials]];
    [headerDict setObject:authorizationHeader forKey:@"Authorization"];
    
    NSString *contentType = @"application/x-www-form-urlencoded;charset=UTF-8";
    [headerDict setObject:contentType forKey:@"Content-Type"];
    
    //Params
    NSString *params = @"grant_type=client_credentials";
    
    //Request
    [self deployRequestWithURLString:urlString
                              Params:params
                             Headers:headerDict
                       IsPOSTRequest:YES];
}


#pragma mark - DataRequest override methods

- (void)feedReceived:(NSMutableData *)data {
    
    DETokenExtractor *tokenExtractor = [[DETokenExtractor alloc]init];
    NSString *token = [tokenExtractor extractTokenFromData:data];
    
    if (self.delegate) {
        if (token && token.length > 0) {
            [self.delegate tokenReceived:token];
            
        }
        else {
            DebugLog(@"Token Error");
            
            [self.delegate tokenError];
        }
    }
}


#pragma mark - Utils

- (NSString*)base64BearerTokenCredentials {
    if (!_consumerKey || !_consumerSecret || _consumerKey.length == 0 || _consumerSecret.length == 0) {
        DebugLog(@"Key seems to be empty");
        return nil;
    }
    
    NSString *encodedConsumerKey = [self encodeKey:_consumerKey];
    NSString *encodedConsumerSecretKey = [self encodeKey:_consumerSecret];
    
    NSString *joinedKeys = [NSString stringWithFormat:@"%@:%@", encodedConsumerKey,encodedConsumerSecretKey];
    
    NSString *base64EncodedString = [[joinedKeys dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    
    return base64EncodedString;
}


- (NSString*)encodeKey:(NSString*)key {
    if (!key || key.length == 0) {
        return nil;
    }
    NSString *encodedKeyValue = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encodedKeyValue;
}

@end
