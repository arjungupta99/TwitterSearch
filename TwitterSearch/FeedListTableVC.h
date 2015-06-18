//
//  FeedListTableVC.h
//  TwitterSearch
//
//  Created by Arjun Gupta on 11/24/14.
//  Copyright (c) 2014 AG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedListTableVC : UITableViewController


@property (nonatomic, strong) NSMutableArray *itemsArray;
@property (nonatomic, weak) UITextField *textField_search;


@end
