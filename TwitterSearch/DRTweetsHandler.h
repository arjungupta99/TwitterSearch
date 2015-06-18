//
//  DRTweetsHandler.h
//  TwitterSearch
//
//  Created by Arjun Gupta on 11/24/14.
//  Copyright (c) 2014 AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataRequest.h"

@protocol DRTweetsHandlerDelegate <NSObject>

- (void)tweetsReceived:(NSArray*)tweets;
- (void)tweetsError;

@end

@interface DRTweetsHandler : DataRequest

@property (nonatomic, weak) id <DRTweetsHandlerDelegate> delegate;

- (void)deployRequestWithToken:(NSString*)token AndQuery:(NSString*)query;

@end
