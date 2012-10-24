//
//  AppendChildrenViewControllerStoryboardSegue.m
//  Unicom_UC
//
//  Created by Andy.NH on 10/17/12.
//  Copyright (c) 2012 Andy.NH. All rights reserved.
//

#import "AppendChildrenViewControllerStoryboardSegue.h"

@implementation AppendChildrenViewControllerStoryboardSegue

- (void)perform
{
    [self.sourceViewController addChildViewController:self.destinationViewController];
}

@end
