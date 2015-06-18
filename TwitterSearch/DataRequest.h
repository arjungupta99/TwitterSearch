//
//  DataRequest.h
//  TwitterSearch
//
//  Created by Arjun Gupta on 11/24/14.
//  Copyright (c) 2014 AG. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface DataRequest : NSObject



- (void)deployRequestWithURLString:(NSString*)URLString Params:(NSString*)parameters Headers:(NSMutableDictionary*)headers IsPOSTRequest:(BOOL)isPOSTRequest;

- (void)feedReceived:(NSMutableData*)data;

@end
