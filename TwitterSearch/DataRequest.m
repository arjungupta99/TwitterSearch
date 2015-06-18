//
//  DataRequest.m
//  TwitterSearch
//
//  Created by Arjun Gupta on 11/24/14.
//  Copyright (c) 2014 AG. All rights reserved.
//

#import "DataRequest.h"
#import "Constants.h"


@interface DataRequest () {
    
    NSURLConnection *_urlConnection;
    NSMutableData *_feedData;
}

@end



@implementation DataRequest


- (void)deployRequestWithURLString:(NSString*)URLString Params:(NSString*)parameters Headers:(NSMutableDictionary*)headers IsPOSTRequest:(BOOL)isPOSTRequest  {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:URLString]];
    
    for (id key in headers.allKeys) {
        NSString *headerValue = [headers objectForKey:key];
        [request setValue:headerValue forHTTPHeaderField:key];
    }
    
    if (isPOSTRequest) {
        [request setHTTPMethod:@"POST"];
    }
    else {
        [request setHTTPMethod:@"GET"];
    }
    
    if (parameters != nil && parameters.length > 0) {
        NSData *requestData = [NSData dataWithBytes:[parameters UTF8String] length:[parameters length]];
        [request setHTTPBody:requestData];
    }
    
    //DebugLog(@"Formulated Request : %@", request.description);
    
    _urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}


- (void)feedReceived:(NSMutableData*)data {
    DebugLog(@"Override me");
}


#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    _feedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [_feedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    if (_feedData.length == 0) {
        DebugLog(@"No data present.");
        return;
    }
    
    [self feedReceived:_feedData];
    
    _urlConnection = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    _urlConnection = nil;
    
    DebugLog(@"Connection failed with error : %@", error.description);
}
@end
