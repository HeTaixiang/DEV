//
//  EnterpriseBookViewController.m
//  Unicom_UC
//
//  Created by Andy.NH on 10/17/12.
//  Copyright (c) 2012 Andy.NH. All rights reserved.
//

#import "EnterpriseBookViewController.h"


#pragma mark - Department Contact Element Class

@implementation DepartmentContactElement


@end




#pragma mark - Department Element Class

@implementation DepartmentElement


@end












#pragma mark - DepartmentHeadView Class 

@interface DepartmentHeadView ()

- (void) onClicked;

@end

@implementation DepartmentHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithNibNamed:(NSString *)nibName
{
    self = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:NULL] lastObject];
    if (self) {
        [self addTarget:self action:@selector(onClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)onClicked
{
    if (self.departmentHeadViewDelegate) {
        [self.departmentHeadViewDelegate departmentHeadViewClicked:self];
    }
}

@end















#pragma mark - EnterpriseBookViewController Class

@interface EnterpriseBookViewController ()
{
    Boolean isIndexMode;
    
    NSArray *departmentElements;
    
    NSMutableArray *contactElments;
    
    NSMutableArray *headViewElements;
    
    int pageIndex;
    
    DepartmentElement __weak *currentDepartmentElement;
}

@end

@implementation EnterpriseBookViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isIndexMode = TRUE;
    headViewElements = [NSMutableArray array];
    contactElments = [NSMutableArray array];
    departmentElements = [self.enterpriseBookViewDelegate getDepartmentElements];
    self.clearsSelectionOnViewWillAppear = NO;
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showEnterpriseBookInfoView"]) {
        DepartmentContactElement __weak *tmp = [contactElments objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        [segue.destinationViewController setValue:tmp forKey:@"contactElement"];
    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!isIndexMode) {
        return [headViewElements count];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isIndexMode) {
        return [departmentElements count];
    }else{
        return [contactElments count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isIndexMode) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"departmentCell"];
        DepartmentElement *element = [departmentElements objectAtIndex:indexPath.row];
        cell.textLabel.text = element.name;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"enterpriseBookInfoCell"];
        DepartmentContactElement *element = [contactElments objectAtIndex:indexPath.row];
        cell.imageView.image = element.icon;
        cell.imageView.bounds = CGRectMake(0, 0, 35, 35);
        cell.textLabel.text = element.name;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!isIndexMode) {
        return [headViewElements objectAtIndex:section];
    }else{
        return NULL;
    }
}





#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isIndexMode) {
        DepartmentHeadView *departmentHeadView = [[DepartmentHeadView alloc] initWithNibNamed:@"DepartmentHeadView.xib"];
        [departmentHeadView setDepartmentHeadViewDelegate:self];
        DepartmentElement *element = [departmentElements objectAtIndex:indexPath.row];
        departmentHeadView.departmentLabel.text = element.name;
        [headViewElements addObject:departmentHeadView];
        
        pageIndex = 0;
        currentDepartmentElement = element;
        NSArray *tmp = [self.enterpriseBookViewDelegate getDepartmentContactElementsWithDepartmentIdentifier:element.identifier withPageIndex:pageIndex++ withPageSize:20];
        
        if (tmp && [tmp count] > 0) {
            [contactElments addObjectsFromArray:tmp];
        }
        
        isIndexMode = FALSE;
        [self.tableView reloadData];
    }else{
        [self performSegueWithIdentifier:@"showEnterpriseBookInfoView" sender:self];
        
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!isIndexMode && indexPath.row == [contactElments count]-1) {
        UIView *footView = [[[NSBundle mainBundle] loadNibNamed:@"DepartmentFootView.xib" owner:self options:NULL] lastObject];
        self.tableView.tableFooterView = footView;
        NSArray *tmp = [self.enterpriseBookViewDelegate getDepartmentContactElementsWithDepartmentIdentifier:currentDepartmentElement.identifier withPageIndex:pageIndex++ withPageSize:20];
        
        if (tmp && [tmp count] > 0) {
            [contactElments addObject:tmp];
            [tableView reloadData];
        }else{
            self.tableView.tableFooterView = NULL;
            [tableView reloadData];
        }
        
    }else{
        self.tableView.tableFooterView = NULL;
    }
}


- (NSInteger) tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isIndexMode) {
        DepartmentElement __weak *element = [departmentElements objectAtIndex:indexPath.row];
        return element.childrenLevel;
    }else{
        return 1;
    }
}



#pragma mark - Scroll View Delegate Method

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"begain Dragging");
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"end dragging decelerate %d", decelerate);
    NSLog(@"%f", scrollView.contentOffset.y);
    
}


#pragma mark - Department Head View Delegate Method

- (void)departmentHeadViewClicked:(DepartmentHeadView *)departmentHeadView
{
    isIndexMode = TRUE;    
    [self.tableView reloadData];
}

@end
