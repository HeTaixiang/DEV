//
//  PersonalStatementViewController.m
//  Unicom_UC
//
//  Created by Andy.NH on 10/17/12.
//  Copyright (c) 2012 Andy.NH. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PersonalStatementViewController.h"
#import "Common.h"


@interface GroupHeaderView  ()
{
    uint totalNum;
    
    uint currentNum;
    
    Boolean isOpen;
    
}

- (void) onClick;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLable;

@property (weak, nonatomic) IBOutlet UIImageView *flagButton;


@end

@implementation GroupHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        isOpen = NO;
        totalNum = 0;
        currentNum = 0;
        [self addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (id)initWithNibNamed:(NSString *)nibName
{
    self = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:NULL] lastObject];
    if (self) {
        isOpen = NO;
        totalNum = 0;
        currentNum = 0;
        [self addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setTotal:(uint)total
{
    if (total == 0) {
        totalNum = total;
        [_countLable setText:@""];
    }else if (total > 0 && total >= currentNum) {
        currentNum = total;
        [_countLable setText:[NSString stringWithFormat:@"%d/%d", currentNum, totalNum]];
    }
}

- (void)setCurrent:(uint)current
{
    if (currentNum <= totalNum) {
        currentNum = current;
        [_countLable setText:[NSString stringWithFormat:@"%d/%d", currentNum, totalNum]];
    }
}

- (uint)getCurrent
{
    return currentNum;
}

- (uint)getTotal
{
    return totalNum;
}

- (void)setTitle:(NSString *)title
{
    if (title) {
        [_titleLabel setText:title];
    }
}


- (Boolean)isOpen
{
    return isOpen;
}

- (void)setOpen:(Boolean)open
{
    isOpen = open;
}

- (void)onClick
{    
    if (self.groupHeaderViewDelegate) {
        [self.groupHeaderViewDelegate groupHeaderView:self withUnfold:isOpen];
    }
}
@end







@interface PersonalStatementViewController ()<UITableViewDataSource, UITableViewDelegate>

- (void)setShowPersnalStatementWithAnimation:(Boolean)isShow;

@end

@implementation PersonalStatementViewController

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
    [self setShowPersnalStatementWithAnimation:YES];
	// Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setShowPersnalStatementWithAnimation:NO];
}


#pragma mark - UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0: return [tableView dequeueReusableCellWithIdentifier:@"onlineCell"];
    
        case 1: return [tableView dequeueReusableCellWithIdentifier:@"offlineCell"];
                    
        default: return [tableView dequeueReusableCellWithIdentifier:@"busyCell"];
    }
}


#pragma mark - UITableViewDelegate Method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setShowPersnalStatementWithAnimation:NO];
    [self.personalStatementViewDelegate setPersonalStatement:PersonalStatementNone];
}


#pragma mark - Private Method

- (void)setShowPersnalStatementWithAnimation:(Boolean)isShow
{
    CALayer *tableViewLayer = self.tableView.layer;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    CGPoint point = CGPointMake(tableViewLayer.position.x, tableViewLayer.position.y + 154);
    if (isShow) {
        animation.fromValue = [NSValue valueWithCGPoint:point];
        animation.toValue = [tableViewLayer valueForKey:@"position"];
    }else{
        animation.fromValue = [tableViewLayer valueForKey:@"position"];
        animation.toValue = [NSValue valueWithCGPoint:point];
    }
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.duration = 0.5f;
    [tableViewLayer addAnimation:animation forKey:NULL];
}

- (IBAction)clickBackground:(id)sender {
    [self setShowPersnalStatementWithAnimation:NO];
    [self.personalStatementViewDelegate setPersonalStatement:PersonalStatementNone];
}
@end
