//
//  FeedListTableVC.m
//  TwitterSearch
//
//  Created by Arjun Gupta on 1/19/15.
//  Copyright (c) 2014 AG. All rights reserved.
//

#import "FeedListTableVC.h"
#import "Item.h"
#import "Constants.h"
#import "TweetCell.h"

@interface FeedListTableVC ()

@end

@implementation FeedListTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.allowsSelection = NO;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.itemsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Reuse identifier defined in storyboard. Cells will be created automatically if none left for reuse.
    TweetCell *cell = (TweetCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (indexPath.row % 2 == 0) {
        cell.contentView.backgroundColor = CELL_EVEN_COLOR;
    }
    else {
        cell.contentView.backgroundColor = CELL_ODD_COLOR;
    }
    
    Item *item = [self.itemsArray objectAtIndex:indexPath.row];
    
    cell.cellLabel.text = item.text;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.textField_search) {
        if ([self.textField_search isFirstResponder]) {
            [self.textField_search resignFirstResponder];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return GLOBAL_CELL_HEIGHT;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
