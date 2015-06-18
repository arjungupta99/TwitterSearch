//
//  DETokenExtractor.h
//  TwitterSearch
//
//  Created by Arjun Gupta on 11/24/14.
//  Copyright (c) 2014 AG. All rights reserved.
//

#import "DataExtractor.h"

@interface DETokenExtractor : DataExtractor

- (NSString*)extractTokenFromData:(NSData*)data;

@end
