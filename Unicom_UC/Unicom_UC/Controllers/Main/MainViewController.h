//
//  MainViewController.h
//  Unicom_UC
//
//  Created by Andy.NH on 10/16/12.
//  Copyright (c) 2012 Andy.NH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "ContentViewController.h"


@interface MainViewController : UIViewController

@property (nonatomic, weak) LoginViewController *loginViewController;

@property (nonatomic, weak) ContentViewController *contentViewController;

@end
