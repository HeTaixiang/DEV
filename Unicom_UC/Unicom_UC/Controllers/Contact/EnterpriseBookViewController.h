//
//  EnterpriseBookViewController.h
//  Unicom_UC
//
//  Created by Andy.NH on 10/17/12.
//  Copyright (c) 2012 Andy.NH. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark Department Contact Element Class

@interface DepartmentContactElement : NSObject

@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *identifier;

@end













#pragma mark Department Element Class

@interface DepartmentElement : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *identifier;
@property(nonatomic) int childrenLevel;

@end















#pragma mark Department Head View Class

@class DepartmentHeadView;
@protocol DepartmentHeadViewDelegate <NSObject>

- (void)departmentHeadViewClicked:(DepartmentHeadView *)departmentHeadView;

@end

@interface DepartmentHeadView : UIControl

@property (weak, nonatomic) id<DepartmentHeadViewDelegate> departmentHeadViewDelegate;
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *NumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *background;

- (id) initWithNibNamed:(NSString *)nibName;

@end














#pragma mark Enterprise Book View Class

@class EnterpriseBookViewController;
@protocol EnterpriseBookViewDelegate <NSObject>

- (NSArray *) getDepartmentElements;

- (NSArray *) getDepartmentContactElementsWithDepartmentIdentifier:(NSString *)identifier withPageIndex:(int)pageIndex withPageSize:(int)size;

@end

@interface EnterpriseBookViewController : UITableViewController<DepartmentHeadViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) id<EnterpriseBookViewDelegate> enterpriseBookViewDelegate;

@property (weak, nonatomic) UINavigationController *navigationController;

@end
