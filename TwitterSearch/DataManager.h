//
//  DataManager.h
//  SendHubChallenge
//
//  Created by Arjun Gupta on 11/24/14.
//  Copyright (c) 2014 AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DRTokenHandler.h"
#import "DRTweetsHandler.h"
#import "DETweetsExtractor.h"


extern NSString *const kDownloadComplete;
extern NSString *const kDownloadFailed;
extern NSString *const kTokenError;

@class DMPostMessage;

@interface DataManager : NSObject <DRTokenHandlerDelegate, DRTweetsHandlerDelegate>


@property (nonatomic, strong) NSArray *itemsArray;
@property (nonatomic ,assign) BOOL isBusy;


+ (id)sharedManager;
- (void)requestToken;
- (BOOL)searchWithQuery:(NSString*)query;

@end
