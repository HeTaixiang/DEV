//
//  ContactViewController.m
//  Unicom_UC
//
//  Created by Andy.NH on 10/17/12.
//  Copyright (c) 2012 Andy.NH. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ContactViewController.h"
#import "PersonalStatementViewController.h"

@interface ContactViewController ()<UIScrollViewDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate>
{
    int currentPage;
    
}

- (void)initScrollView;

- (void) showSelectedInDicatorWithIndex:(int) index;

- (void) scrollViewToPage:(int) page;


@end




@implementation ContactViewController


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
	[self performSegueWithIdentifier:@"appendEnterpriseBookView" sender:self];
    [self performSegueWithIdentifier:@"appendPersonalView" sender:self];
    currentPage = 0;    
    [self initScrollView];

}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"showPersonalStatementView"]) {
        [segue.destinationViewController setValue:self forKey:@"personalStatementViewDelegate"];
    }else if([[segue identifier] isEqualToString:@"appendEnterpriseBookView"] || [[segue identifier] isEqualToString:@"appendPersonalView"]){
        [segue.destinationViewController setValue:self.navigationController forKey:@"navigationController"];
    }
}


- (void)viewDidUnload {
    [self setScrollView:NULL]; 
    [self setSelectedIndicator:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
}



#pragma mark - PersonalStatementViewDelegate Method

- (void)setPersonalStatement:(PersonalStatement)statement
{
    
    [UIView animateWithDuration:0.5f animations:^{
        self.personalStatementViewController.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.personalStatementViewController.view removeFromSuperview];
        [self.personalStatementViewController removeFromParentViewController];
        self.personalStatementViewController = NULL;
    }];
    
}


#pragma mark - Enterprise Book View Delegate Method

- (NSArray *)getDepartmentContactElementsWithDepartmentIdentifier:(NSString *)identifier withPageIndex:(int)pageIndex withPageSize:(int)size
{
    return NULL;
}

- (NSArray *)getDepartmentElements
{
    return NULL;
}



#pragma mark - ScrollView Delegate Method

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
	CGFloat pageWidth = sender.frame.size.width;
    int number = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth)+ 1;
    if (number != currentPage) {
        [self showSelectedInDicatorWithIndex:number];
        currentPage = number;
        //设置默认的ScopeButton值
        self.searchBar.selectedScopeButtonIndex = currentPage;
    }
}



#pragma mark - UISearchDisplayController Delegate Method

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    CALayer *layer = controller.searchBar.layer;
    layer.position  = CGPointMake(layer.position.x, layer.position.y - 44);
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    CALayer *layer = controller.searchBar.layer;
    layer.position  = CGPointMake(layer.position.x, layer.position.y + 44);
}



#pragma mark - Table View Data Source Delegate Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.searchBar.selectedScopeButtonIndex == 2) {
        return 2;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NULL;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return NULL;
}



#pragma mark - Private Method

- (void)initScrollView
{
    float width = _scrollView.frame.size.width;
    float higth = _scrollView.frame.size.height;
    
    self.scrollView.contentSize = CGSizeMake(width * 2, higth);
    for (int i = 0; i < [self.childViewControllers count]; i++) {
        UIViewController __weak *tmp = [self.childViewControllers objectAtIndex:i];
        tmp.view.frame = CGRectMake(width * i, 0, width, higth);
        [self.scrollView addSubview:tmp.view];
    }
    
}

- (void)showSelectedInDicatorWithIndex:(int) index;
{
    if (index != currentPage) {
        CALayer *layer = _selectedIndicator.layer;
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.fromValue = [layer valueForKey:@"position"];
        CGPoint targetPosition = CGPointMake(layer.position.x + PAD_WIDTH*(index - currentPage), layer.position.y);
        animation.toValue = [NSValue valueWithCGPoint:targetPosition];
        layer.position = targetPosition;
        [layer addAnimation:animation forKey:NULL];
    }
}


- (void)scrollViewToPage:(int)page
{
    CGRect frame = self.scrollView.frame;
    frame.origin.x = self.scrollView.frame.size.width * page;
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

- (IBAction)showEnterpriseBook:(id)sender {
    [self scrollViewToPage:0];
}

- (IBAction)showPersonalBook:(id)sender {
    [self scrollViewToPage:1];
}
@end
