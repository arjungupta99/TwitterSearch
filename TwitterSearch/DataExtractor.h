//
//  DataExtractor.h
//  TwitterSearch
//
//  Created by Arjun Gupta on 11/24/14.
//  Copyright (c) 2014 AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataExtractor : NSObject


- (NSDictionary*)extractJSONFromData:(NSData*)data;

@end
