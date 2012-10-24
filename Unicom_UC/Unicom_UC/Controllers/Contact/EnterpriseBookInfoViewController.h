//
//  EnterpriseBookInfoViewController.h
//  Unicom_UC
//
//  Created by Andy.NH on 10/22/12.
//  Copyright (c) 2012 Andy.NH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnterpriseBookViewController.h"

@protocol EnterpriseBookInfoViewDelegate <NSObject>

- (id) getEnterpriseBookInfoByIdentifier:(NSString *)identifier;

@end


@interface EnterpriseBookInfoViewController : UIViewController

@property(nonatomic, strong) DepartmentContactElement *contactElement;

@property(nonatomic, )

@end
