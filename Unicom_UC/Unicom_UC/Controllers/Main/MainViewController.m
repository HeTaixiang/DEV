//
//  MainViewController.m
//  Unicom_UC
//
//  Created by Andy.NH on 10/16/12.
//  Copyright (c) 2012 Andy.NH. All rights reserved.
//

#import "MainViewController.h"
#import "Common.h"
#import "MBProgressHUD.h"

@interface MainViewController ()<LoginViewDelegate, MBProgressHUDDelegate>
{
    MBProgressHUD *hud;
}

- (void) progressTaskWithLoginInfo:(NSDictionary *)dic;

- (void)setLatestAccount:(NSString *)latestAccount;

@end

@implementation MainViewController

@synthesize loginViewController;

@synthesize contentViewController;

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
    [self performSegueWithIdentifier:@"showLoginView" sender:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showLoginView"]) {
        [segue.destinationViewController setValue:self forKey:@"loginViewDelegate"];
    }
}


#pragma mark - LoginViewDelegate Method

- (Boolean)loginWithAccount:(NSString *)account withPwd:(NSString *)pwd withProperties:(NSDictionary *)properties
{
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.minSize = CGSizeMake(135.f, 120.f);
    hud.delegate = self;
    [self.view addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"正在登陆。。。";
    [hud showWhileExecuting:@selector(progressTaskWithLoginInfo:) onTarget:self withObject:NULL animated:YES];
    return TRUE;
}

- (NSString *)lastetAccount
{
    return NULL;
}

- (NSDictionary *)latestHistoryWithAccount:(NSString *)account
{
    return NULL;
}




#pragma mark - MBProgressHUDDelegate method

- (void)hudWasHidden:(MBProgressHUD *)progressHUD
{
    [progressHUD removeFromSuperview];
}




#pragma mark - Private Method

- (void)setLatestAccount:(NSString *)latestAccount
{
    
}


- (void)progressTaskWithLoginInfo:(NSDictionary *)dic
{
    sleep(1);
    hud.labelText = @"账户或密码错误！";
    sleep(1);
    [self performSegueWithIdentifier:@"showContentView" sender:self];
}


@end
