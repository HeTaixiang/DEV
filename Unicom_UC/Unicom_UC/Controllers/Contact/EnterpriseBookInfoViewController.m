//
//  EnterpriseBookInfoViewController.m
//  Unicom_UC
//
//  Created by Andy.NH on 10/22/12.
//  Copyright (c) 2012 Andy.NH. All rights reserved.
//

#import "EnterpriseBookInfoViewController.h"

@interface EnterpriseBookInfoViewController ()

@end

@implementation EnterpriseBookInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = TRUE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
