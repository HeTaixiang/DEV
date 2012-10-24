//
//  ShowContentViewStoryboardSegue.m
//  Unicom_UC
//
//  Created by Andy.NH on 10/16/12.
//  Copyright (c) 2012 Andy.NH. All rights reserved.
//

#import "ShowContentViewStoryboardSegue.h"

@implementation ShowContentViewStoryboardSegue

- (void)perform
{
    [self.sourceViewController addChildViewController:self.destinationViewController];
    [self.sourceViewController setValue:self.destinationViewController forKey:@"contentViewController"];
    UIViewController *loginViewController = [self.sourceViewController valueForKey:@"loginViewController"];
    [self.sourceViewController transitionFromViewController:loginViewController toViewController:self.destinationViewController duration:0.5f options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionTransitionCrossDissolve animations:NULL completion:^(BOOL finised){
        [loginViewController removeFromParentViewController];
    }];
}

@end
