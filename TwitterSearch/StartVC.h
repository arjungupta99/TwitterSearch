//
//  StartVC.h
//  TwitterSearch
//
//  Created by Arjun Gupta on 11/24/14.
//  Copyright (c) 2014 AG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedListTableVC.h"



@interface StartVC : UIViewController<UITextFieldDelegate>

@property (weak,nonatomic) FeedListTableVC * feedListTableVC;
@property (weak, nonatomic) IBOutlet UILabel *backgroundLabel;

@end
