//
//  DataExtractor.m
//  TwitterSearch
//
//  Created by Arjun Gupta on 11/24/14.
//  Copyright (c) 2014 AG. All rights reserved.
//

#import "DataExtractor.h"
#import "Constants.h"

@implementation DataExtractor


- (NSDictionary*)extractJSONFromData:(NSData*)data {
    
    NSError* error;
    
    NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error];
    
    if (error) {
        DebugLog(@"Error : %@", error.description);
        return nil;
    }
    
    return jsonDict;
}

@end
