//
//  ContactViewController.h
//  Unicom_UC
//
//  Created by Andy.NH on 10/17/12.
//  Copyright (c) 2012 Andy.NH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnterpriseBookViewController.h"
#import "PersonalStatementViewController.h"
#ifndef PAD_WIDTH
#define PAD_WIDTH 35
#endif

#define RESULT_SIZE 10


@interface ContactViewController : UIViewController<PersonalStatementViewDelegate, EnterpriseBookViewDelegate>

@property (nonatomic, strong) PersonalStatementViewController *personalStatementViewController;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *selectedIndicator;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)showEnterpriseBook:(id)sender;

- (IBAction)showPersonalBook:(id)sender;

@end
