//
//  StartVC.m
//  TwitterSearch
//
//  Created by Arjun Gupta on 11/24/14.
//  Copyright (c) 2014 AG. All rights reserved.
//


// ****** NOTE ******

//For a buttonless design, a call is added that gets triggered when the text in the search field changes.
//The call also contains a small time delay to prevent excessive number of API calls while typing.

// ****** **** ******


#import "StartVC.h"
#import "DataManager.h"
#import "Constants.h"

NSInteger const SEARCH_AREA_HEIGHT  = 80;
CGFloat   const TIMER_DELAY         = 0.8;

NSString* const BG_TEXT_START       = @"Let's search for some\ntweets!";
NSString* const BG_TEXT_SEARCH      = @"Searching...";
NSString* const BG_TEXT_NOTWEETS    = @"No tweets discovered";
NSString* const BG_TYPING           = @"Searching..";
NSString* const SEGUE_IDENTIFIER    = @"startVC_feedListTableTableVC_ID";



@interface StartVC () {
    
    NSTimer *_textfieldTimer;
    //UILabel *self.backgroundLabel;
    UITextField *_textField_search;
}

@end

@implementation StartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    //Background
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    backgroundView.backgroundColor = BACKGROUND_COLOR;
    [self.view addSubview:backgroundView];
    backgroundView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
   
    //Feed List View Controller
    self.feedListTableVC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.feedListTableVC.tableView.contentInset = UIEdgeInsetsMake(SEARCH_AREA_HEIGHT, 0, 0, 0);
    self.feedListTableVC.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(SEARCH_AREA_HEIGHT, 0, 0, 0);
    self.feedListTableVC.view.userInteractionEnabled = NO;
    [self.view addSubview:self.feedListTableVC.view];
    
    //Background label for status text
    self.backgroundLabel.textColor = BACKGROUND_LABEL_COLOR;
    self.backgroundLabel.text = BG_TEXT_START;
    [self.view bringSubviewToFront:self.backgroundLabel];
    
    //Background under the textfield
    UIView *headerBackground = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, SEARCH_AREA_HEIGHT)];
    [self.view addSubview:headerBackground];
    headerBackground.backgroundColor = HEADER_COLOR;
    headerBackground.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    //Search Textfield
    _textField_search = [self createTextField];
    [self.view addSubview:_textField_search];
    _textField_search.center = CGPointMake(self.view.center.x, SEARCH_AREA_HEIGHT/2);
    _textField_search.placeholder = @"Enter search query";
    _feedListTableVC.textField_search = _textField_search; //So we can resignFirstResponder on a Tap later on.
    _textField_search.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
    
    //For text change events
    [_textField_search addTarget:self
                          action:@selector(textFieldDidChange:)
                forControlEvents:UIControlEventEditingChanged];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(downloadComplete)
                                                 name:kDownloadComplete
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tokenError)
                                                 name:kTokenError
                                               object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(tapHandle)];
    [backgroundView addGestureRecognizer:tap];
}


- (void)tapHandle {
    if (![_textField_search isFirstResponder]) {
        [_textField_search becomeFirstResponder];
    }
}


- (void)deploySearch {
    _feedListTableVC.view.userInteractionEnabled = YES;
    
    [UIView animateWithDuration:0.4 animations:^{
        
        _feedListTableVC.view.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        //Search call to DataManager
        if (_textField_search.text.length > 0) {
            
            BOOL success = [[DataManager sharedManager] searchWithQuery:_textField_search.text];
            
            //This case will only happen in case a token error.
            if (!success) {
                self.backgroundLabel.alpha = 0;
                self.backgroundLabel.text = @"Token Error. Try again in some time";
                
                [UIView animateWithDuration:0.3 animations:^{
                    self.backgroundLabel.alpha = 1.0;
                }];
            }
        }
        
        self.backgroundLabel.text = BG_TEXT_SEARCH;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.backgroundLabel.alpha = 1.0;
        }];
        
    }];
    
    [_textfieldTimer invalidate];
    _textfieldTimer = nil;
    
}

- (void)downloadComplete {
    
    _feedListTableVC.itemsArray = [[DataManager sharedManager] itemsArray];
    [_feedListTableVC.tableView reloadData];
    
    [UIView animateWithDuration:0.4 animations:^{
        _feedListTableVC.view.alpha = 1.0;
        self.backgroundLabel.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        if (_feedListTableVC.itemsArray.count > 0) {
            self.backgroundLabel.alpha = 0.0;
            self.backgroundLabel.text = BG_TEXT_START;
        }
        else {
            self.backgroundLabel.text = BG_TEXT_NOTWEETS;
            [UIView animateWithDuration:0.3 animations:^{
                self.backgroundLabel.alpha = 1.0;
            }];
        }
    }];
}

- (void)tokenError {
    
    self.backgroundLabel.alpha = 1.0;
    self.backgroundLabel.text = @"Got a token error :-(\nKeys might be wrong";
}




#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _textField_search.placeholder = @"Enter search query";
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundLabel.alpha = 0.0;
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.3 animations:^{
        if ([self.backgroundLabel.text isEqualToString:BG_TEXT_START] && _feedListTableVC.itemsArray.count == 0) {
            
            self.backgroundLabel.alpha = 1.0;
        }
    }];
}

- (void)textFieldDidChange:(UITextField*)textField {
    
    if (_textField_search.text.length > 0) {
        
        [_textfieldTimer invalidate];
        _textfieldTimer = [NSTimer scheduledTimerWithTimeInterval:TIMER_DELAY target:self selector:@selector(deploySearch) userInfo:nil repeats:NO];
        self.backgroundLabel.text = BG_TYPING;
    }
    else {
        
        [_textfieldTimer invalidate];
        _textfieldTimer = nil;
        
        [UIView animateWithDuration:0.4 animations:^{
            _feedListTableVC.view.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            //Empty array. Clear table
            _feedListTableVC.itemsArray = nil;
            [_feedListTableVC.tableView reloadData];
            _feedListTableVC.view.userInteractionEnabled = NO;
            
        }];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundLabel.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.backgroundLabel.text = BG_TEXT_START;
        }];
    }
}



#pragma mark - StoryBoard Segue


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"startVC_feedListTableTableVC_ID"]) {
        self.feedListTableVC = segue.destinationViewController;
        [self addChildViewController:self.feedListTableVC];
        [self.feedListTableVC didMoveToParentViewController:self];
    }
}



#pragma mark - Helpers

- (UITextField*)createTextField
{
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 40, SEARCH_AREA_HEIGHT/2)];
    textField.backgroundColor = [UIColor whiteColor];
    textField.borderStyle = UITextBorderStyleLine;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    [textField setFont:[UIFont fontWithName:@"HelveticaNeue" size:20]];
    textField.textAlignment = NSTextAlignmentCenter;
    textField.layer.cornerRadius=3.0f;
    textField.layer.masksToBounds=YES;
    textField.layer.borderColor=[[UIColor blackColor]CGColor];
    textField.layer.borderWidth= 1.0f;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.delegate = self;
    [textField setReturnKeyType:UIReturnKeyDone];
    [textField setKeyboardType:UIKeyboardTypeTwitter];
    return  textField;
}


-(BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
