//
//  PersonalStatementViewController.h
//  Unicom_UC
//
//  Created by Andy.NH on 10/17/12.
//  Copyright (c) 2012 Andy.NH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PersonalStatementNone     = 0,
    PersonalStatementOnline   = 1,
    PersonalStatementOffline  = 1 << 1,
    PersonalStatementBusy     = 1 << 2
} PersonalStatement;


@class GroupHeaderView;
@protocol GroupHeaderViewDelegate <NSObject>

- (void) groupHeaderView:(GroupHeaderView *) groupHeaderView withUnfold:(Boolean)isUnfold;

@end

@interface GroupHeaderView : UIControl

@property (nonatomic, weak) id<GroupHeaderViewDelegate> groupHeaderViewDelegate;

- (id) initWithNibNamed:(NSString *)nibName;

- (void) setTotal:(uint) total;

- (void) setCurrent:(uint)current;

- (void) setTitle:(NSString *)title;

- (uint) getTotal;

- (uint) getCurrent;

- (Boolean) isOpen;

- (void) setOpen:(Boolean)open;


@end





@protocol PersonalStatementViewDelegate <NSObject>

- (void) setPersonalStatement:(PersonalStatement)statement;

@end





@interface PersonalStatementViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) id<PersonalStatementViewDelegate> personalStatementViewDelegate;

- (IBAction)clickBackground:(id)sender;

@end
