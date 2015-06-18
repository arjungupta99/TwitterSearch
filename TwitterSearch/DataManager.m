//
//  DataManager.m
//  SendHubChallenge
//
//  Created by Arjun Gupta on 11/24/14.
//  Copyright (c) 2014 AG. All rights reserved.
//

#import "DataManager.h"
#import "Constants.h"

NSString *const kDownloadComplete = @"downloadComplete";
NSString *const kDownloadFailed = @"downloadFailed";
NSString *const kTokenError = @"tokenError";


@interface DataManager() {
    
    DETweetsExtractor *_tweetsExtractor;
    DRTweetsHandler *_tweetsHandler;
    DRTokenHandler *_tokenHandler;
    
    NSString *_token;
}

@end


@implementation DataManager

+ (id)sharedManager {
    static DataManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


- (void)requestToken {
    
    if (self.isBusy) {
        return;
    }
    
    self.isBusy = YES;
    
    if (!_tokenHandler) {
        _tokenHandler = [[DRTokenHandler alloc]init];
        _tokenHandler.delegate = self;
    }
    [_tokenHandler deployRequest];
}


- (BOOL)searchWithQuery:(NSString*)query {
    
    BOOL success = YES;
    
    if (self.isBusy) {
        return NO;
    }
    
    if (_token && _token.length > 0) {
        
        if (!_tweetsHandler) {
            _tweetsHandler = [[DRTweetsHandler alloc]init];
            _tweetsHandler.delegate = self;
        }
        
        [_tweetsHandler deployRequestWithToken:_token AndQuery:query];
    }
    else {
        self.isBusy = NO;
        [self requestToken];
        
        DebugLog(@"Token not present.");
        success = NO;
    }
    return success;
}

#pragma mark - DRTokenHandlerDelegate


- (void)tokenReceived:(NSString *)token {
    
    self.isBusy = NO;
    _token = token;
}

- (void)tokenError {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kTokenError object:nil];
    self.isBusy = NO;
}


#pragma mark - DRTweetsHandlerDelegate


- (void)tweetsReceived:(NSArray *)tweets {
    
    if (!_tweetsExtractor) {
        _tweetsExtractor = [[DETweetsExtractor alloc]init];
    }
    
    self.itemsArray = tweets;
    self.isBusy = NO;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kDownloadComplete object:nil];
}

- (void)tweetsError {
    
    self.isBusy = NO;
}



- (void)dealloc {
    
}


@end
