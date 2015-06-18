//
//  DRTokenHandler.h
//  TwitterSearch
//
//  Created by Arjun Gupta on 11/24/14.
//  Copyright (c) 2014 AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataRequest.h"

@protocol DRTokenHandlerDelegate <NSObject>

- (void)tokenReceived:(NSString*)token;
- (void)tokenError;

@end

@interface DRTokenHandler : DataRequest

@property (nonatomic, weak) id <DRTokenHandlerDelegate> delegate;


- (void)deployRequest;

@end
